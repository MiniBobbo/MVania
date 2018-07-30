package platform.entities.enemies.constructionbot;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;
import platform.entities.Attack.AttackTypes;

/**
 * ...
 * @author Dave
 */
class ConstructionBotShootFSM extends FSMModule 
{

	var currentShotCount:Int;
	var SHOT_MIN:Int = 2;
	var SHOT_MAX:Int = 4;
	
	var SHOT_DELAY_MIN:Float = .55;
	var SHOT_DELAY_MAX:Float = .85;
	
	var SHOT_COUNT:Int = 4;
	var shotAngle:Float = 120;
	var SHOT_SPEED:Float = 200;
	var SHOT_ANGLE_OFFSET:Float = 30;
	
	var SHOT_OFFSET:FlxPoint;
	
	
	
	var c:ConstructionBot;
	var timer:FlxTimer;
	var fireTimer:FlxTimer;
	public function new(parent:IFSM) 
	{
		super(parent);
		SHOT_OFFSET = new FlxPoint(-45, -35);
		timer = new FlxTimer();
		fireTimer = new FlxTimer();
		c = cast parent;
	}
	
	override public function changeFrom() 
	{
		super.changeFrom();
		timer.cancel();
		fireTimer.cancel();
	}
	
	override public function changeTo() 
	{
		if (c.right)
			c.flipX = false;
		else	
			c.flipX = true;
		c.animation.play('up');
		timer.start(1.3, fire);
		currentShotCount = FlxG.random.int(SHOT_MIN, SHOT_MAX);
		
	}
	
	private function fire(_) {
		trace('Firing');
		currentShotCount--;
		for (i in 0...SHOT_COUNT) {
			var a = H.ps.getEnemyAttack();
			AttackFactory.configAttack(a, AttackTypes.SHOT);
			a.strength = 1;
			var v = FlxPoint.get(0, -SHOT_SPEED);
			v.rotate(FlxPoint.weak(), shotAngle + FlxG.random.float( -SHOT_ANGLE_OFFSET, SHOT_ANGLE_OFFSET));
			if (c.right) {
				
				v.x *= -1;
			}
			//var tempOffset = SHOT
			//a.velocity.x = -SHOT_SPEED;
			var tempOffset = FlxPoint.get().copyFrom(SHOT_OFFSET);
			if (!c.right)
				tempOffset.x *= -1;
			var position = c.getMidpoint().addPoint(tempOffset);
			a.newInitAttack(position, v, 5, AttackTypes.SHOT);
			v.put();
		}
		
		if (currentShotCount > 0) {
			fireTimer.start(FlxG.random.float(SHOT_DELAY_MIN, SHOT_DELAY_MAX), fire);
		} else {
			fireTimer.start(.5, finish);
		}
		
	}
	
	private function finish(_) {
		c.animation.play('down');
		timer.start(.5, function(_) {parent.changeFSM('wait'); });
	}
	
}