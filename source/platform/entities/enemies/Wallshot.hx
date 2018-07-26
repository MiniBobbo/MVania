package platform.entities.enemies;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;
import platform.entities.Attack.AttackTypes;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Wallshot extends Enemy 
{
	var fireSpeed:Float = 200;
	var timer:FlxTimer;
	var FIRE_TIME:Float = 1.5;
	var Y_OFFSET:Float = 10;
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('wait', 'wallshot_wait_', 1, false);
		animation.addByPrefix('fire', 'wallshot_fire_', 12, false);
		animation.play('wait');
		setSize(32, 32);
		centerOffsets();
		timer = new FlxTimer();
		timer.start(FIRE_TIME, fire, 0);
	}
	

	
	public function flipMe() {
		flipX = !flipX;
		fireSpeed *= -1;
	}
	
	private function fire(_) {
		//Get the attack
		animation.play('fire');
		var a = H.ps.getEnemyAttack();
		AttackFactory.configAttack(a, AttackTypes.ELECTRIC);
		a.strength = 1;
		var v = FlxPoint.get( -fireSpeed, FlxG.random.float(-Y_OFFSET, Y_OFFSET) );
		a.newInitAttack(this.getMidpoint(), v, 5, AttackTypes.ELECTRIC);
		v.put();
	}
	
}