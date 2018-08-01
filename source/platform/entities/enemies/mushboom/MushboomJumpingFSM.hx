package platform.entities.enemies.mushboom;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;
import platform.entities.Attack.AttackTypes;

/**
 * ...
 * @author Dave
 */
class MushboomJumpingFSM extends FSMModule 
{

	var c:Mushboom;
	var timer:FlxTimer;
	var JUMP_STR_X:Float = 200;
	var JUMP_STR_Y:Float = 300;

	var jumpLeft:Bool = true;
	var inAir:Bool = false;
	var stomping:Bool = false;
	
	var LAND_TIME:Float = .5;
	var HOLD_STOMP_TIME:Float = .25;
	
	var SHOCKWAVE_SPEED:Float = 200;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		c = cast parent;
		timer = new FlxTimer();
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
	}
	
	override public function changeTo() 
	{
		inAir = true;
		stomping = false;
		c.acceleration.y = H.GRAVITY / 4;
		c.animation.play('jumping' );
	}
	
	override public function update(dt:Float) 
	{
		var playX = H.ps.player.getMidpoint().x;
		var mushX = c.getMidpoint().x;
		var dist = playX - mushX;
		if (dist < 20 && dist > -20) {
			stomp();
		}
			
		
		if (c.isTouching(FlxObject.FLOOR))
			landed();
	}
	
	private function landed() {
		if (!inAir)
			return;
		inAir = false;
		FlxG.camera.shake(.02, .2);
		var l = H.ps.getEnemyAttack();
		AttackFactory.configAttack(l, AttackTypes.SHOCKWAVE);
		l.flipX = true;
		l.newInitAttack(FlxPoint.weak(c.x + 50, c.y + 37), FlxPoint.weak(-SHOCKWAVE_SPEED, 0), 5, AttackTypes.SHOCKWAVE);
		var r = H.ps.getEnemyAttack();
		AttackFactory.configAttack(r, AttackTypes.SHOCKWAVE);
		r.newInitAttack(FlxPoint.weak(c.x, c.y + 37), FlxPoint.weak(SHOCKWAVE_SPEED, 0), 5, AttackTypes.SHOCKWAVE);

		c.velocity.x = 0;
		c.animation.play('land');
		timer.start(LAND_TIME, function(_) {
			c.animation.play('idle');
			parent.changeFSM('wait');
		});
	}

	private function stomp() {
		//Only run once.
		if (stomping) 
		return;
		stomping = true;
		
		c.velocity.set();
		c.acceleration.set();
		timer.start(HOLD_STOMP_TIME, function(_) {
			c.acceleration.y = H.GRAVITY;
			
		});
		
	}
}