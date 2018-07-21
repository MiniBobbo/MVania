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

	var MAX_HP:Float = 60;
	
	//The bot will jump from the right to the left side of the screen.  This keeps track of what side he is on.
	public var right:Bool = true;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('idle', 'constructbot_idle_', 16);
		animation.addByPrefix('jumping', 'constructbot_jumping_', 16);
		animation.addByPrefix('prepjump', 'constructbot_prepjump_', 16, false);
		animation.addByPrefix('up', 'constructbot_up_', 8, false);
		animation.addByPrefix('down', 'constructbot_down_', 8, false);
		animation.addByPrefix('getup', 'constructbot_getup_', 8, false);
		animation.addByPrefix('side', 'constructbot_side_', 8, false);
		animation.addByPrefix('land', 'constructbot_land_', 8, false);
		animation.play('idle');
		
		setSize(75, 65);
		centerOffsets();
		offset.y += 14;
		hp = MAX_HP;
		
		acceleration.y = H.GRAVITY;
		
		
		var wait = new WaitFSM(this);
		wait.addPossibleState('shoot');
		wait.addPossibleState('jump');
		wait.setWait(.25, 0);
		
		fsm.addtoMap('wait', wait);
		fsm.addtoMap('jump', new ConstructBotJumpFSM(this));
		fsm.addtoMap('shoot', new ConstructionBotShootFSM(this));
		
		fsm.changeState('wait');
		
		
	}
	
	override public function kill():Void 
	{
		super.kill();
		H.setFlag(0, false);
	}
	
}