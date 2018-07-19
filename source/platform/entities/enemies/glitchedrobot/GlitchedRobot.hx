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
		frames = H.getFrames();
		animation.addByPrefix('stand', 'GlitchedRobot_stand_0', 12,false);
		animation.addByPrefix('walk', 'GlitchedRobot_walk_', 6);
		animation.addByPrefix('charge', 'GlitchedRobot_charge_', 18);
		animation.play('stand');
		
		centerOffsets();
		offset.y += 20;
		offset.x += 4;
		setSize(25, 28);

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