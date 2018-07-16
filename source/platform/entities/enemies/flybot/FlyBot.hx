package platform.entities.enemies.flybot;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class FlyBot extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		makeGraphic(15, 15, FlxColor.BLUE);
		hp = 1;
		fsm.addtoMap('wait', new FlybotWait(this));
		fsm.changeState('wait');
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (alive)
			entity.takeDamage();
	}
}