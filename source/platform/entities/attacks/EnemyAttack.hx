package platform.entities.attacks;

import flixel.math.FlxPoint;
import platform.entities.Attack;


/**
 * ...
 * @author Dave
 */
class EnemyAttack extends Attack 
{

	public function new(lifespan:Float=3) 
	{
		super(lifespan);
		frames = H.getFrames();
		animation.addByPrefix('shot', 'Attacks_shot_');
		animation.addByPrefix('end', 'Attacks_PlayerShotEnd_');
		animation.play('shot');
	}
	
	override public function initAttack(p:FlxPoint, v:FlxPoint, lifespan:Float, anim:String) 
	{
		super.initAttack(p, v, lifespan, anim);
	}
	
	
}