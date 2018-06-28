package platform.entities.movestates;

import fsm.FSMModule;
import platform.entities.Entity;
import platform.entities.Player;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import inputhelper.InputHelper;

/**
 * ...
 * @author Dave
 */
class PlayerRobotAir extends FSMModule 
{
	var lastVelocity:Float;
	
	public var JUMP_STRENGTH(default, null):Int = 250;
	public var JUMP_FALL_STRENGTH(default, null):Int = 250;
	public var JUMP_TIME(default, null):Float = .45;
	public var JUMP_SPEED(default, null):Float = 250;
	
	var attacking:Bool = false;
	var attackingTimer:FlxTimer;
	
	var jumpElapsed:Float = 0;
	
	var swoosh:FlxSound;
	
	var player:Player;
	
	public function new(e:Entity) 
	{
		super(e);
		FlxG.watch.add(this, 'jumpElapsed', 'Player Jump Elapsed');
		attackingTimer = new FlxTimer();
		//swoosh = FlxG.sound.load('assets/sounds/swoosh.wav');
		player = cast e;
	}
	
	override public function changeTo() 
	{
		jumpElapsed = 0;
		lastVelocity = 0;
		attacking = false;
		
	}
	
	override public function changeFrom() 
	{
		attackingTimer.cancel();
	}
	
	override public function update(dt:Float) 
	{
		var i = InputHelper;

		player.velocity.x = 0;
		player.addEnergyStep(dt);
		jumpElapsed += dt;
		if (parent.isTouching(FlxObject.FLOOR)) {
			//parent.scale.x = 1.2;
			//parent.scale.y = .8;
			//FlxTween.tween(parent.scale, {x:1, y:1}, .2);
			//FlxG.sound.play('assets/sounds/land.ogg');
			parent.fsm.changeState('ground');
			return;
		}  else if (i.isButtonJustPressed('boost')) {
			parent.signal('boost');			
			return;
		}
		
		if (i.isButtonPressed('left')) 
			parent.velocity.x -= JUMP_SPEED; 
		if (i.isButtonPressed('right')) 
			parent.velocity.x += JUMP_SPEED; 
		if (i.isButtonPressed('jump') && !parent.isTouching(FlxObject.CEILING) && jumpElapsed <= JUMP_TIME) {
			parent.maxVelocity.y = JUMP_STRENGTH;
			parent.velocity.y = -JUMP_STRENGTH;
		} else {
			parent.maxVelocity.y = JUMP_FALL_STRENGTH;
			jumpElapsed = JUMP_TIME +1;
			
		}
		var currentVelocity:Float = parent.velocity.y;
		
		
		if (i.isButtonJustPressed('attack')) {
			player.shoot();
		}
		//Animation section
		if (player.attackDelay >= 0)
			player.animation.play('jumpshot');
		else if (player.velocity.y < 0 && player.animation.name != 'jumpup' )
			player.animation.play('jumpup');
		else if (player.velocity.y > 0 && player.animation.name != 'jumpdown' )
			player.animation.play('jumpdown');
		

	}
	
}