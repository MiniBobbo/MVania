package platform.entities.enemies;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import platform.entities.Attack.AttackTypes;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class BatBot extends Enemy 
{

	var FLY_SPEED:Float = 100;
	var FIRE_DELAY:Float = 1.5;
	var left:Bool = true;
	var delay:Float = 0;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		hp = 4;
		frames = H.getFrames();
		animation.addByPrefix('fly', 'bat_flap_', 12);
		animation.play('fly');
		setSize(30, 30);
		centerOffsets();
		delay = FIRE_DELAY + FlxG.random.float(0, 1);
	}
	
	override public function reset(X:Float, Y:Float):Void 
	{
		super.reset(X, Y);
		velocity.x = -FLY_SPEED;

	}
	
	override public function update(elapsed:Float):Void 
	{
		if (isTouching(FlxObject.WALL))
			flip();
		super.update(elapsed);
		delay -= elapsed;
		if (delay <= 0)
			fire();
	}
	
	private function flip() {
		left = !left;
		flipX = left;
		velocity.x = FLY_SPEED;
		if (!left)
		velocity.x *= -1;
	}
	
	private function fire() {
		var a = H.ps.getEnemyAttack();
		AttackFactory.configAttack(a, AttackTypes.ACID);
		a.strength = 2;
		a.newInitAttack(getMidpoint(), FlxPoint.weak(velocity.x, 0), 2, AttackTypes.ACID);
		delay = FIRE_DELAY;
	}
	
}