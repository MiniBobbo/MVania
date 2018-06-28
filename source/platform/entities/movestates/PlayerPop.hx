package platform.entities.movestates;

import fsm.FSMModule;
import platform.entities.Entity;

/**
 * ...
 * @author Dave
 */
class PlayerPop extends FSMModule 
{

	var POP_TIME:Float = .2;
	var currentPopTime:Float;
	var GRAVITY:Float = 150;
	
	public function new(parent:Entity) 
	{
		super(parent);
		
	}
	
	override public function changeTo() 
	{
		parent.velocity.y = -50;
		currentPopTime = POP_TIME;
		cast(parent, Player).changeEnergy( -100 );
	}
	
	override public function update(dt:Float) 
	{
		parent.acceleration.y = 150;
		super.update(dt);
		currentPopTime -= dt;
		if (currentPopTime <= 0)
			parent.fsm.changeState('air');
	}
	
	
	
}