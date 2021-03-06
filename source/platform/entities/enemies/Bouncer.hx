package platform.entities.enemies;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * A bouncer just travels around the map in a straight line bouncing off walls and the map edge.
 * @author Dave
 */
class Bouncer extends Enemy 
{
	//How much can the angle vary when bouncing off a surface?
	var ANGLE_VAR:Float = 45;
	var SPEED:Float = 150;
	var DAMAGE:Int = 2;
	
	var v:FlxPoint;
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		hp = 10;
		frames = H.getFrames();
		animation.addByPrefix('bounce', 'bouncer_bounce_', 1, false);
		animation.play('bounce');
		setSize(25, 25);
		centerOffsets();
		v = new FlxPoint(0, -SPEED);
		v.rotate(FlxPoint.weak(), FlxG.random.float( -179, 179));
	}
	
	
	override public function update(elapsed:Float):Void 
	{
		//if (justTouched(FlxObject.ANY)) {
			//newDirection();
		//} 
		if (justTouched(FlxObject.CEILING) || justTouched(FlxObject.FLOOR)) {
			v.y *= -1;
		} else if (justTouched(FlxObject.WALL))
			v.x *= -1;
		
		velocity.copyFrom(v);
		
		//else if (!inWorldBounds()) {
			//newDirection();
		//}
		super.update(elapsed);
	}
	
	/**
	 * Changes the direction the bouncer is traveling.
	 */
	public function newDirection() {
		var newAngle = 180 + FlxG.random.float( -ANGLE_VAR, ANGLE_VAR);
		v.rotate(FlxPoint.weak(), newAngle);
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		entity.takeDamage(DAMAGE);
	}
	
}