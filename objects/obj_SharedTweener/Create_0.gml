/// @description Initialization v1.20
// Feather disable all
/*
	Proverbs 3:5-8
	Trust in the Lord with all your heart and lean not on your own understanding;
	in all your ways submit to him, and he will make your paths straight.
	Do not be wise in your own eyes; fear the Lord and shun evil.
	This will bring health to your body and nourishment to your bones.
*/


// MAKE SURE NO TWEENER IS DEACTIVATED
instance_activate_object(obj_SharedTweener);

// CLAIM SELF AS TWEENER IF NONE IS ASSIGNED
if (global.TGMS_SharedTweener == noone)
{
	global.TGMS_SharedTweener = id;
}
else // DESTROY SELF IF A TWEENER ALREADY EXISTS
if (instance_exists(global.TGMS_SharedTweener))
{
	instance_destroy(id, false);
	exit;
}
else // ASSIGN SELF AS NEW TWEENER -- OLD ENVIRONMENT WILL BE CLEANED UP FURTHER DOWN
{
	global.TGMS_SharedTweener = id;	
}

image_speed = 0;

//-----------------------------------------------
// Declare default global system-wide settings
//-----------------------------------------------
global.TGMS_IsEnabled = true;         // System's active state boolean
global.TGMS_TimeScale = 1.0;          // Effects overall speed of how fast system plays tweens/delays
global.TGMS_MinDeltaFPS = 10;         // The lowest framerate before delta tweens will begin to lag behind (Ideally, keep between 10-15)
global.TGMS_UpdateInterval = 1.0;     // Sets how often (in steps) system will update (1 = default, 2 = half speed, 0.5 = double speed) DO NOT set as 0 or below!
global.TGMS_AutoCleanIterations = 10; // Limits, each step, number of tweens passively checked by memory manager (Default:10)
global.TGMS_EasyDelta = false;		  // Simple tweens use delta time?
global.TGMS_TweensIncludeDeactivated = false; // Whether or not tweens associated with deactivated targets should be included with TWEEN SELECTION scripts

// Global system-wide settings
isEnabled = global.TGMS_IsEnabled;                     // System's active state flag
timeScale = global.TGMS_TimeScale;                     // Global time scale of tweening engine
timeScaleDelta = timeScale * delta_time/1000000;	   // Global time scale effected by delta timing
minDeltaFPS = global.TGMS_MinDeltaFPS;                 // Minimum frame rate before delta time will lag behind
updateInterval = global.TGMS_UpdateInterval;           // Step interval to update system (default = 1)
autoCleanIterations = global.TGMS_AutoCleanIterations; // Number of tweens to check each step for auto-cleaning

// System maintenance variables
tick = 0;                            // System update timer
autoCleanIndex = 0;                  // Used to track index when processing passive memory manager
keepPersistent = false;              // Becomes true if tweening used in persistent room
maxDelta = 1/minDeltaFPS;            // Cache delta cap
deltaTime = delta_time/1000000;      // Let's make delta time more practical to work with, shall we?
prevDeltaTime = deltaTime;           // Holds delta time from previous step
deltaRestored = false;               // Used to help maintain predictable delta timing
addDelta = 0.0;                      // Amount to add to delta time if update interval not reached
flushDestroyed = false;              // Flag to indicate if destroyed tweens should be immediately cleared
isDestroyed = false;                 // Flag to ensure Destroy/Room_End events only called when appropriate
tweensProcessNumber = 0;             // Number of tweens to be actively processed in update loop
delaysProcessNumber = 0;             // Number of delays to be actively processed in update loop
inUpdateLoop = false;                // Is tweening system actively processing tweens?
doDestroy = false;                   // Should we delay the destruction of shared tweener?
firstDestroy = true;                 // Used for handling destructiond code

// Required data structures
tweens = ds_list_create();           // Stores automated step tweens
delayedTweens = ds_list_create();    // Stores tween delay data
simpleTweens = ds_map_create();      // Used for simple tweens
pRoomTweens = ds_map_create();       // Associates persistent rooms with stored tween lists
pRoomDelays = ds_map_create();       // Associates persistent rooms with stored tween delay lists
eventCleaner = ds_priority_create(); // Used to clean callbacks from events
stateChanger = ds_queue_create();	 // Used to delay change of tween state when in the update loop


// Clean up any pre-existing environment
with(global.TGMS_Environment)
{
	// Destroy tweens for persistent rooms
	var _key = ds_map_find_first(pRoomTweens);
		
	repeat(ds_map_size(pRoomTweens))
	{
		// Delete stored delays
		ds_queue_destroy(ds_map_find_value(pRoomDelays, _key));
    
		// Get stored tweens queue
		var _queue = ds_map_find_value(pRoomTweens, _key);
    
		// Destroy all stored tweens in queue
		repeat(ds_queue_size(_queue))
		{
			var _t = ds_queue_dequeue(_queue); // Get next tween from room's queue
			_t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
			_t[@ TWEEN.ID] = undefined; // Nullify self reference
        
			// Destroy tween events if events map exists
			if (_t[TWEEN.EVENTS] != -1)
			{
			    var _events = _t[TWEEN.EVENTS];        // Cache events
			    var _key = ds_map_find_first(_events); // Find key to first event
            
			    // Cycle through and destroy all events
			    repeat(ds_map_size(_events))
			    {
			        ds_list_destroy(_events[? _key]);       // Destroy event list
			        _key = ds_map_find_next(_events, _key); // Find key for next event
			    }
            
			    ds_map_destroy(_events); // Destroy events map
			}
		}
    
		ds_queue_destroy(_queue); // Destroy room's queue for stored tweens
		_key = ds_map_find_next(pRoomTweens, _key);
	}
	/// END OF TGMS_CLEAR()

	//---------------------------------------------
	// Destroy remaining tweens
	//---------------------------------------------
	var _tweens = tweens;
	var _tIndex = -1;
	repeat(ds_list_size(_tweens))
	{   
		var _t = _tweens[| ++_tIndex];             // Get tween and increment iterator
		_t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
		_t[@ TWEEN.ID] = undefined;                // Nullify self reference
    
		// Destroy tween events if events map exists
		if (_t[TWEEN.EVENTS] != -1)
		{
		    var _events = _t[TWEEN.EVENTS]; // Cache events
        
		    // Iterate through events
		    repeat(ds_map_size(_events))
		    {
		        ds_list_destroy(_events[? ds_map_find_first(_events)]); // Destroy event list
		        ds_map_delete(_events, ds_map_find_first(_events));     // Delete event key   
		    }
        
		    // Destroy events map and invalidate tween's reference
		    ds_map_destroy(_events);
		    _t[@ TWEEN.EVENTS] = -1; // :: Do I need this?
		}
	}

	//---------------------------------------
	// Destroy Data Structures
	//---------------------------------------
	ds_list_destroy(tweens);
	ds_list_destroy(delayedTweens);
	ds_map_destroy(simpleTweens);
	ds_map_destroy(pRoomTweens);
	ds_map_destroy(pRoomDelays);
	ds_priority_destroy(eventCleaner);
	ds_queue_destroy(stateChanger);
}
	
// Clear Persistent Data Structures
ds_map_clear(global.TGMS_MAP_TWEEN);
ds_stack_clear(global.TGMS_TweensStack);

global.TGMS_INDEX_TWEEN = 1; // Reset the tween id index
global.TGMS_SharedTweener = id; // Set self as the shared tweener

// Set current environment variables for later cleaning
global.TGMS_Environment = {};
global.TGMS_Environment.tweens = tweens;
global.TGMS_Environment.delayedTweens = delayedTweens;
global.TGMS_Environment.simpleTweens = simpleTweens;
global.TGMS_Environment.pRoomTweens = pRoomTweens;
global.TGMS_Environment.pRoomDelays = pRoomDelays;
global.TGMS_Environment.eventCleaner = eventCleaner;
global.TGMS_Environment.stateChanger = stateChanger;

//---------------------------
// Create Default Tween
//---------------------------
global.TGMS_TweenDefault = [];
global.TGMS_TweenDefault[@ TWEEN.ID] = 0;
global.TGMS_TweenDefault[@ TWEEN.TARGET] = noone;
global.TGMS_TweenDefault[@ TWEEN.EASE] = EaseLinear;
global.TGMS_TweenDefault[@ TWEEN.TIME] = 0;
global.TGMS_TweenDefault[@ TWEEN.START] = 0;
global.TGMS_TweenDefault[@ TWEEN.CHANGE] = 1;
global.TGMS_TweenDefault[@ TWEEN.DURATION] = 1;
global.TGMS_TweenDefault[@ TWEEN.PROPERTY] = "";
global.TGMS_TweenDefault[@ TWEEN.PROPERTY_RAW] = 0;
global.TGMS_TweenDefault[@ TWEEN.VARIABLE] = "";
global.TGMS_TweenDefault[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
global.TGMS_TweenDefault[@ TWEEN.TIME_SCALE] = 1;
global.TGMS_TweenDefault[@ TWEEN.DELTA] = false;
global.TGMS_TweenDefault[@ TWEEN.GROUP] = 0;
global.TGMS_TweenDefault[@ TWEEN.EVENTS] = -1;
global.TGMS_TweenDefault[@ TWEEN.DESTROY] = 1;
global.TGMS_TweenDefault[@ TWEEN.DIRECTION] = 1;
global.TGMS_TweenDefault[@ TWEEN.MODE] = TWEEN_MODE_ONCE;
global.TGMS_TweenDefault[@ TWEEN.DATA] = 0;
global.TGMS_TweenDefault[@ TWEEN.DELAY] = -1;
global.TGMS_TweenDefault[@ TWEEN.DELAY_START] = 0;

// Assign default tween as first in global id map
global.TGMS_MAP_TWEEN[? 1] = global.TGMS_TweenDefault;

// Assign [all] as shortcut for affecting all tweens with tween calls
global.TGMS_MAP_TWEEN[? all] = "10";





