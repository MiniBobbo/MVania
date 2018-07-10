package platform.entities.bosses.quash;

import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import platform.entities.Attack.AttackTypes;
import platform.entities.bosses.Piece;

/**
 * ...
 * @author Dave
 */
class SquashTurret extends Piece 
{

	var SHOT_SPEED:Float = 300;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('idle', 'turret_gun_idle_');
		animation.addByPrefix('fire', 'turret_gun_idle_', 12, false);
		animation.play('idle');
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		if (signal == 'fire') 
			tryFire();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		angle = getMidpoint().angleBetween(H.ps.player.getMidpoint());
	}
	
		private function tryFire() {
		//If there is something between the turret and the player, reset and try again next time.
		//Get the attack
		var a = H.ps.getEnemyAttack();
		AttackFactory.configAttack(a, AttackTypes.SHOT);
		a.strength = 2;
		a.angle = angle;
		var v = FlxPoint.get(0, -SHOT_SPEED);
		var loc = FlxPoint.get(0, -16);
		loc.rotate(FlxPoint.weak(), angle);
		v.rotate(FlxPoint.weak(), angle);
		//a.velocity.x = -SHOT_SPEED;
		a.initAttack(getMidpoint() , v, 5, 'shot');
		v.put();
	}
}