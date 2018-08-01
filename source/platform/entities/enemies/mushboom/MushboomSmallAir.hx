package platform.entities.enemies.mushboom;

import flixel.FlxObject;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class MushboomSmallAir extends FSMModule 
{
	var e:MushboomSmall;
	var timer:FlxTimer;
	public function new(parent:IFSM) 
	{
		super(parent);
		e = cast parent;
		timer = new FlxTimer();
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
		e.velocity.x = 0;	
	}
	

	override public function update(dt:Float) 
	{
		if (e.isTouching(FlxObject.FLOOR)) {
			e.animation.play('idle');
			parent.changeFSM('wait');
		}
	}
}