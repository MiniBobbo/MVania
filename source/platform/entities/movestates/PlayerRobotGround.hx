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
		FlxG.watch.add(this, 'shootAnim');
		FlxG.watch.add(this, 'lastShootAnim');
		player = cast e;
	}
	
	override public function update(dt:Float) 
	{
		//trace('Running player ground');
		
		parent.velocity.x = 0;
		player.addEnergyStep(dt);
		//if (i.isButtonJustPressed('attack')) {
			//entity.changeMoveState(MovementStateEnum.ATTACKING);
		//}
		//
		//if (i.isButtonPressed('down'))
			//entity.changeMoveState(MovementStateEnum.CROUCHING);
		
		if (i.isButtonPressed('left') && !i.isButtonPressed('right')) {
			parent.velocity.x -= RUN_SPEED; 
		}
		else if (i.isButtonPressed('right') && !i.isButtonPressed('left') ) {
			parent.velocity.x += RUN_SPEED; 
		}
		else {
			
		}
		
		if (i.isButtonJustPressed('jump') || !parent.isTouching(FlxObject.FLOOR)) {
			parent.y -= .5;
			parent.velocity.y = 0;
			//jump.play();
			parent.fsm.changeState('air');
		}
		
		if (i.isButtonJustPressed('attack')) {
			shoot();
		}

		
		setAnimation();
		
		//if(i.isButtonJustPressed('jump'))
	}
	
	private function shoot() {
		try{
		player.shoot();
			
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
				parent.animation.play('runshoot');
			else {
				parent.animation.play('run');
			}
			
		}
		else if (i.isButtonPressed('right') && !i.isButtonPressed('left') ) {
			if(shootAnim)
				parent.animation.play('runshoot');
			else {
				parent.animation.play('run');
			}
		}
		else {
			if(!shootAnim)
				parent.animation.play('idle');
			else
				parent.animation.play('idleshoot');
		}
		
		if (i.isButtonJustPressed('jump') || !parent.isTouching(FlxObject.FLOOR)) {
			parent.animation.play('jumpup');
		}
		
		
		lastShootAnim = shootAnim;
	}
	
}