package platform.entities.bosses.quash;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;
import platform.entities.EffectSprite.EffectTypes;

/**
 * ...
 * @author Dave
 */
class SquashExplodeFSM extends FSMModule 
{

	var c:Squasher;
	var timer:FlxTimer;
	var explodeTimer:FlxTimer;
	var EXPLODE_COUNT:Int = 8;
	var EXPLODE_TIME:Float = .4;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		c = cast parent;
		timer = new FlxTimer();
		explodeTimer = new FlxTimer();
		
		
	}
	
	override public function changeTo() 
	{
		super.changeTo();
		timer.start(EXPLODE_COUNT * EXPLODE_TIME, dead);
		explodeTimer.start(EXPLODE_TIME, makeExplosion);
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
		explodeTimer.cancel();
	}
	
	private function makeExplosion(_) {
		var p = c.body.getMidpoint();
		p.x += FlxG.random.float( -30, 30);
		p.y += FlxG.random.float( -30, 30);
		
		H.playEffect(EffectTypes.EXPLODE, p);
		explodeTimer.start(EXPLODE_TIME, makeExplosion);
	}
	
	private function dead(_) {
		FlxG.camera.flash(FlxColor.WHITE, .1);
		
		//Set the flag to defeated so this boss doesn't appear again.
		H.setFlag(4, true);
		H.signalAll('activate');
		parent.changeFSM('realdead');
	}	
}