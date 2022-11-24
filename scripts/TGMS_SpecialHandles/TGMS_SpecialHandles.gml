// Feather disable all
/// @ignore
function TGMS_SpecialHandles() {}

var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

function TweenNull()
{
	/// @function TweenNull()
	/// @description Returns a null tween id
	/// @returns {undefined}
	/*
	    return:
	        NULL
        
	    INFO:
	        Returns a NULL tween id which can be safely called by any tween script
        
	    Example:
	        // Declare null tween id
	        tween = TweenNull()
        
	        // No error will occur
	        TweenStop(tween);
        
	*/

	return undefined;
}_=TweenNull;


function TweenDefault()
{
	/// @function TweenDefault()
	/// @description Returns the default tween for setting default tween data
	/*
	    Returns default tween data which is used as base for each new tween.
	    You can, for example, use this to set default groups and time scales for new tweens
    
	    e.g. 
	        // Change default tween properties
	        TweenSetGroup(TweenDefault(), 5);
	        TweenSetTimeScale(TweenDefault(), 0.5);
    
	        // Following tweens will belong to GROUP 5 and have a TIME SCALE of 0.5
	        tween1 = TweenCreate(id);
	        tween2 = TweenCreate(id);
	*/

	return 1;
}_=TweenDefault;


