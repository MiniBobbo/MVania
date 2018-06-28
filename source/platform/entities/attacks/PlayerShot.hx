package platform.entities.attacks;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import platform.entities.Attack;
import platform.entities.Entity;


/**
 * ...
 * @author Dave
 */
class PlayerShot extends Attack 
{
	var FIRE_UPWARDS_VELOCITY:Float = 150;
	var ELECTRIC_SPREAD:Float = 30;
	public function new(lifespan:Float=3) 
	{
		super(lifespan);
		frames = H.getFrames();
		animation.addByPrefix('playershot', 'Attacks_shot_', 18, false);
		animation.addByPrefix('end', 'Attacks_PlayerShotEnd_', 18, false);
		animation.addByPrefix('shot', 'Attacks_shot_', 18, false);
		animation.addByPrefix('fireshot', 'Attacks_fire_', 18, false);
		animation.addByPrefix('elecshot', 'Attacks_electricshot_', 18);
		animation.addByPrefix('fireshotend', 'Attacks_fireend_', 18, false);
		animation.addByPrefix('elecshotend', 'Attacks_electricend_', 18, false);
		
		exists = false;
		alive = false;
	}
	
	override public function initAttack(p:FlxPoint, v:FlxPoint, lifespan:Float, anim:String) 
	{
		super.initAttack(p, v, lifespan, anim);
		if (anim == 'fireshot') {
			acceleration.y = H.GRAVITY / 3;
			velocity.y = -FIRE_UPWARDS_VELOCITY;
		} else if (anim == 'elecshot') {
			acceleration.y = 0;
			velocity.y = FlxG.random.float(-ELECTRIC_SPREAD,ELECTRIC_SPREAD);
			
			
		} else if (anim == 'playershot') {
			acceleration.y = 0;
		}
	}
	
	override function changeHitBoxSize(anim:String) 
	{
		switch (anim) 
		{
			case 'playershot':
				setSize(10,10);
			case 'shot':
				setSize(10,10);
			case 'fireshot':
				setSize(10, 10);
			case 'elecshot':
				setSize(10, 10);
				
			default:
				
		}
		
		centerOffsets();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
			angle = FlxPoint.weak().angleBetween(velocity);
	}
	
	override public function hitEntity(e:Entity) 
	{
		if (alive) {
			kill();
		}
	}
	
	override public function hitMap() 
	{
		if (alive) {
			kill();
			
		}
	}
	
	override public function kill():Void 
	{
		if (!alive)
		return;
		alive = false;
		if (animation.name == 'fireshot')
		animation.play('fireshotend');
		else if (animation.name == 'elecshot')
		animation.play('elecshotend');
		else
		animation.play('end');
		velocity.set();
		
		new FlxTimer().start(1, function(_) {exists = false; });
	}
	
}