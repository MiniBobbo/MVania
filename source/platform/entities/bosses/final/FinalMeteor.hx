package platform.entities.bosses.final;

import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import platform.H;
import platform.entities.Attack.AttackTypes;
import platform.entities.attacks.UnivAttack;
import platform.entities.bosses.Piece;
import sound.AllSounds;
import sound.Sounds;

/**
 * ...
 * @author Dave
 */
class FinalMeteor extends Piece 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('m', 'meteor_main_', 1, false);
		animation.play('m');
		
		setSize(45, 128);
		centerOffsets();
		
		bossOffset.set(70, 90);
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		switch (signal) 
		{
			case 'hit':
				var a:UnivAttack = cast data;
				if (a.type == AttackTypes.FIRE) {
					Sounds.play(AllSounds.IMMUNE);
				} else {
					parent.takeDamage(a.strength);
					FlxSpriteUtil.flicker(this, .2);
					Sounds.play(AllSounds.HIT);
				}
				
					
					
			default:
				
		}
	}
	
}