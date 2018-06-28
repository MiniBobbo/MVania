package platform.entities.things;

import flixel.tile.FlxTilemap;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Terminal extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('terminal', 'icons_terminal_', 1, false);
		animation.play('terminal');
	}
	
}