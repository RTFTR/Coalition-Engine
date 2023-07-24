if duration > 0 duration --;
if duration == 0 instance_destroy();
if !surface_exists(surf) surf = surface_create(640, 960);