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
class PlayerRobotBoostUp extends FSMModule 
{

	//This is the velocity that should be added to the player when boosting.  
	var BOOST_STR:FlxPoint;
	var BOOST_GRAVITY_STR:Float = 1000;
	var BOOST_TIME:Float = .2;
	var boostTime:Float;
	var p:Player;
	public function new(parent:Entity) 
	{
		super(parent);
		BOOST_STR = new FlxPoint(0, -500);
		p = cast parent;
	}
	
	override public function changeTo() 
	{
		Sounds.play(AllSounds.BOOST);

		p.animation.play('boostup');
		boostTime = BOOST_TIME;
		p.velocity.y = BOOST_STR.y;
		p.velocity.x = 0;
		p.acceleration.y = BOOST_GRAVITY_STR;
		
	}
	
	override public function changeFrom() 
	{
		p.acceleration.y = H.GRAVITY;
			
	}
	override public function update(dt:Float) 
	{
		super.update(dt);
		p.velocity.y = BOOST_STR.y;
		
		boostTime -= dt;
		if (boostTime <= 0)
			p.fsm.changeState('air');

	}
	
}