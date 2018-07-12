package platform.entities.bosses.quash;

import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class SquashCrushFSM extends FSMModule 
{
	var squash:Squasher;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		squash = cast parent;
	}
	
	override public function changeTo() 
	{
		squash.leftArm.signal('crush');
		squash.rightArm.signal('crush');
	}
	
	override public function update(dt:Float) 
	{
		parent.changeFSM('wait');
	}
	
}