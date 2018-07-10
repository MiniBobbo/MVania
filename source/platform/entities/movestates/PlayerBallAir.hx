package platform.entities.movestates;

import flixel.FlxObject;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import inputhelper.InputHelper;
import platform.entities.Entity;

/**
 * ...
 * @author Dave
 */
class PlayerBallAir extends FSMModule 
{

	var lastVelocity:Float;
	
	public var JUMP_STRENGTH(default, null):Int = 150;
	public var JUMP_FALL_STRENGTH(default, null):Int = 150;
	public var JUMP_TIME(default, null):Float = .3;
	public var JUMP_SPEED(default, null):Float = 200;
	
	var attacking:Bool = false;
	var attackingTimer:FlxTimer;
	
	var jumpElapsed:Float = 0;
	
	//Energy cost per second to float
	var FLOAT_COST:Float = 5;
	var FLOAT_GRAVITY_MOD = .2;
	
	var player:Player;
	
	public function new(e:Entity) 
	{
		super(e);
		attackingTimer = new FlxTimer();
		//swoosh = FlxG.sound.load('assets/sounds/swoosh.wav');
		player = cast e;
	}
	
	override public function changeTo() 
	{
		jumpElapsed = 0;
		lastVelocity = 0;
		
	}
	
	override public function changeFrom() 
	{
		attackingTimer.cancel();
	}
	
	override public function update(dt:Float) 
	{
		var i = InputHelper;

		player.acceleration.x = 0;
		
		jumpElapsed += dt;
		if (player.isTouching(FlxObject.FLOOR)) {
			//parent.scale.x = 1.2;
			//parent.scale.y = .8;
			//FlxTween.tween(parent.scale, {x:1, y:1}, .2);
			//FlxG.sound.play('assets/sounds/land.ogg');
			player.fsm.changeState('ground');
			return;
		}
		
		if (i.isButtonPressed('left')) 
			player.acceleration.x -= JUMP_SPEED; 
		if (i.isButtonPressed('right')) 
			player.acceleration.x += JUMP_SPEED; 
		if (i.isButtonPressed('jump') && player.energy > 0) {
			player.changeEnergy(-FLOAT_COST * dt);
			player.maxVelocity.y = JUMP_STRENGTH;
			player.acceleration.y = -JUMP_STRENGTH;
			player.animation.play('floatup');
		} else {
			player.maxVelocity.y = JUMP_FALL_STRENGTH;
			player.acceleration.y = H.GRAVITY*FLOAT_GRAVITY_MOD;
			player.animation.play('float');
		}
		
		if ((player.acceleration.x > 0 && player.velocity.x < 0) || player.acceleration.x < 0 && player.velocity.x > 0)
		player.acceleration.x *= 2;
			
		var currentVelocity:Float = player.velocity.y;

	}
	
	
}