package platform.entities.enemies.mushboom;

import flash.display.InterpolationMethod;
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
class MushboomSporeFSM extends FSMModule 
{

	var c:Mushboom;
	var timer:FlxTimer;
	
	var SLAM_TIME:Float = .3;
	var AFTER_TIME:Float = .75;

	var SPORE_COUNT = 7;
	var THROW_MIN = 3;
	var THROW_MAX = 6;
	
	var timesThrow:Int;
	
	var THROW_X:Float = 200;
	var THROW_Y:Float = 200;
	var THROW_X_VAR:Float = 200;
	var THROW_Y_VAR:Float = 100;
	
	var throwx:Float;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		c = cast parent;
		timer = new FlxTimer();
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
		
	}
	
	override public function changeTo() 
	{
		timesThrow = FlxG.random.int(THROW_MIN, THROW_MAX);
		c.facePlayer();
		throwx = THROW_X;
		if (!c.flipX)
			throwx *= -1;
		throwSpores();

	}
	
	private function throwSpores() {
		timesThrow--;
		c.animation.play('slam', true);
		timer.start(SLAM_TIME, function(_) {
			for (i in 0...SPORE_COUNT) {
				var s = H.ps.getEnemyAttack();
				AttackFactory.configAttack(s, AttackTypes.SPORE);
				var t = FlxPoint.get(throwx+ FlxG.random.float(-THROW_X_VAR, THROW_X_VAR), -THROW_Y + FlxG.random.float(-THROW_Y_VAR, THROW_Y_VAR));
				s.newInitAttack(FlxPoint.weak(c.x, c.y), t, 10, AttackTypes.SPORE);
				t.put();
			}
			timer.cancel();
			timer.start(AFTER_TIME, function(_) {
				if (timesThrow > 0)
					throwSpores();
				else {
				parent.changeFSM('wait');
				c.animation.play('idle');
					
				}
			});
		});
	}
}