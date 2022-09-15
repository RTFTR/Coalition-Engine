// Feather disable all/// @ignore
function TGMS_EasingEquations() {}

var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

/*
	This is used when you want to manually tween values.
	It is very similar to lerp() but takes an ease algorithm type.
*/
function Ease(_value1, _value2, _amount, _ease)
{
	/// @function Ease(value1,value2,amount,ease)
	/// @description Interpolates two values by a given amount using a specified easing algorithm
	/// @param value1	start value
	/// @param value2	end value
	/// @param amount	(0-1) amount to interpolate values
	/// @param ease		ease algorithm script
	/// @return {real}
	/*  
	    Example:
	        var _start = x;
	        var _dest  = mouse_x;
	        var _amount = 0.25;
	        var _ease = EaseInOutQuad;
        
	        x = Ease(_start, _dest, _amount, _ease);
	*/

	gml_pragma("forceinline");

	return script_execute(_ease, _amount, _value1, _value2-_value1, 1);
}_=Ease;


/*
===================================
  TERMS OF USE - EASING EQUATIONS
===================================
Open source under the BSD License.
Copyright (c)2001 Robert Penner
All rights reserved.
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

function EaseLinear(_time, _start, _change, _duration)
{
	/// @function EaseLinear(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * _time / _duration + _start;
}

function EaseInSine(_time, _start, _change, _duration) 
{
	/// @function EaseInSine(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * (1 - cos(_time / _duration * (pi / 2))) + _start;
}_=EaseInSine;

function EaseOutSine(_time, _start, _change, _duration)
{
	/// @function EaseOutSine(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * sin(_time/_duration * (pi/2)) + _start;
}_=EaseOutSine;

function EaseInOutSine(_time, _start, _change, _duration)
{
	/// @function EaseInOutSine(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * 0.5 * (1 - cos(pi*_time/_duration)) + _start;
}_=EaseInOutSine;

function EaseInQuad(_time, _start, _change, _duration)
{
	/// @function EaseInQuad(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * _time/_duration * _time/_duration + _start;
}_=EaseInQuad;

function EaseOutQuad(_time, _start, _change, _duration)
{
	/// @function EaseOutQuad(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return -_change * _time/_duration * (_time/_duration-2) + _start;
}_=EaseOutQuad;

function EaseInOutQuad(_time, _start, _change, _duration)
{
	/// @function EaseInOutQuad(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time = 2*_time/_duration;
	return _time < 1 ? _change * 0.5 * _time * _time + _start
					 : _change * -0.5 * ((_time-1) * (_time - 3) - 1) + _start;
}_=EaseInOutQuad;

function EaseInCubic(_time, _start, _change, _duration) 
{
	/// @function EaseInCubic(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * power(_time/_duration, 3) + _start;
}_=EaseInCubic;

function EaseOutCubic(_time, _start, _change, _duration) 
{
	/// @function EaseOutCubic(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * (power(_time/_duration - 1, 3) + 1) + _start;
}_=EaseOutCubic;

function EaseInOutCubic(_time, _start, _change, _duration)
{
	/// @function EaseInOutCubic(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time = 2 * _time / _duration;
	return _time < 1 ? _change * 0.5 * power(_time, 3) + _start
					 : _change * 0.5 * (power(_time-2, 3) + 2) + _start;
}_=EaseInOutCubic;

function EaseInQuart(_time, _start, _change, _duration) 
{
	/// @function EaseInQuart(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * power(_time / _duration, 4) + _start;
}_=EaseInQuart;

function EaseOutQuart(_time, _start, _change, _duration)
{
	/// @function EaseOutQuart(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return -_change * (power(_time / _duration - 1, 4) - 1) + _start;
}_=EaseOutQuart;

function EaseInOutQuart(_time, _start, _change, _duration)
{
	/// @function EaseInOutQuart(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real} 
	
	_time = 2*_time/_duration;
	return _time < 1 ? _change * 0.5 * power(_time, 4) + _start
					 : _change * -0.5 * (power(_time - 2, 4) - 2) + _start;
}_=EaseInOutQuart;

function EaseInQuint(_time, _start, _change, _duration) 
{
	/// @function EaseInQuint(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * power(_time / _duration, 5) + _start;
}_=EaseInQuint;

function EaseOutQuint(_time, _start, _change, _duration) 
{
	/// @function EaseOutQuint(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * (power(_time/_duration - 1, 5) + 1) + _start;
}_=EaseOutQuint;

function EaseInOutQuint(_time, _start, _change, _duration)
{
	/// @function EaseInOutQuint(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time = 2*_time/_duration;
	return _time < 1 ? _change * 0.5 * power(_time, 5) + _start
					 : _change * 0.5 * (power(_time - 2, 5) + 2) + _start;
}_=EaseInOutQuint;

function EaseInExpo(_time, _start, _change, _duration) 
{
	return _change * power(2, 10 * (_time/_duration - 1)) + _start;
}_=EaseInExpo;

function EaseOutExpo(_time, _start, _change, _duration)
{
	/// @function EaseOutExpo(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * (-power(2, -10 * _time / _duration) + 1) + _start;
}_=EaseOutExpo;

function EaseInOutExpo(_time, _start, _change, _duration)
{
	/// @function EaseInOutExpo(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time = 2 * _time / _duration;
	return _time < 1 ? _change * 0.5 * power(2, 10 * (_time-1)) + _start
					 : _change * 0.5 * (-power(2, -10 * (_time-1)) + 2) + _start;
}_=EaseInOutExpo;

function EaseInCirc(_time, _start, _change, _duration)
{
	/// @function EaseInCirc(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change * (1 - sqrt(1 - _time/_duration * _time/_duration)) + _start;
}_=EaseInCirc;

function EaseOutCirc(_time, _start, _change, _duration)
{
	/// @function EaseOutCirc(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time = _time/_duration - 1;
	return _change * sqrt(abs(1 - _time * _time)) + _start;
}_=EaseOutCirc;

function EaseInOutCirc(_time, _start, _change, _duration)
{
	/// @function EaseInOutCirc(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time = 2*_time/_duration;
	return _time < 1 ? _change * 0.5 * (1 - sqrt(abs(1 - _time * _time))) + _start
					 : _change * 0.5 * (sqrt(abs(1 - (_time-2) * (_time-2))) + 1) + _start;
}_=EaseInOutCirc;

function EaseInBack(_time, _start, _change, _duration)
{
	/// @function EaseInBack(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time /= _duration;
	_duration = 1.70158; // "s" -- repurpose duration as Robert Penner's "s" value
	return _change * _time * _time * ((_duration + 1) * _time - _duration) + _start;
}_=EaseInBack;


function EaseOutBack(_time, _start, _change, _duration)
{
	/// @function EaseOutBack(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time = _time/_duration - 1;
	_duration = 1.70158; // "s" -- repurpose duration as Robert Penner's "s" value
	return _change * (_time * _time * ((_duration + 1) * _time + _duration) + 1) + _start;
}_=EaseOutBack;

function EaseInOutBack(_time, _start, _change, _duration)
{
	/// @function EaseInOutBack(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time = _time/_duration*2;
	_duration = 1.70158; // "s" -- repurpose duration as Robert Penner's "s" value

	if (_time < 1)
	{
	    _duration *= 1.525;
	    return _change * 0.5 * (((_duration + 1) * _time - _duration) * _time * _time) + _start;
	}

	_time -= 2;
	_duration *= 1.525;

	return _change * 0.5 * (((_duration + 1) * _time + _duration) * _time * _time + 2) + _start;
}_=EaseInOutBack;

function EaseInElastic(_time, _start, _change, _duration)
{
	/// @function EaseInElastic(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	var _s = 1.70158;
	var _p = 0;
	var _a = _change;
	var _val = _time;

	if (_val == 0 || _a == 0) { return _start; }

	_val /= _duration;

	if (_val == 1) { return _start+_change; }

	if (_p == 0) { _p = _duration*0.3; }

	if (_a < abs(_change)) 
	{ 
	    _a = _change; 
	    _s = _p*0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (_change / _a);
	}

	return -(_a * power(2,10 * (--_val)) * sin((_val * _duration - _s) * (2 * pi) / _p)) + _start;
}_=EaseInElastic;

function EaseOutElastic(_time, _start, _change, _duration)
{
	/// @function EaseOutElastic(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	var _s = 1.70158;
	var _p = 0;
	var _a = _change;
	var _val = _time;

	if (_val == 0 || _a == 0){ return _start; }

	_val /= _duration;

	if (_val == 1){ return _start + _change; }

	if (_p == 0){ _p = _duration * 0.3; }

	if (_a < abs(_change)) 
	{ 
	    _a = _change;
	    _s = _p * 0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (_change / _a);
	}

	return _a * power(2, -10 * _val) * sin((_val * _duration - _s) * (2 * pi) / _p ) + _change + _start;
}_=EaseOutElastic;

function EaseInOutElastic(_time, _start, _change, _duration)
{
	/// @function EaseInOutElastic(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	var _s = 1.70158;
	var _p = 0;
	var _a = _change;
	var _val = _time;

	if (_val == 0 || _a == 0) { return _start; }

	_val /= _duration*0.5;

	if (_val == 2) { return _start+_change; }

	if (_p == 0) { _p = _duration * (0.3 * 1.5); }

	if (_a < abs(_change)) 
	{ 
	    _a = _change;
	    _s = _p * 0.25;
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (_change / _a);
	}

	if (_val < 1) { return -0.5 * (_a * power(2, 10 * (--_val)) * sin((_val * _duration - _s) * (2 * pi) / _p)) + _start; }

	return _a * power(2, -10 * (--_val)) * sin((_val * _duration - _s) * (2 * pi) / _p) * 0.5 + _change + _start;
}_=EaseInOutElastic;

function EaseInBounce(_time, _start, _change, _duration)
{
	/// @function EaseInBounce(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _change - EaseOutBounce(_duration - _time, 0, _change, _duration) + _start;
}_=EaseInBounce;

function EaseOutBounce(_time, _start, _change, _duration)
{
	/// @function EaseOutBounce(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	_time /= _duration;

	if (_time < 1/2.75)
	{
	    return _change * 7.5625 * _time * _time + _start;
	}
	else
	if (_time < 2/2.75)
	{
	    _time -= 1.5/2.75;
	    return _change * (7.5625 * _time * _time + 0.75) + _start;
	}
	else
	if (_time < 2.5/2.75)
	{
	    _time -= 2.25/2.75;
	    return _change * (7.5625 * _time * _time + 0.9375) + _start;
	}
	else
	{
	    _time -= 2.625/2.75;
	    return _change * (7.5625 * _time * _time + 0.984375) + _start;
	}
}_=EaseOutBounce;

function EaseInOutBounce(_time, _start, _change, _duration)
{
	/// @function EaseInOutBounce(time, start, change, duration)
	/// @param {real} time
	/// @param {real} start
	/// @param {real} change
	/// @param {real} duration
	/// @return {real}
	
	return _time < _duration*0.5 ? EaseInBounce(_time*2, 0, _change, _duration)*0.5 + _start
							     : EaseOutBounce(_time*2 - _duration, 0, _change, _duration)*0.5 + _change*0.5 + _start;
}_=EaseInOutBounce;





