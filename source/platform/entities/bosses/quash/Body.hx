package platform.entities.bosses.quash;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Body extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		makeGraphic(6 * 32, 3 * 32, FlxColor.BLUE);
		
	}
	
}