package platform.entities.bosses.quash;

import flixel.FlxG;
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
	
	var SQUASH_SPEED:Float = 80;
	
	var possibilities:Array<String> = ['fire', 'contain', 'randomStomp', 'crush'];
	
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
		var pos = squash.getMidX();
		//var pos = squash.pos.x + squash.getMidX();
		
		if (pos - H.ps.player.x > 100) {
			squash.pos.x -= SQUASH_SPEED * dt;
		} else if (pos - H.ps.player.x < -100)
			squash.pos.x += SQUASH_SPEED * dt;
		
			if (squash.pos.x < 32)
			squash.pos.x = 32;
			if (squash.pos.x > 500)
			squash.pos.x = 500;
			
			
		
		super.update(dt);
		waitTime -= dt;
		if (waitTime <= 0) {
			parent.changeFSM(pickNextState());
		}
		
	}
	
	private function pickNextState():String {
		
		var p = possibilities[FlxG.random.int(0, possibilities.length - 1) ];
		while (p == squash.lastState)
			p = possibilities[FlxG.random.int(0, possibilities.length - 1) ];
		return p;
		
	}
}