package platform.entities.enemies;

import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import platform.entities.Attack.AttackTypes;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Turret extends Enemy 
{

	var fireDelay:Float = 2;
	public var FIRE_DELAY:Float = 2.5;
	
	var SHOT_SPEED:Float = 300;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('idle', 'turret_gun_idle_');
		animation.addByPrefix('fire', 'turret_gun_idle_', 12, false);
		animation.play('idle');
		hp = 8;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		fireDelay -= elapsed;
		if (fireDelay <= 0)
			tryFire();
		angle = getMidpoint().angleBetween(H.ps.player.getMidpoint());
	}
	
	
	private function tryFire() {
		//If there is something between the turret and the player, reset and try again next time.
		if (!collisionMap.ray(getMidpoint(), H.ps.player.getMidpoint())) {
			fireDelay = FIRE_DELAY;
			return;
		}
		fireDelay = FIRE_DELAY;
		
		//Get the attack
		var a = H.ps.getEnemyAttack();
		AttackFactory.configAttack(a, AttackTypes.SHOT);
		a.strength = 2;
		animation.play('fire');
		a.angle = angle;
		var v = FlxPoint.get(0, -SHOT_SPEED);
		var loc = FlxPoint.get(0, -16);
		loc.rotate(FlxPoint.weak(), angle);
		v.rotate(FlxPoint.weak(), angle);
		//a.velocity.x = -SHOT_SPEED;
		a.newInitAttack(getMidpoint() , v, 5, AttackTypes.SHOT);
		v.put();
	}
}