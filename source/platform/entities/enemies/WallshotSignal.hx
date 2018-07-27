package platform.entities.enemies;

import flixel.tile.FlxTilemap;

/**
 * ...
 * @author Dave
 */
class WallshotSignal extends Wallshot 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		timer.cancel();
		FIRE_TIME = 10000;
	}
	
}