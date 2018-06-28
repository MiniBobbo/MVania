package platform.entities.movestates;

import fsm.FSMModule;
import platform.entities.Entity;

/**
 * ...
 * @author Dave
 */
class PlayerRobotPowerUp extends FSMModule 
{

	var time:Float;
	var TIME:Float = .4;
	
	override public function changeTo() 
	{
		parent.acceleration.x = 0;
		parent.velocity.x = 0;
		parent.animation.play('powerup');
		time = TIME;
	}
	
	override public function update(dt:Float) 
	{
		time -= dt;
		if (time <= 0)
			parent.fsm.changeState('ground');
	}
	
}