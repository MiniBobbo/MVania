package platform.entities.things;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class HorizDoor extends Enemy 
{

	public var locked(default, null):Bool = true;
	public var code:Int;
	
	public function new(collisionMap:FlxTilemap, code:Int) 
	{
		super(collisionMap);
		immovable = true;
		//makeGraphic(28, 96, FlxColor.BROWN);
		frames = H.getFrames();
		animation.addByPrefix('open', 'door_open_', 24, false);
		animation.addByPrefix('close', 'door_close_', 24, false);
		animation.addByPrefix('closed', 'door_closed_', 24, false);
		animation.addByPrefix('opened', 'door_opened_', 24, false);
		animation.play('closed');
		angle = 90;
		setSize(96, 28);
		centerOffsets();
		centerOrigin();
		this.code = code;

	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if(locked)
			FlxG.collide(this,entity);
	}
	
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		//Doors can only receive activate signals.
		if (signal != 'activate') 
			return;
		var sentCode:Int = cast data;
		if (code == sentCode)
			unlockDoor();
	}
	
	public function lockDoor() {
		locked = true;
		alive = true;
		//alpha = 1;
		hp = -1;
		animation.play('close');
	}
	
	private function unlockDoor() {
		locked = false;
		alive = false;
		//alpha = .3;
		hp = 0;
		animation.play('open');
	}
}