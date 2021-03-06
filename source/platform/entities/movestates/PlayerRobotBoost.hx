package platform.entities.movestates;

import flixel.math.FlxPoint;
import fsm.FSMModule;
import platform.entities.Entity;
import platform.entities.Player;
import sound.AllSounds;
import sound.Sounds;

/**
 * ...
 * @author Dave
 */
class PlayerRobotBoost extends FSMModule 
{

	//This is the velocity that should be added to the player when boosting.  
	var BOOST_STR:FlxPoint;
	var BOOST_GRAVITY_STR:Float = 1000;
	var BOOST_TIME:Float = .3;
	var boostTime:Float;
	var p:Player;
	public function new(parent:Entity) 
	{
		super(parent);
		BOOST_STR = new FlxPoint(-500, -100);
		p = cast parent;
	}
	
	override public function changeTo() 
	{
		Sounds.play(AllSounds.BOOST);
		p.animation.play('boost');
		boostTime = BOOST_TIME;
		p.velocity.y = BOOST_STR.y;
		if (p.flipX)
		p.velocity.x = -BOOST_STR.x;
		else
		p.velocity.x = BOOST_STR.x;
		p.acceleration.y = BOOST_GRAVITY_STR;
		
	}
	
	override public function changeFrom() 
	{
		p.acceleration.y = H.GRAVITY;
			
	}
	override public function update(dt:Float) 
	{
		super.update(dt);
		if (p.flipX)
		p.velocity.x = -BOOST_STR.x;
		else
		p.velocity.x = BOOST_STR.x;
		
		boostTime -= dt;
		if (boostTime <= 0)
			p.fsm.changeState('air');

	}
	
}