package platform.entities;
import flixel.util.FlxColor;
import fsm.IFSM;
import platform.entities.Entity;
import flixel.FlxSprite;

/**
 * ...
 * @author Dave
 */
class Zone extends FlxSprite implements IFSM
{

	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float) 
	{
		super();
		x = X;
		y = Y;
		width = WIDTH;
		height = HEIGHT;
		
		
	}
	
	public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{

	}
	
	public function changeFSM(name:String):Void {
		
	}
	
}