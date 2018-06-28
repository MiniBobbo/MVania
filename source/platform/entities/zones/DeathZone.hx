package platform.entities.zones;

import flixel.util.FlxColor;
import platform.entities.Entity;
import platform.entities.Zone;

/**
 * ...
 * @author Dave
 */
class DeathZone extends Zone 
{

	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float) 
	{
		super(X, Y, WIDTH, HEIGHT);
		makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT);

	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (entity.collideMap) {
			entity.takeDamage(50);
		}
	}
	
}