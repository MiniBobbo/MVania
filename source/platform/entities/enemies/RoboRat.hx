package platform.entities.enemies;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.Entity;
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
	
	var MOVE_SPEED:Float = 200;
	var TURN_TIME:Float = .3;
	var turnTime:Float = 0;
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		makeGraphic(25, 25, FlxColor.GREEN);
		setSize(25, 25);
		acceleration.y = H.GRAVITY;
		
		FlxG.watch.add(this, 'left');
		FlxG.watch.add(this, 'leftX');
		FlxG.watch.add(this, 'rightX');
	}
	
	public function setFinishPosition(start:Float, finish:Float) {
		if (finish > start) {
			leftX = start;
			rightX = finish;
		} else {
			leftX = finish;
			rightX = start;
		}
		
		if (rightX == start)
			left = true;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (turnTime > 0) { 
			turnTime -= elapsed;
			return;
		}

		super.update(elapsed);
		
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
	
	private function switchDirections() {
		left = !left;
		turnTime = TURN_TIME;
		
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (alive)
			entity.takeDamage(2);
	}
}