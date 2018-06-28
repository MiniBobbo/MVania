package platform.entities.enemies;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.Attack;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class PlantBlocker extends Enemy 
{
	var DAMAGE:Int = 1;
	var KNOCKBACK_STR:Float = 300;
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		immovable = true;
		frames = H.getFrames();
		animation.addByPrefix('plant', 'plantblocker_plant');
		animation.play('plant');
		setSize(28, 28);
		centerOffsets();
		hp = 3;
		
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		entity.takeDamage(DAMAGE);
		entity.signal('stun', FlxPoint.weak(0, -KNOCKBACK_STR).rotate(FlxPoint.weak(), getMidpoint().angleBetween(entity.getMidpoint())));
		//FlxG.collide(this, entity);
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		switch (signal) 
		{
			case 'hit':
				var a:Attack = cast data;
				if (a.animation.name == 'fireshotend') {
					takeDamage(1);
				}
					
					
			default:
				
		}
	}
}