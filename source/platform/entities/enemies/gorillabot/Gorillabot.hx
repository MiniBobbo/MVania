package platform.entities.enemies.gorillabot;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import fsm.WaitFSM;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Gorillabot extends Enemy 
{

	var MAX_HP:Float = 10;
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		acceleration.y = H.GRAVITY / 3;
		frames = H.getFrames();
		hp = MAX_HP;
		
		animation.addByPrefix('idle', 'gorillabot_idle_', 1, false);
		animation.addByPrefix('jump', 'gorillabot_jump_', 1, false);
		animation.addByPrefix('smash', 'gorillabot_smash_', 12, false);
		animation.play('idle');
		
		setSize(40, 40);
		centerOffsets();
		offset.y = 24;
		
		
		
		var wait = new WaitFSM(this);
		//wait.addPossibleState('wait');
		wait.addPossibleState('jump');
		wait.addPossibleState('smash');
		wait.setWait(1, 1.5);
		
		var attack = new WaitFSM(this);
		attack.addPossibleState('jump');
		attack.addPossibleState('smash');
		//attack.addPossibleState('attack');
		
		attack.setWait(.5, 1);
		
		
		fsm.addtoMap('wait', wait);
		fsm.addtoMap('attack', attack);
		fsm.addtoMap('jump', new GorillabotJumpFSM(this));
		fsm.addtoMap('jumpattack', new GorillabotJumpFSM(this, 'attack', 500));
		fsm.addtoMap('smash', new GorillabotSmashFSM(this));
		
		fsm.changeState('wait');
		
	}
	
}