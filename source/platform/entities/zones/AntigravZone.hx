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
	public var antigrav_on(default, set):Bool = true;
	
	
	
	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float) 
	{
		super(X, Y, WIDTH, HEIGHT);
		//frames = H.getFrames();
		//animation.addByPrefix('on', 'icons_antigrav', 12);
		//animation.play('on');
		//scale.y = height/32;
		//setSize(WIDTH, HEIGHT);
		//centerOffsets();
		
		makeGraphic(Std.int(width), Std.int(height), FlxColor.YELLOW);
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
	
  function set_antigrav_on(antigrav_on) {
	if (antigrav_on)
		visible = true;
	else
		visible = false;
    return this.antigrav_on = antigrav_on;
  }
	
}