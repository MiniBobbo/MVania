package platform.entities.enemies.constructionbot;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;
import platform.entities.Attack.AttackTypes;

/**
 * ...
 * @author Dave
 */
class ConstructBotJumpFSM extends FSMModule 
{
	var c:ConstructionBot;
	var JUMP_STRENGTH_Y:Float = 300;
	var JUMP_STRENGTH_X:Float = 250;
	var JUMP_GRAVITY:Float = 300;
	var SHOT_COUNT:Int = 4;
	var SHOT_SPEED:Float = 200;
	var SHOT_ANGLE_OFFSET:Float = 30;

	var shotAngle:Float = 120;

	var jumpDelay:Float;
	var JUMP_DELAY:Float = 1;

	var SHOT_OFFSET:FlxPoint;
	
	var timer:FlxTimer;
	var jumping:Bool;
	
	//Hacky fix because the same frame that the bot jumps it is also on the ground and would immediately land.
	var justJumped:Bool = true;
	
	var fireTimer:FlxTimer;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		c = cast parent;
		timer = new FlxTimer();
		SHOT_OFFSET = new FlxPoint( -45, 10);
		fireTimer = new FlxTimer();
	}
	
	override public function changeTo() 
	{
		c.acceleration.y = JUMP_GRAVITY;
		c.animation.play('prepjump');
		jumpDelay = JUMP_DELAY;
		
		jumping = false;
		
		justJumped = true;
		
		timer.start(JUMP_DELAY, function(_) {jump(); });
		
		if (c.right) c.flipX = false; 
		else
			c.flipX = true;
	}
	
	override public function changeFrom() 
	{
		c.velocity.set();
		c.acceleration.y = H.GRAVITY;
		timer.cancel();
		fireTimer.cancel();
	}
	
	private function jump() {
		c.animation.play('jumping');
		c.velocity.x = JUMP_STRENGTH_X;
		c.velocity.y = -JUMP_STRENGTH_Y;
		if (c.right) 
			c.velocity.x *= -1;
		
			c.y -= 1;
		c.right = !c.right;	
		jumping = true;
		fireTimer.start(.5, function(_) { fire(FlxG.random.bool()); });
	}
	
	override public function update(dt:Float) 
	{
		if (jumping && c.isTouching(FlxObject.FLOOR))
		land();
	}
	
	private function land() {
		if (justJumped) {
			justJumped = false;
			return;
		}
		fireTimer.cancel();
		c.velocity.x = 0;
		c.animation.play('land');
		jumping = false;
		timer.start(.5, function(_) {parent.changeFSM('wait'); });
	}
	
	private function fire(left:Bool = false) {
		for (i in 0...SHOT_COUNT) {
			var a = H.ps.getEnemyAttack();
			AttackFactory.configAttack(a, AttackTypes.SHOT);
			a.strength = 1;
			var v = FlxPoint.get(0, -SHOT_SPEED);
			if (left)
				v.x *= -1;
			v.rotate(FlxPoint.weak(), shotAngle + FlxG.random.float( -SHOT_ANGLE_OFFSET, SHOT_ANGLE_OFFSET));
			if (c.right) {
				v.x *= -1;
			}
			var tempOffset = FlxPoint.get().copyFrom(SHOT_OFFSET);
			if (!c.right)
				tempOffset.x *= -1;
			if (left)
				tempOffset.x *= -1;
			var position = c.getMidpoint().addPoint(tempOffset);
			a.initAttack(position, v, 5, 'shot');
			v.put();
		}
		
		fireTimer.start(.5, function(_) { fire(FlxG.random.bool()); });
	}
}