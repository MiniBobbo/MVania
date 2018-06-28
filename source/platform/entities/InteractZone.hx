package platform.entities;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Dave
 */
class InteractZone extends FlxSprite
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
	
	public function interact() {
		
	}
	
}