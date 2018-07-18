package platform.entities.enemies.dillo;

import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class DilloDefailtFSM extends FSMModule 
{
	
	
	var p:ArmoredDillo;
	public function new(parent:IFSM) 
	{
		super(parent);
		p = cast parent;
	}
	
	
	
}