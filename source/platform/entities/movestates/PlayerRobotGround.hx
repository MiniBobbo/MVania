package platform.entities.movestates;

import fsm.FSMModule;
import platform.entities.Entity;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxSound;
import inputhelper.InputHelper;
import platform.entities.Player;

/**
 * ...
 * @author Dave
 */
class PlayerRobotGround extends FSMModule 
{
	var RUN_SPEED:Float = 250;
	var jump:FlxSound;
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
	
	override public function changeTo() 
	{
		player.resetBoost();
	}
	
	override public function update(dt:Float) 
	{
		//trace('Running player ground');
		
		player.velocity.x = 0;
		player.addEnergyStep(dt);
		//if (i.isButtonJustPressed('attack')) {
			//entity.changeMoveState(MovementStateEnum.ATTACKING);
		//}
		//
		//if (i.isButtonPressed('down'))
			//entity.changeMoveState(MovementStateEnum.CROUCHING);
		
		if (i.isButtonPressed('left') && !i.isButtonPressed('right')) {
			player.velocity.x -= RUN_SPEED; 
		}
		else if (i.isButtonPressed('right') && !i.isButtonPressed('left') ) {
			player.velocity.x += RUN_SPEED; 
		}
		else {
			
		}
		
		if (i.isButtonJustPressed('jump') || !player.isTouching(FlxObject.FLOOR)) {
			player.y -= .5;
			player.velocity.y = 0;
			//jump.play();
			player.fsm.changeState('air');
		} else if (i.isButtonJustPressed('boost')) {
			player.signal('boost');
			return;
		}
		
		if (i.isButtonJustPressed('attack')) {
			player.shoot(player.currentAttackType);
		}

		
		setAnimation();
		
		//if(i.isButtonJustPressed('jump'))
	}
	
	private function shoot() {
		try{
		player.shoot(player.currentAttackType);
			
		} catch (err:Dynamic)
		{
			trace(err);
		}
	}
	
	private function setAnimation() {
		if (player.attackDelay > 0) 
			shootAnim = true;
		else 
			shootAnim = false;
			
			
		if (i.isButtonPressed('left') && !i.isButtonPressed('right')) {
			if(shootAnim)
				player.animation.play('runshoot');
			else {
				player.animation.play('run');
			}
			
		}
		else if (i.isButtonPressed('right') && !i.isButtonPressed('left') ) {
			if(shootAnim)
				player.animation.play('runshoot');
			else {
				player.animation.play('run');
			}
		}
		else {
			if(!shootAnim)
				player.animation.play('idle');
			else
				player.animation.play('idleshoot');
		}
		
		if (i.isButtonJustPressed('jump') || !player.isTouching(FlxObject.FLOOR)) {
			player.animation.play('jumpup');
		}
		
		
		lastShootAnim = shootAnim;
	}
	
}