package platform.entities.enemies.dillo;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class ArmoredDillo extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		makeGraphic(64, 64, FlxColor.BLUE);
		hp = 30;
	}
	
}