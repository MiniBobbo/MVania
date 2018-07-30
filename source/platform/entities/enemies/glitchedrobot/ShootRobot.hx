package platform.entities.enemies.glitchedrobot;

import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import platform.entities.Attack.AttackTypes;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class ShootRobot extends Enemy 
{
	var firing:Bool = false;
	var remainingShots:Int = 0;
	var SHOOT_DELAY:Float = 2;
	var SHOTS:Int = 3;
	var TIME_BETWEEN_SHOTS:Float = .75;
	var delay:Float;
	var SHOT_SPEED:Float = 200;
	var RANGE:Float = 500;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('stand', 'ShootRobot_stand_',1,false);
		animation.addByPrefix('fire', 'ShootRobot_fire_', 1, false);
		animation.play('stand');
		setSize(25, 28);
		centerOffsets();
		offset.y += 20;
		acceleration.y = H.GRAVITY;
		offset.x += 4;
		delay = SHOOT_DELAY;
		remainingShots = SHOTS;
		hp = 4;
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
			delay -= elapsed;
		if (firing)
			fire();
		else 
			wait();
	}

	
	private function fire() {
		if (delay <= 0) {
			tryFire();
			remainingShots--;
			if (remainingShots <= 0) {
				firing = false;
				delay = SHOOT_DELAY;
				remainingShots = SHOTS;
				animation.play('stand');
			}
		}
	}
	
	private function tryFire() {
		
		//Get the attack
		var a = H.ps.getEnemyAttack();
		AttackFactory.configAttack(a, AttackTypes.SHOT);
		a.strength = 2;
		var v = FlxPoint.get(-SHOT_SPEED, 0);
		if (flipX)
			v.x *= -1;
		a.newInitAttack(this.getMidpoint(), v, 5, AttackTypes.SHOT);
		v.put();
		delay = TIME_BETWEEN_SHOTS;
	}
	
	private function wait() {
		if (H.ps.player.x < this.x)
			flipX = false;
		else
			flipX = true;
			
		if (delay <= 0) {
			if (getMidpoint().distanceTo(H.ps.player.getMidpoint()) < RANGE) {
				firing = true;
				animation.play('fire');
			} else 
			delay = TIME_BETWEEN_SHOTS;
		}
	}
	

}