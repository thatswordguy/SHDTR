///load_game(file_name)
var file_name = argument0;

// Break cases
if (!instance_exists(o_player_stats)) show_error("Load error: Stats object not found.", false);
if (!instance_exists(o_orion)) show_error("Load error: Orion object not found.", false);

// Load the file
var loaded_data = ds_map_secure_load(file_name);
if  (ds_exists(loaded_data, ds_type_map))
{
    ds_map_destroy(global.save_data);
}
else
{
    return false;
}

global.save_data = loaded_data;

// Load the stats
with (o_player_stats)
{
    powerlevel = global.save_data[? "powerlevel"];
    compassionlevel = global.save_data[? "compassionlevel"];
    ds_map_destroy(stats);
    stats = get_stats_from_class("orion");
    draw_health = stats[? "health"];
    
    //Load the items
    if (global.save_data[? "items"] != -1)
    {
        ds_list_copy(items, global.save_data[? "items"]);
        ds_list_copy(item_number, global.save_data[? "item_number"]);
    }
}

with (o_orion)
{
    x = global.save_data[? "x"];
    y = global.save_data[? "y"];
    last_room = noone;
}

//Load the room
var saved_room = asset_get_index(global.save_data[? "room"]);
if (room != saved_room) room_goto(saved_room);

// Success
return true;



