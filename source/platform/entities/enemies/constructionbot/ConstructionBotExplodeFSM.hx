package platform.entities.enemies.constructionbot;

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
class ConstructionBotExplodeFSM extends FSMModule 
{

	var c:ConstructionBot;
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
		c.acceleration.y = H.GRAVITY;
		c.animation.play('explode');
		timer.start(EXPLODE_COUNT * EXPLODE_TIME, dead);
		explodeTimer.start(EXPLODE_TIME, makeExplosion);
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
		explodeTimer.cancel();
	}
	
	private function makeExplosion(_) {
		var p = c.getMidpoint();
		p.x += FlxG.random.float( -30, 30);
		p.y += FlxG.random.float( -30, 30);
		
		H.playEffect(EffectTypes.EXPLODE, p);
		explodeTimer.start(EXPLODE_TIME, makeExplosion);
	}
	
	private function dead(_) {
		FlxG.camera.flash(FlxColor.WHITE, .1);
		
		var e = new BoostUpgrade(c.collisionMap);
		e.reset(c.getMidpoint().x - e.width / 2, c.getMidpoint().y - e.height / 2);
		H.ps.addEnemy(e);
		//Set the flag to defeated so this boss doesn't appear again.
		H.setFlag(0, false);
		parent.changeFSM('dead');
	}
}