package platform.entities.movestates;

import flixel.FlxObject;
import fsm.FSMModule;
import platform.entities.Entity;
import platform.entities.Player;

/**
 * ...
 * @author Dave
 */
class PlayerRobotStun extends FSMModule 
{
	var p:Player;
	
	var STUN_TIME:Float = .3;
	var stunTime:Float = 0;
	public function new(parent:Entity) 
	{
		super(parent);
		p = cast parent;
	}
	
	
	override public function changeTo() 
	{
		p.animation.play('stun');
		stunTime = STUN_TIME;
	}
	
	override public function changeFrom() 
	{
		p.drag.x = 0;
	}	
	override public function update(dt:Float) 
	{
		super.update(dt);
		if (p.isTouching(FlxObject.FLOOR))
			p.drag.x = 500;
		else 
			p.drag.x = 0;
		stunTime -= dt;
		if (stunTime <= 0 )
			p.fsm.changeState('ground');
	}
	
}