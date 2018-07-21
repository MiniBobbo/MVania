package platform.entities.enemies.constructionbot;

import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class ConstructBotFallFSM extends FSMModule 
{

	var c:ConstructionBot;
	public function new(parent:IFSM) 
	{
		super(parent);
		c = cast parent;
	}
	
	
}