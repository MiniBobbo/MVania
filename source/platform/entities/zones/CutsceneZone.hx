package platform.entities.zones;

import flixel.util.FlxColor;
import platform.entities.Entity;
import platform.entities.Zone;
import states.CutsceneSubstate;

/**
 * ...
 * @author Dave
 */
class CutsceneZone extends Zone 
{

	var flag:String = '0';
	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float, flag:String = '0') 
	{
		super(X, Y, WIDTH, HEIGHT);
		makeGraphic(Std.int(WIDTH), Std.int(HEIGHT), FlxColor.TRANSPARENT);
		setPosition(X, Y);
		this.flag = flag;
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		//Only the player can overlap a cutscene state
		if (Std.is(entity, Player)) {
			this.kill();
			H.ps.openSubState(new CutsceneSubstate(flag));
		}
	}
	
}