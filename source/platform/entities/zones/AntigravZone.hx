package platform.entities.zones;

import flixel.util.FlxColor;
import platform.entities.Zone;

/**
 * ...
 * @author Dave
 */
class AntigravZone extends Zone 
{

	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float) 
	{
		super(X, Y, WIDTH, HEIGHT);
		makeGraphic(Std.int(width), Std.int(height), FlxColor.BLUE);
		alpha = .3;

	}

	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		entity.acceleration.y = -H.GRAVITY; 
	}
	
}