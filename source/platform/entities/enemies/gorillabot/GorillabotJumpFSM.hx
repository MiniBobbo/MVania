package platform.entities.enemies.gorillabot;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class GorillabotJumpFSM extends FSMModule 
{

	var g:Gorillabot;
	var timer:FlxTimer;
	
	var JUMP_STRENGTH:Float = 200;
	var JUMP_ANGLE:Float = 30;
	var jumpVec:FlxPoint;
	var nextFSM:String;
	
	public function new(parent:IFSM, nextFSM:String = 'wait', jumpStr:Float = 200) 
	{
		super(parent);
		g = cast parent;
		timer = new FlxTimer();
		jumpVec = new FlxPoint(0, -JUMP_STRENGTH);
		jumpVec.rotate(FlxPoint.weak(), JUMP_ANGLE);
		JUMP_STRENGTH = jumpStr;
		this.nextFSM = nextFSM; 
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
		g.velocity.x = 0;
	}	
	
	override public function changeTo() 
	{
		g.animation.play('jump');
		super.changeTo();
		g.flipX = FlxG.random.bool();
		g.velocity.copyFrom(jumpVec);
		if (!g.flipX)
			g.velocity.x *= -1;
	}
	
	override public function update(dt:Float) 
	{
		if (g.isTouching(FlxObject.FLOOR)) {
			if (FlxG.random.bool(30)) {
				g.animation.play('idle');
				parent.changeFSM(nextFSM);
				
			} else {
				if(nextFSM == 'wait')
					parent.changeFSM('jump');
				else
					parent.changeFSM('jumpattack');
			}
		}
	}
	
}