package platform.entities.enemies.glitchedrobot;

import flixel.FlxG;
import flixel.FlxObject;
import fsm.FSMModule;
import fsm.IFSM;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class GlitchedRobotCharge extends FSMModule 
{
	var CHARGE_SPEED:Float = 100;
	
	var p:Enemy;
	public function new(parent:IFSM) 
	{
		super(parent);
		p = cast parent;
	}
	
	override public function changeTo() 
	{
		super.changeTo();
		chargeRandom();
	}

	private function chargeRandom() {
		p.velocity.x = CHARGE_SPEED;
		if (FlxG.random.bool())
			p.velocity.x *= -1;
	}
	
	override public function update(dt:Float) 
	{
		super.update(dt);
		if (p.justTouched(FlxObject.FLOOR))
			chargeRandom();
	}
	
}