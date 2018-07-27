package platform.entities.bosses.thrust;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.bosses.Piece;

/**
 * ...
 * @author Dave
 */
class ThrustWeak extends Piece 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		makeGraphic(64, 64, FlxColor.TRANSPARENT);
		hp = 30;

	}
	
	override public function takeDamage(damage:Int = 1) 
	{
		parent.takeDamage(1);
	}
	
}