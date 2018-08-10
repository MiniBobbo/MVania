package platform.entities.bosses.final;

import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;
import platform.H;

/**
 * ...
 * @author Dave
 */
class FinalBossFSM extends FSMModule 
{
	var b:FinalBoss;
	var bounceTimer:FlxTimer;
	
	var BOUNCE_TIME:Float = 5;
	
	
	public function new(parent:IFSM) 
	{
		super(parent);
		b = cast parent;
		bounceTimer = new FlxTimer();
		
	}
	
	override public function changeFrom() 
	{
		super.changeFrom();
	}
	
	override public function changeTo() 
	{
		super.changeTo();
		bounceTimer.start(BOUNCE_TIME, function(_) {H.signalAll('spawn'); });
	}
}