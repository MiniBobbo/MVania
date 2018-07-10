package platform.entities.bosses.quash;

import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class SquashWaitFSM extends FSMModule 
{
	var WAIT_TIME:Float = 2;
	var waitTime:Float;
	var squash:Squasher;
	
	var SQUASH_SPEED:Float = 40;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		squash = cast parent;
		
	}
	
	override public function changeTo() 
	{
		waitTime = WAIT_TIME;
	}
	
	
	override public function update(dt:Float) 
	{
		var dist = H.ps.player.x - squash.pos.x + squash.getMidX();
		
		if (dist < 100) {
			squash.pos.x += SQUASH_SPEED * dt;
		} else if (dist > 100)
			squash.pos.x -= SQUASH_SPEED * dt;
		
		super.update(dt);
		waitTime -= dt;
		if (waitTime <= 0) {
			parent.changeFSM('fire');
		}
		
	}
}