package platform.entities.bosses.quash;

import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import platform.entities.bosses.Piece;

/**
 * ...
 * @author Dave
 */
class SquashWeak extends Piece 
{

	var destroyed:Bool = false;
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('normal', 'squashweakspot_normal_0');
		animation.addByPrefix('weak1', 'squashweakspot_weak1_0');
		animation.addByPrefix('weak2', 'squashweakspot_weak2_0');
		animation.addByPrefix('broken', 'squashweakspot_broken_0');
		animation.play('normal');
		setSize(40,50);
		centerOrigin();
		//hp = 20;
		hp = 20;
	}
	
	
	override public function takeDamage(damage:Int = 1) 
	{
		if (destroyed) {
			parent.takeDamage(damage);
			super.takeDamage(damage);
		}
		else {
			super.takeDamage(damage);
			if (hp < 13)
				animation.play('weak2');
			else if (hp < 16)
				animation.play('weak1');
			if (hp <= 10) {
				destroyed = true;
				animation.play('broken');
				hp = 10;
			}
			
		}
	}
	
	override public function kill():Void 
	{
		FlxTween.tween(this, {alpha:0}, .3);
	}
	
}