package platform.entities.enemies.constructionbot;

import flixel.tile.FlxTilemap;
import fsm.WaitFSM;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class ConstructionBot extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('idle', 'constructbot_idle_', 16);
		animation.addByPrefix('jumping', 'constructbot_jumping_', 16);
		animation.addByPrefix('prejump', 'constructbot_prejump_', 16, false);
		animation.addByPrefix('up', 'constructbot_up_', 8, false);
		animation.addByPrefix('down', 'constructbot_down_', 8, false);
		animation.addByPrefix('getup', 'constructbot_getup_', 8, false);
		animation.addByPrefix('side', 'constructbot_side_', 8, false);
		animation.play('idle');
		
		setSize(75, 65);
		centerOffsets();
		offset.y += 8;
		
		
		var wait = new WaitFSM(this);
		
		fsm.addtoMap('wait', wait);
		
	}
	
}