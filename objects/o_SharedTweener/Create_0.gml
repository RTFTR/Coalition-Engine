/*
	Proverbs 3:5-8
	Trust in the Lord with all your heart and lean not on your own understanding;
	in all your ways submit to him, and he will make your paths straight.
	Do not be wise in your own eyes; fear the Lord and shun evil.
	This will bring health to your body and nourishment to your bones.
*/

/// @desc [TweenGMX 1.0.0 RC1]
/// Feather ignore all

TGMX_2_EaseFunctions();
TGMX_7_Properties();

// MAKE SURE NO TWEENER IS DEACTIVATED
instance_activate_object(o_SharedTweener);

// CLAIM SELF AS TWEENER IF NONE IS ASSIGNED
if (global.TGMX.SharedTweener == noone)
{
	global.TGMX.SharedTweener = id;
}
else // DESTROY SELF IF A TWEENER ALREADY EXISTS
if (instance_exists(global.TGMX.SharedTweener))
{
	instance_destroy(id, false);
	exit;
}
else // CLEAN UP PREVIOUS ENVIRONMENT AND ASSIGN SELF AS NEW TWEENER
{
	TGMX_Cleanup();
	global.TGMX.SharedTweener = id;	
}

// ATTEMPT TO "STAY OUT OF THE WAY"
x = -100000; y = -100000;

// GLOBAL SYSTEM-WISE SETTINGS
isEnabled = global.TGMX.IsEnabled;                     // System's active state flag
timeScale = global.TGMX.TimeScale;                     // Global time scale of tweening engine
minDeltaFPS = global.TGMX.MinDeltaFPS;                 // Minimum frame rate before delta time will lag behind
updateInterval = global.TGMX.UpdateInterval;           // Step interval to update system (default = 1)
autoCleanIterations = global.TGMX.AutoCleanIterations; // Number of tweens to check each step for auto-cleaning

// SYSTEM MAINTENANCE VARIABLES
tick = 0;									 // System update timer
autoCleanIndex = 0;							 // Used to track index when processing passive memory manager
maxDelta = 1/minDeltaFPS;					 // Cache delta cap
deltaTime = 1/game_get_speed(gamespeed_fps); // Let's make delta time more practical to work with, shall we?
prevDeltaTime = deltaTime;					 // Holds delta time from previous step
deltaRestored = false;						 // Used to help maintain predictable delta timing
addDelta = 0;								 // Amount to add to delta time if update interval not reached
flushDestroyed = false;						 // Flag to indicate if destroyed tweens should be immediately cleared
tweensProcessNumber = 0;					 // Number of tweens to be actively processed in update loop
delaysProcessNumber = 0;					 // Number of delays to be actively processed in update loop
inUpdateLoop = false;						 // Is tweening system actively processing tweens?

// REQUIRED DATA STRUCTURES
tweens = ds_list_create();           // Stores automated step tweens
delayedTweens = ds_list_create();    // Stores tween delay data
pRoomTweens = ds_map_create();       // Associates persistent rooms with stored tween lists
pRoomDelays = ds_map_create();       // Associates persistent rooms with stored tween delay lists
eventCleaner = ds_priority_create(); // Used to clean callbacks from events
stateChanger = ds_queue_create();	 // Used to delay change of tween state when in the update loop

// THESE ARE USED TO CLEAN UP THE SYSTEM AFTER SHARED TWEENER IS ALREADY GONE
global.TGMX.tweens = tweens;
global.TGMX.delayedTweens = delayedTweens;
global.TGMX.pRoomTweens = pRoomTweens;
global.TGMX.pRoomDelays = pRoomDelays;
global.TGMX.eventCleaner = eventCleaner;
global.TGMX.stateChanger = stateChanger;

// SET DEFAULTS FOR TWEEN USER PROPERTIES
TWEEN_USER_GET = 0;
TWEEN_USER_VALUE = 0;
TWEEN_USER_DATA = undefined;
TWEEN_USER_TARGET = noone;

// DEFINE METHODS
/// @ignore
function EaseSwap(_t)
{
	// SWAP DURATION //
	if (is_array(_t[TGMX_T_DURATION_RAW]))
	{
		if (_t[TGMX_T_DURATION] == _t[TGMX_T_DURATION_RAW][0])
		{
			_t[@ TGMX_T_DURATION] = _t[TGMX_T_DURATION_RAW][1];
			// NOTE: This silently updates the internal time value... be careful!
			
			if (_t[TGMX_T_MODE] <= TWEEN_MODE_PATROL)
			{
				_t[@ TGMX_T_TIME] += _t[TGMX_T_DURATION_RAW][1] - _t[TGMX_T_DURATION_RAW][0];
			}
		}
		else
		{
			_t[@ TGMX_T_DURATION] = _t[TGMX_T_DURATION_RAW][0];
		}
	}
	
	// SWAP EASE ALGORITHM //
	if (is_array(_t[TGMX_T_EASE_RAW]))
	{
		// Deal with method ease
		if (is_method(_t[TGMX_T_EASE]))
		{
			if (is_method(_t[TGMX_T_EASE_RAW][0]))
			{
				if (method_get_index(_t[TGMX_T_EASE]) == method_get_index(_t[TGMX_T_EASE_RAW][0]))
				{
					_t[@ TGMX_T_EASE] = _t[TGMX_T_EASE_RAW][1];
				}
				else
				{
					_t[@ TGMX_T_EASE] = _t[TGMX_T_EASE_RAW][0];
				}
			}
			else
			{
				if (method_get_index(_t[TGMX_T_EASE]) == _t[TGMX_T_EASE_RAW][0])
				{
					_t[@ TGMX_T_EASE] = _t[TGMX_T_EASE_RAW][1];
				}
				else
				{
					_t[@ TGMX_T_EASE] = _t[TGMX_T_EASE_RAW][0];
				}
			}
		}
		else // animation channel
		{
			if (is_method(_t[TGMX_T_EASE_RAW][0]))
			{
				if (_t[TGMX_T_EASE] == method_get_index(_t[TGMX_T_EASE_RAW][0]))
				{
					_t[@ TGMX_T_EASE] = _t[TGMX_T_EASE_RAW][1];
				}
				else
				{
					_t[@ TGMX_T_EASE] = _t[TGMX_T_EASE_RAW][0];
				}
			}
			else
			{
				if (_t[TGMX_T_EASE] == _t[TGMX_T_EASE_RAW][0])
				{
					_t[@ TGMX_T_EASE] = _t[TGMX_T_EASE_RAW][1];
				}
				else
				{
					_t[@ TGMX_T_EASE] = _t[TGMX_T_EASE_RAW][0];
				}
			}
		}
	}
}

/// @ignore
function TweenHasReachedBounds(_t, _target, _time, _timeScaleDelta)
{
	if (_t[TGMX_T_SCALE] != 0 && _t[TGMX_T_GROUP_SCALE][0] != 0 && (!_t[TGMX_T_DELTA] || _timeScaleDelta != 0)) // Make sure time scale isn't "paused"
    {			
        // Update tween based on its play mode -- Could put overflow wait time in here????
        switch(_t[TGMX_T_MODE])
        {
	    case TWEEN_MODE_ONCE:
			// Set tween's state as STOPPED
	        _t[@ TGMX_T_STATE] = TGMX_T_STATE_STOPPED;	 
			// Update tween's time to duration or 0
			_t[@ TGMX_T_TIME] = _time > 0 ? _t[TGMX_T_DURATION] : 0;
	        // Update property
			TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], _target);
	        // Execute FINISH event
	        TGMX_ExecuteEvent(_t, TWEEN_EV_FINISH);
			// Destroy tween if temporary
	        if (_t[TGMX_T_DESTROY]) { TweenDestroy(_t); }
	    break;
                        
		case TWEEN_MODE_BOUNCE:
		    if (_time > 0)
		    {	
				// UPDATE TIME
				_t[@ TGMX_T_TIME] = _time;
								
				// REST
				if (_t[TGMX_T_REST] > 0)
				{
					// Mark as resting
					_t[@ TGMX_T_REST] = -_t[TGMX_T_REST];
					// Update property
					TGMX_TweenProcess(_t, _t[TGMX_T_DURATION], _t[TGMX_T_PROPERTY_DATA], _target);
					// Execute Rest Event
					TGMX_ExecuteEvent(_t, TWEEN_EV_REST);
				}
									
				// CONTINUE
				if (_time >= _t[TGMX_T_DURATION] - _t[TGMX_T_REST])
				{
					// Mark as no longer resting
					_t[@ TGMX_T_REST] = -_t[TGMX_T_REST];
					// Assign raw time to tween -- adjust for overflow
					_t[@ TGMX_T_TIME] = 2*_t[TGMX_T_DURATION] + _t[TGMX_T_REST] - _time;	
					// NOTE: This can silently update tween's time
					EaseSwap(_t);
					// Reverse direction
				    _t[@ TGMX_T_DIRECTION] = -_t[TGMX_T_DIRECTION];  
					// Reverse time scale
				    _t[@ TGMX_T_SCALE] = -_t[TGMX_T_SCALE];
				    // Update property
				    TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], _target);
					// Execute CONTINUE event
				    TGMX_ExecuteEvent(_t, TWEEN_EV_CONTINUE);
				}
				else
				{	// Execute Resting Event
					TGMX_ExecuteEvent(_t, TWEEN_EV_RESTING);	
				}
		    }
		    else // FINISH
		    {
				// Update tween's time
				_t[@ TGMX_T_TIME] = 0;		
				// Reverse direction
			    _t[@ TGMX_T_DIRECTION] = -_t[TGMX_T_DIRECTION];
				// Reverse time scale
			    _t[@ TGMX_T_SCALE] = -_t[TGMX_T_SCALE];
				// Set tween state as STOPPED
		        _t[@ TGMX_T_STATE] = TGMX_T_STATE_STOPPED;
				// Update property
		        TGMX_TweenProcess(_t, 0, _t[TGMX_T_PROPERTY_DATA], _target);
		        // Execute FINISH event
				TGMX_ExecuteEvent(_t, TWEEN_EV_FINISH);
				// Destroy tween if temporary
		        if (_t[TGMX_T_DESTROY]) { TweenDestroy(_t); }    
		    }
		break;
                        
	    case TWEEN_MODE_PATROL:		
			// FINISH
			if (_t[TGMX_T_CONTINUE_COUNT] == 0) 
			{
				// Update tween's time
				_t[@ TGMX_T_TIME] = _time > 0 ? _t[TGMX_T_DURATION] : 0;
				// Reverse direction
				_t[@ TGMX_T_DIRECTION] = -_t[TGMX_T_DIRECTION];  
				// Reverse time scale
				_t[@ TGMX_T_SCALE] = -_t[TGMX_T_SCALE];
				// Set tween state as STOPPED
				_t[@ TGMX_T_STATE] = TGMX_T_STATE_STOPPED;
				// Update property
				TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], _target);
				// Execute FINISH event
				TGMX_ExecuteEvent(_t, TWEEN_EV_FINISH);
				// Destroy tween if temporary
				if (_t[TGMX_T_DESTROY]) { TweenDestroy(_t); }   
								
				break;
			}
						
			// UPDATE TIME
			_t[@ TGMX_T_TIME] = _time;
							
			if (is_real(_t[TGMX_T_REST]))
			{
				_t[@ TGMX_T_REST] = array_create(2, _t[TGMX_T_REST]);	
			}
							
			var _rest = _t[TGMX_T_REST];
			var _restIndex = _time > 0;
							
			// REST
			if (_rest[_restIndex] > 0)
			{
				// Mark as resting by setting to negative value
				_rest[@ _restIndex] = -_rest[_restIndex];
				// Update property
				TGMX_TweenProcess(_t, _time <= 0 ? 0 : _t[TGMX_T_DURATION], _t[TGMX_T_PROPERTY_DATA], _target);
				// Execute Rest Event
				TGMX_ExecuteEvent(_t, TWEEN_EV_REST);
			}
			
			// CONTINUE
			if (_time >= _t[TGMX_T_DURATION] - _rest[_restIndex] || _time <= _rest[_restIndex])
			{
				// Decrement continue counter
				_t[@ TGMX_T_CONTINUE_COUNT] = _t[TGMX_T_CONTINUE_COUNT] - 1;
				// Mark as no longer resting
				_rest[@ _restIndex] = -_rest[_restIndex];
				// Assign raw time to tween -- adjust for overflow
				_t[@ TGMX_T_TIME] = _time > 0 ? 2*_t[TGMX_T_DURATION] + _rest[_restIndex] - _time : abs(_time)-_rest[_restIndex];
				// NOTE: This can silently update tween's time
				EaseSwap(_t);
				// Reverse direction
				_t[@ TGMX_T_DIRECTION] = -_t[TGMX_T_DIRECTION];  
				// Reverse time scale
				_t[@ TGMX_T_SCALE] = -_t[TGMX_T_SCALE];
				// Update property
				TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], _target);
				// Execute CONTINUE event
				TGMX_ExecuteEvent(_t, TWEEN_EV_CONTINUE);
			}
			else
			{	// Execute Resting Event
				TGMX_ExecuteEvent(_t, TWEEN_EV_RESTING);
			}
	    break;
                        
	    case TWEEN_MODE_LOOP:		
			// FINISH
			if (_t[TGMX_T_CONTINUE_COUNT] == 0) 
			{
				// Update tween's time
				_t[@ TGMX_T_TIME] = _t[TGMX_T_DURATION];		 
				// Set tween state as STOPPED
				_t[@ TGMX_T_STATE] = TGMX_T_STATE_STOPPED;
				// Update property
				TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], _target);
				// Execute FINISH event
				TGMX_ExecuteEvent(_t, TWEEN_EV_FINISH);
				// Destroy tween if temporary
				if (_t[TGMX_T_DESTROY]) { TweenDestroy(_t); }   
				// Break out of mode's switch case
				break;
			}
						
			// UPDATE TIME
			_t[@ TGMX_T_TIME] = _time;
						
			// REST
			if (_t[TGMX_T_REST] > 0)
			{
				// Mark as resting
				_t[@ TGMX_T_REST] = -_t[TGMX_T_REST];
				// Update property
				TGMX_TweenProcess(_t, _time <= 0 ? 0 : _t[TGMX_T_DURATION], _t[TGMX_T_PROPERTY_DATA], _target);
				// Execute Rest Event
				TGMX_ExecuteEvent(_t, TWEEN_EV_REST);
			}
								
			// Check for continue
			if (_time >= _t[TGMX_T_DURATION] - _t[TGMX_T_REST] || _time <= _t[TGMX_T_REST])
			{
				_t[@ TGMX_T_CONTINUE_COUNT] = _t[TGMX_T_CONTINUE_COUNT] - 1;
				// Mark as no longer resting
				_t[@ TGMX_T_REST] = -_t[TGMX_T_REST];
				// Assign raw time to tween
				_t[@ TGMX_T_TIME] = _time > 0 ? _time-_t[TGMX_T_DURATION]-_t[TGMX_T_REST] : _time+_t[TGMX_T_DURATION]+_t[TGMX_T_REST];
				// Swap eases or duration -- can silenty change tween's time
				EaseSwap(_t);
		        // Update property
		        TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], _target);
		        // Execute CONTINUE event
		        TGMX_ExecuteEvent(_t, TWEEN_EV_CONTINUE);
			}
			else // Keep resting
			{
				TGMX_ExecuteEvent(_t, TWEEN_EV_RESTING);
			}
		break;
                        
	    case TWEEN_MODE_REPEAT:
							
			// FINISH
			if (_t[TGMX_T_CONTINUE_COUNT] == 0) 
			{
				// Update tween's time
				_t[@ TGMX_T_TIME] = _t[TGMX_T_DURATION];		 
				// Set tween state as STOPPED
				_t[@ TGMX_T_STATE] = TGMX_T_STATE_STOPPED;
				// Update property
				TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], _target);
				// Execute FINISH event
				TGMX_ExecuteEvent(_t, TWEEN_EV_FINISH);
				// Destroy tween if temporary
				if (_t[TGMX_T_DESTROY]) { TweenDestroy(_t); }   
				// Break out of switch case
				break;
			}
							
			// UPDATE TIME
			_t[@ TGMX_T_TIME] = _time;
							
			// REST
			if (_t[TGMX_T_REST] > 0)
			{
				// Mark as resting
				_t[@ TGMX_T_REST] = -_t[TGMX_T_REST];
				// Update property
				TGMX_TweenProcess(_t, _time <= 0 ? 0 : _t[TGMX_T_DURATION], _t[TGMX_T_PROPERTY_DATA], _target);
				// Execute Rest Event
				TGMX_ExecuteEvent(_t, TWEEN_EV_REST);
			}
								
			// CONTINUE
			if (_time >= _t[TGMX_T_DURATION] - _t[TGMX_T_REST] || _time <= _t[TGMX_T_REST])
			{
				// Decrement countinue counter
				_t[@ TGMX_T_CONTINUE_COUNT] = _t[TGMX_T_CONTINUE_COUNT] - 1;
				// Mark as no longer resting
				_t[@ TGMX_T_REST] = -_t[TGMX_T_REST];
				// Update raw time with epsilon compensation
				_t[@ TGMX_T_TIME] = _time > 0 ? _time-_t[TGMX_T_DURATION]-_t[TGMX_T_REST] : _time+_t[TGMX_T_DURATION]+_t[TGMX_T_REST];
				// NOTE: This can silently update tween's time
				EaseSwap(_t);
				// Update new relative start position
				var _data = _t[TGMX_T_PROPERTY_DATA];
				var i = 2;
				repeat(array_length(_data) div 4)
				{
					_data[@ i] += _time > 0 ? _data[i+1] : -_data[i+1];
					i += 4;
				}
		        // Update property
		        TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], _target);
		        // Execute CONTINUE event
				TGMX_ExecuteEvent(_t, TWEEN_EV_CONTINUE);
			}
			else
			{
				TGMX_ExecuteEvent(_t, TWEEN_EV_RESTING);
			}
	    break;
                        
	    default:
	        show_error("Invalid Tween Mode! --> Forcing TWEEN_MODE_ONCE", false);
	        _t[@ TGMX_T_MODE] = TWEEN_MODE_ONCE;
        }
    }
}






