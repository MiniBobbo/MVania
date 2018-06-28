package platform.entities.enemies;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

enum RatState {
	RUNNING;
	WAITING;
}

/**
 * ...
 * @author Dave
 */
class Rat extends Enemy 
{

	var RAT_HP = 3;
	var ratState:RatState;
	var GRAVITY:Float = 2400;
	
	var delay:Float;
	var WAIT_TIME:Float = 1;
	var RUN_TIME:Float = 1.5;
	
	var RAT_SPEED:Float = -100;

	public function new(map:FlxTilemap) 
	{
		super(map);
		ratState = RatState.WAITING;
		delay = WAIT_TIME;
		acceleration.y = GRAVITY;
		frames = H.getFrames();
		animation.addByPrefix('idle', 'rat_stand_', 10, false);
		animation.addByPrefix('sniff', 'rat_sniff_', 6, false);
		animation.addByPrefix('run', 'rat_run_', 10);
		animation.play('idle');
		setSize(20, 20);
		centerOffsets();
		offset.y += 6;
		hp = RAT_HP;
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		delay -= elapsed;
		
		if (delay <= 0) {
			doSomething();
		}
		
		if (isTouching(FlxObject.WALL))
			doSomething();
			
		super.update(elapsed);
	}
	
	private function doSomething() {
		if (ratState == RatState.RUNNING) {
			delay = WAIT_TIME;
			ratState = RatState.WAITING;
			animation.play('idle');
			velocity.x = 0;
		} else {
			if (FlxG.random.bool()) {
				animation.play('sniff');
				delay = WAIT_TIME;
			} else {
				delay = RUN_TIME;
				ratState = RatState.RUNNING;
				animation.play('run');
				//Run left or right rnadomly.
				var right:Bool = FlxG.random.bool();
				velocity.x = RAT_SPEED;
				if (right) {
					velocity.x *= -1;
					flipX = true;
				} else
					flipX = false;
			}
			
		}
	}
	
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (alive)
			entity.takeDamage(1);
	}
}