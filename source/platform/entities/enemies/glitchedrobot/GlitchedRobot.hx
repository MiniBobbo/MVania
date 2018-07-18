package platform.entities.enemies.glitchedrobot;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class GlitchedRobot extends Enemy 
{
	var TOTAL_HP:Float = 4;
	var wander:Bool = true;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		hp = TOTAL_HP;
		acceleration.y = H.GRAVITY;
		makeGraphic(32, 32, FlxColor.GREEN);
		fsm.addtoMap('wander', new GlitchedRobotWander(this));
		fsm.addtoMap('charge', new GlitchedRobotCharge(this));
		fsm.changeState('wander');
	}
	
	override public function takeDamage(damage:Int = 1) 
	{
		fsm.changeState('charge');
		super.takeDamage(damage);
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (alive)
			entity.takeDamage(1);
	}
	
}