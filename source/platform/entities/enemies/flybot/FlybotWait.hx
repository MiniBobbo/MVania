package platform.entities.enemies.flybot;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class FlybotWait extends FSMModule 
{
	var p:FlyBot;
	
	var WAIT_TIME:Float = 1;
	var waitTime:Float;
	var SIGHT_DISTANCE:Float = 200;
	
	var RANDOM_DISTANCE:Float = 80;
	var SPEED:Float = 200;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		p = cast parent;
	}
	
	override public function changeTo() 
	{
		waitTime = WAIT_TIME;
	}
	override public function update(dt:Float) 
	{
		waitTime-= dt;
		if (waitTime > 0)
			return;
			
		var newDir = FlxPoint.get(0, -SPEED);
		newDir.rotate(FlxPoint.weak(), FlxG.random.float( -179, 179) );
		p.velocity.copyFrom(newDir);
		newDir.put();
		waitTime = WAIT_TIME;
		
	}
	
}