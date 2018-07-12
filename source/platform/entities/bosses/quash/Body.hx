package platform.entities.bosses.quash;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Body extends Piece 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('normal', 'squasher_normal_0', 30,false);
		animation.play('normal');
		setSize(10 * 32, 3 * 32);
		//centerOffsets();
		
	}
	
}