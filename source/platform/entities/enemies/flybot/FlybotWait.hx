package platform.entities.enemies.flybot;

import flixel.FlxG;
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
	
	var WAIT_TIME:Float = 1.5;
	var waitTime:Float;
	var SIGHT_DISTANCE:Float = 200;
	
	var RANDOM_DISTANCE:Float = 40;
	
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
			
		//if (p.getGraphicMidpoint().distanceTo(H.ps.player.getGraphicMidpoint()) < SIGHT_DISTANCE) 
			//parent.changeFSM('attack');
		//else
			FlxTween.tween(p, {x:p.x + FlxG.random.float( -RANDOM_DISTANCE, RANDOM_DISTANCE), y:p.y + FlxG.random.float( -RANDOM_DISTANCE, RANDOM_DISTANCE)}, .5, {ease:FlxEase.circInOut}) ;
	}
	
}