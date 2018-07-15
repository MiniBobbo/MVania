package platform.entities.zones;

import flixel.util.FlxColor;
import platform.entities.Zone;

/**
 * ...
 * @author Dave
 */
class AntigravZone extends Zone 
{
	var strength:Float = 30;
	var antigrav_on:Bool = true;
	
	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float) 
	{
		super(X, Y, WIDTH, HEIGHT);
		makeGraphic(Std.int(width), Std.int(height), FlxColor.BLUE);
		alpha = .3;

	}

	public function setStrength(strength:Float) {
		this.strength = strength;
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if(antigrav_on)
			entity.velocity.y = -strength; 
	}
	
}