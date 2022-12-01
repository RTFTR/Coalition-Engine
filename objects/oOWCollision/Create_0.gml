collide = false;
texted = false;
depth = oOWPlayer.depth + 10;

Is_Background = false;

/*Tips for Creating the Background

You can change the sprite index of oOWCollision into the background image
so it will easier to position the collisions so the player wont go into
the unwanted areas, such as walls

yes you have to create different oOWCollisions in the Creation Code of the background
oOWCollision's switch statement
cringe but it's the only method that isn't object intensive nor lags
maybe lag on load, idk