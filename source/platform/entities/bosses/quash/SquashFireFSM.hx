package platform.entities.bosses.quash;

import flixel.FlxG;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class SquashFireFSM extends FSMModule 
{

	var squash:Squasher;
	
	var left:Bool;
	var fireDelay:Float;
	var FIRE_DELAY:Float = .5;
	var FIRE_DELAY_START:Float = 1.5;
	var FIRE_COUNT:Int = 4;
	var fireCount:Int;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		squash = cast parent;
	}
	
	override public function changeTo() 
	{
		fireCount = 0;
		fireDelay = FIRE_DELAY_START;
		left = FlxG.random.bool();
	}
	
	override public function update(dt:Float) 
	{
		super.update(dt);
		fireDelay -= dt;
		
		if (fireDelay <= 0) {
			fire();
			fireCount++;
			if (fireCount >= FIRE_COUNT) {
				parent.changeFSM('wait');
			}
		}
	}
	
	override public function changeFrom() 
	{
		squash.leftArm.signal('up');
		squash.rightArm.signal('up');
	}
	
	private function fire() {
		if (left)
			squash.t1.signal('fire');
		else
			squash.t2.signal('fire');
		fireDelay = FIRE_DELAY;
		left = !left;
	}
	
	
}