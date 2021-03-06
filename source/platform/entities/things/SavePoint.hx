package platform.entities.things;

import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class SavePoint extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('idle', 'savepoint_idle_', 12, true);
		animation.addByPrefix('up', 'savepoint_up_', 12, false);
		animation.addByPrefix('down', 'savepoint_down_', 12, false);
		animation.addByPrefix('working', 'savepoint_working_', 12, true);
		animation.play('idle');
		setSize(96,32);
		offset.y = 32;
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		switch (signal) 
		{
			case 'saveup':
				animation.play('up');
			case 'savedown':
				animation.play('down');
			case 'saveworking':
				animation.play('working');
	
			default:
				
		}
	}
}