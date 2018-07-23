package platform.entities.zones;

import flixel.util.FlxColor;
import platform.entities.Entity;
import platform.entities.Zone;

/**
 * ...
 * @author Dave
 */
class DamageZone extends Zone 
{

	var damage:Int = 1;
	
	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float, damage:Float) 
	{
		super(X, Y, WIDTH, HEIGHT);
		makeGraphic(Std.int(WIDTH), Std.int(HEIGHT), FlxColor.TRANSPARENT);
		setPosition(X,Y);
		changeDamage(damage);
	}

	public function changeDamage(damage:Float) {
		this.damage = Std.int(damage);
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		entity.takeDamage(damage);
	}
	
}