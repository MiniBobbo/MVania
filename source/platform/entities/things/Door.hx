package platform.entities.things;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Door extends Enemy 
{

	public var locked(default, null):Bool = true;
	public var code:Int;
	
	public function new(collisionMap:FlxTilemap, code:Int) 
	{
		super(collisionMap);
		immovable = true;
		makeGraphic(28, 96, FlxColor.BROWN);
		setSize(28, 96);
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
		alpha = 1;
		hp = -1;
	}
	
	private function unlockDoor() {
		locked = false;
		alive = false;
		alpha = .3;
		hp = 0;
	}
}