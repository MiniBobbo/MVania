package platform.entities.things;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.gameentites.Enemy;
import platform.entities.zones.AntigravZone;

/**
 * ...
 * @author Dave
 */
class AntiGravGenerator extends Enemy 
{
	
	var antigrav:AntigravZone;
	var code:Int = 0;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		collideMap = false;
		//makeGraphic(32, 32, FlxColor.LIME);
		frames = H.getFrames();
		animation.addByPrefix('off', 'icons_antigrav_off_', 12, false);
		animation.addByPrefix('on', 'icons_antigrav_on_', 12, true);
		animation.play('off');
		setSize(32, 32);
		centerOffsets();
	}
	
	public function setAntiGrav(antigrav:AntigravZone) {
		this.antigrav = antigrav;
	}
	
	public function setCode(code:Int) {
		this.code = code;
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		if (code != 0) {
			if (data == null || Std.parseInt(data) != code)
				return;
		}
		switch (signal) 
		{
			case 'activate':
				antigrav.antigrav_on = !antigrav.antigrav_on;
			case 'on':
				antigrav.antigrav_on = true;
			case 'off':
				antigrav.antigrav_on = false;
			case 'switch':
				antigrav.antigrav_on = !antigrav.antigrav_on;

			default:
				
		}
		if (antigrav.antigrav_on)
			animation.play('on');
		else
			animation.play('off');
	}
	
}