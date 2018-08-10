package platform.entities.bosses.final;

import flixel.tile.FlxTilemap;
import platform.H;
import platform.entities.bosses.Piece;

/**
 * ...
 * @author Dave
 */
class MainComputer extends Piece 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('main', 'finalbossroom', 1, false);
		animation.play('main');
		
	}
	
}