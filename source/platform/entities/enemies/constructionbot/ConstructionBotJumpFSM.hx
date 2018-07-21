package platform.entities.enemies.constructionbot;

import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class ConstructionBotJumpFSM extends FSMModule 
{

	var jumpDelay:Float;
	var JUMP_DELAY:Float = 1;
	
	var c:ConstructionBot;
	public function new(parent:IFSM) 
	{
		super(parent);
		c = cast parent;
	}
	
	override public function changeTo() 
	{
		c.animation.play('prejump');
		jumpDelay = JUMP_DELAY;
	}

	
	
	
}