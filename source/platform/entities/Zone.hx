package platform.entities;
import flixel.util.FlxColor;
import platform.entities.Entity;
import flixel.FlxSprite;

/**
 * ...
 * @author Dave
 */
class Zone extends FlxSprite
{

	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float) 
	{
		super();
		x = X;
		y = Y;
		width = WIDTH;
		height = HEIGHT;
		makeGraphic(Std.int(width), Std.int(height), FlxColor.RED);
		
		
	}
	
	public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{

	}
	
}