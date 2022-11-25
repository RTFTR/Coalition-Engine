/// @desc    Deactivates a verb until the button (or other physical input) is released and pressed again
/// @param   verb
/// @param   [playerIndex]

function input_consume(_verb, _player_index = 0)
{
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (_verb == all)
    {
        var _verb_names = variable_struct_get_names(global.__input_players[_player_index].__verb_state_dict);
        var _v = 0;
        repeat(array_length(_verb_names))
        {
            input_consume(_verb_names[_v], _player_index);
            ++_v;
        }
    }
    else
    {
        var _verb_struct = global.__input_players[_player_index].__verb_state_dict[$ _verb];
        if (!is_struct(_verb_struct))
        {
            __input_error("Verb not recognised (", _verb, ")");
            return undefined;
        }
        
        with(_verb_struct)
        {
            __consumed     = true;
            previous_held  = true; //Force the held state on to avoid unwanted early reset of a __consumed verb
            __inactive     = true;
            __toggle_state = false; //Used for "toggle momentary" accessibility feature
        }
        
        //If this verb is a combo then also reset the combo's state
        var _combo_state = global.__input_players[_player_index].__combo_state_dict[$ _verb];
        if (is_struct(_combo_state)) _combo_state.__reset();
    }
}

/// @desc    Returns the name of the verb group the verb is in, as defined by INPUT_VERB_GROUPS
///          If the verb is in no verb group, this function returns <undefined>
/// @param   verb

function input_verb_get_group(_verb_name)
{
    __input_initialize();
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    return global.__input_verb_to_group_dict[$ _verb_name];
}

/// @desc    Sets the state of a verb group, as defined by INPUT_VERB_GROUPS. Verbs inside a deactivated verb group are also deactivated
/// @param   verbGroup
/// @param   state
/// @param   [playerIndex=0]
/// @param   [exclusive=false]

function input_verb_group_active(_verb_group, _state, _player_index = 0, _exclusive = false)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!variable_struct_exists(global.__input_group_to_verbs_dict, _verb_group))
    {
        __input_error("Verb group \"", _verb_group, "\" doesn't exist\nPlease make sure it has been defined in __input_config_verbs()");
    }
    
    global.__input_players[_player_index].__verb_group_active(_verb_group, _state, _exclusive);
}

/// @desc    Returns the state of a verb group, as defined by INPUT_VERB_GROUPS
/// @param   verbGroup
/// @param   [playerIndex=0]

function input_verb_group_is_active(_verb_group, _player_index = 0)
{
    __input_initialize();
    
    if (!variable_struct_exists(global.__input_group_to_verbs_dict, _verb_group))
    {
        __input_error("Verb group \"", _verb_group, "\" doesn't exist\nPlease make sure it has been defined in __input_config_verbs()");
    }
    
    return global.__input_players[_player_index].__verb_group_is_active(_verb_group);
}

/// @desc    Sets the value of a verb. This is "additive" to other physical inputs the player might be making
///          If you'd like to fully control a player's verbs, please set that player to ghost mode with input_player_ghost_set()
/// @param   verb
/// @param   value
/// @param   [playerIndex=0]
/// @param   [analogue=true]

function input_verb_set(_verb, _value, _player_index = 0, _analogue = true)
{
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    global.__input_players[_player_index].__verb_set(_verb, _value, _analogue);
}