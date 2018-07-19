package platform.entities.enemies.glitchedrobot;

import flixel.FlxG;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class GlitchedRobotWander extends FSMModule 
{
	var p:GlitchedRobot;
	var wanderTime:Float = 1.5;
	var WANDER_TIME:Float = 1.5;
	var STAND_TIME:Float = 3;
	var VAR_TIME:Float = 1;
	
	var SPEED:Float = 50;
	
	var wandering:Bool = false;
	var left:Bool = false;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		p = cast parent;
	}
	
	override public function changeTo() 
	{	
		wandering = false;
		p.velocity.x = 0;
		wanderTime = STAND_TIME + FlxG.random.float(0, VAR_TIME);
	}
	
	override public function update(dt:Float) 
	{
		super.update(dt);
		
		
		wanderTime -= dt;
		if (wanderTime > 0)
			return;
			
		if (wandering) {
			p.velocity.x = 0;
			p.animation.play('stand');
			wandering = false;
			wanderTime = STAND_TIME + FlxG.random.float(0, VAR_TIME);
		} else {
			wandering = true;
			p.animation.play('walk');
			left = FlxG.random.bool();
			if (left)	
				p.flipX = false;
			else
				p.flipX = true;
			wanderTime = WANDER_TIME + FlxG.random.float(0, VAR_TIME);
			p.velocity.x = SPEED;
			if (left)
			p.velocity.x *= -1;
			
		}
	}
	
}