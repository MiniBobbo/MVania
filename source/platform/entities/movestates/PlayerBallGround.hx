package platform.entities.movestates;

import flixel.FlxObject;
import fsm.FSMModule;
import inputhelper.InputHelper;
import platform.entities.Entity;

/**
 * ...
 * @author Dave
 */
class PlayerBallGround extends FSMModule 
{

	var RUN_SPEED:Float = 200;
	//var jump:FlxSound;
	var shootAnim:Bool = false;
	var lastShootAnim:Bool = false;
	
	
	
	var i = InputHelper;
	
	var player:Player;
	public function new(e:Entity) 
	{
		super(e);
		//jump = FlxG.sound.load('assets/sounds/jump2.ogg');
		player = cast e;
	}
	
	override public function update(dt:Float) 
	{
		//trace('Running player ground');
		
		parent.acceleration.x = 0;
		player.changeEnergy(player.energyChargeRate * dt);
		
		//if (i.isButtonJustPressed('attack')) {
			//entity.changeMoveState(MovementStateEnum.ATTACKING);
		//}
		//
		//if (i.isButtonPressed('down'))
			//entity.changeMoveState(MovementStateEnum.CROUCHING);
		
		if (i.isButtonPressed('left') && !i.isButtonPressed('right')) {
			parent.acceleration.x -= RUN_SPEED; 
		}
		else if (i.isButtonPressed('right') && !i.isButtonPressed('left') ) {
			parent.acceleration.x += RUN_SPEED; 
		}
		else {
			
		}
		
				if ((parent.acceleration.x > 0 && parent.velocity.x < 0) || parent.acceleration.x < 0 && parent.velocity.x > 0)
		parent.acceleration.x *= 2;
		
		if (i.isButtonJustPressed('jump') || !parent.isTouching(FlxObject.FLOOR)) {
			parent.y -= .5;
			parent.velocity.y = 0;
			//jump.play();
			parent.fsm.changeState('air');
		}
		
		//if (i.isButtonJustPressed('attack')) {
			//shoot();
		//}

		
		//setAnimation();
		
		//if(i.isButtonJustPressed('jump'))
	}
	
	override public function changeTo() 
	{
		parent.animation.play('float');
	}
}