package platform.entities.enemies.mushboom;

import flixel.FlxG;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class MushBoomSmallWalk extends FSMModule 
{
	var e:MushboomSmall;
	var timer:FlxTimer;
	
	var WALK_SPEED:Float = 100;
	var WALK_TIME:Float = 1.5;
	public function new(parent:IFSM) 
	{
		super(parent);
		e = cast parent;
		timer = new FlxTimer();
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
		e.animation.play('idle');
		e.velocity.x = 0;
	}
	
	override public function changeTo() 
	{
		var left = FlxG.random.bool();
		e.animation.play('walk');
		e.velocity.x = WALK_SPEED;
		if (left) {
			e.flipX = false;
			e.velocity.x *= -1;
		} else {
			e.flipX = true;
		}
		timer.start(WALK_TIME, function(_) {parent.changeFSM('wait'); });
	}

	
}