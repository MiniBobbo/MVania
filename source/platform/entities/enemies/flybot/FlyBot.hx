package platform.entities.enemies.flybot;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;
import platform.entities.movestates.DeadFadeState;

/**
 * ...
 * @author Dave
 */
class FlyBot extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('fly', 'bugbot_flying_');
		animation.play('fly');
		setSize(16, 16);
		centerOffsets();
		hp = 1;
		fsm.addtoMap('wait', new FlybotWait(this));
		//fsm.addtoMap('dead', new DeadFadeState(this));
		fsm.changeState('wait');
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (alive)
			entity.takeDamage();
	}
}