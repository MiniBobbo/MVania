package platform.entities.enemies;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.Attack.AttackTypes;
import platform.entities.Entity;
import platform.entities.attacks.UnivAttack;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class RoboRat extends Enemy 
{

	var leftX:Float;
	var rightX:Float;
	var left:Bool = false;
	
	var MOVE_SPEED:Float = 100;
	var TURN_TIME:Float = 1;
	var turnTime:Float = 0;
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('go', 'robomouse_normal_0', 10, false);
		animation.addByPrefix('prep', 'robomouse_spring_', 4, false);
		
		setSize(28, 12);
		centerOffsets();
		offset.y += 8;
		acceleration.y = H.GRAVITY;
		
		hp = 3;
		
		FlxG.watch.add(this, 'turnTime');
		
	}
	
	public function setFinishPosition(start:Float, finish:Float) {
		if (finish > start) {
			leftX = start;
			rightX = finish;
		} else {
			leftX = finish;
			rightX = start;
		}
		
		if (rightX == start){
			left = true;
		} else
			flipX = true;
	}
	
	override public function update(elapsed:Float):Void 
	{

		super.update(elapsed);

		if (turnTime > 0) { 
			velocity.x = 0;
			turnTime -= elapsed;
		} else {
			animation.play('go');
			
			//If we went too far, switch directions.
			if (x > rightX || x < leftX) {
				switchDirections();
			}
			
			velocity.x = 0;
			if (left)
			velocity.x = -MOVE_SPEED;
			else 
			velocity.x = MOVE_SPEED;
		}
	}
	
	private function switchDirections() {
		left = !left;
		turnTime = TURN_TIME;
		flipX = !flipX;
		animation.play('prep');
		
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (alive)
			entity.takeDamage(1);
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		switch (signal) 
		{
			case 'hit':
				var a:UnivAttack = cast data;
				trace('Hit by attack ' + a.type);
				if (a.type == AttackTypes.ELECTRIC) {
					takeDamage(1);
				}
					
					
			default:
				
		}
	}
}