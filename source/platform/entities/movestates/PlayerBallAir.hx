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

		parent.acceleration.x = 0;
		
		jumpElapsed += dt;
		if (parent.isTouching(FlxObject.FLOOR)) {
			//parent.scale.x = 1.2;
			//parent.scale.y = .8;
			//FlxTween.tween(parent.scale, {x:1, y:1}, .2);
			//FlxG.sound.play('assets/sounds/land.ogg');
			parent.fsm.changeState('ground');
			return;
		}
		
		if (i.isButtonPressed('left')) 
			parent.acceleration.x -= JUMP_SPEED; 
		if (i.isButtonPressed('right')) 
			parent.acceleration.x += JUMP_SPEED; 
		if (i.isButtonPressed('jump') && player.energy > 0) {
			player.changeEnergy(-FLOAT_COST * dt);
			parent.maxVelocity.y = JUMP_STRENGTH;
			parent.acceleration.y = -JUMP_STRENGTH;
			parent.animation.play('floatup');
		} else {
			parent.maxVelocity.y = JUMP_FALL_STRENGTH;
			player.acceleration.y = H.GRAVITY*FLOAT_GRAVITY_MOD;
			parent.animation.play('float');
		}
		
		if ((parent.acceleration.x > 0 && parent.velocity.x < 0) || parent.acceleration.x < 0 && parent.velocity.x > 0)
		parent.acceleration.x *= 2;
			
		var currentVelocity:Float = parent.velocity.y;

	}
	
	
}