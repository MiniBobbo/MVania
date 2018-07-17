package platform.entities.zones;

import flixel.FlxG;
import flixel.util.FlxColor;
import platform.PlatformState;
import platform.entities.Zone;

/**
 * ...
 * @author Dave
 */
class TravelZone extends Zone
{
	var world:String;
	var checkpoint:String;
	var playerHit:Bool = false;
	var hitcount = 0;

	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float, world:String, checkpoint:String) 
	{
		super(X, Y, WIDTH, HEIGHT);
		makeGraphic(Std.int(WIDTH), Std.int(HEIGHT), FlxColor.TRANSPARENT);

		this.world = world;
		this.checkpoint = checkpoint;
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (H.ps.transitioning)	 {
			trace('Already transitioning');
			return;
		}
		
		if (!playerHit && Std.is(entity, Player)) {
			hitcount++;
			trace('Player overlapped the travel zone to ' + world + ' ' + hitcount + ' times');
			playerHit = true;
			H.previousLevel = checkpoint;
			H.currentLevel = world;
			
			
			H.ps.resetState();
			//var ps = new PlatformState();
			//FlxG.switchState(ps);
		}
		
	}

	
}