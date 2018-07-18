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
			
		//var newDir = FlxPoint.get(0, -SPEED);
		//newDir.rotate(FlxPoint.weak(), FlxG.random.float( -179, 179) );
		//p.velocity.copyFrom(newDir);
		//newDir.put();
		
		//if (p.getGraphicMidpoint().distanceTo(H.ps.player.getGraphicMidpoint()) < SIGHT_DISTANCE) 
			//parent.changeFSM('attack');
		//else
		var change = FlxG.random.float( -RANDOM_DISTANCE, RANDOM_DISTANCE);
		if (change < 0)
			p.flipX = false;
		else
			p.flipX = true;
			FlxTween.tween(p, {x:p.x + change, y:p.y + FlxG.random.float( -RANDOM_DISTANCE, RANDOM_DISTANCE)}, .5, {ease:FlxEase.circInOut}) ; 
		waitTime = WAIT_TIME;	
	}
	
}