package platform.entities.bosses.final;

import flixel.tile.FlxTilemap;
import platform.H;
import platform.entities.bosses.Piece;
import sound.AllSounds;
import sound.Sounds;

/**
 * ...
 * @author Dave
 */
class FinalShield extends Piece 
{

	var MIN_X:Float = 60;
	var MAX_X:Float = 240;
	var RAISE_SPEED:Float = 10;
	var downDistance:Float = 10;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('shield', 'shield', 1, false);
		animation.play('shield');
		setSize(62, 188);
		centerOffsets();
		bossOffset.y = 60;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		bossOffset.y -= RAISE_SPEED * elapsed;
		if (bossOffset.y < MIN_X) {
			bossOffset.y = MIN_X;
		}
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		switch (signal) 
		{
			case 'hit':
				Sounds.play(AllSounds.IMMUNE);
			case 'down':
				bossOffset.y += downDistance;
					
			default:
				
		}
	}
}