package platform.entities.enemies;

import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class HoverBot extends Enemy 
{

	var accelDir:FlxPoint;
	var ACCELERATION:Float = 100;
	var MAX_SPEED:Float = 200;
	var MAX_ANGLE:Float = 40;
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('fly', 'flybot_fly_', 30);
		animation.play('fly');
		setSize(25, 25);
		maxVelocity.set(MAX_SPEED, MAX_SPEED);
		hp = 3;
		centerOffsets();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		accelDir = FlxPoint.get(0, -ACCELERATION);
		accelDir.rotate(FlxPoint.weak(), getMidpoint().angleBetween(H.ps.player.getMidpoint()));
		acceleration.copyFrom(accelDir);
		accelDir.put();
		if (acceleration.x > 0 && angle < MAX_ANGLE)
		angle += 60 * elapsed;
		if (acceleration.x < 0 && angle > -MAX_ANGLE)
		angle -= 60 * elapsed;
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		super.overlapEntity(entity, data);
		entity.takeDamage(1);
	}
	
}