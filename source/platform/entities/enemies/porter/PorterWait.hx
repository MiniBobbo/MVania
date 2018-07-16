package platform.entities.enemies.porter;

import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class PorterWait extends FSMModule 
{
	var p:Porter;
	
	var WAIT_TIME:Float = 1.5;
	var WAIT_VAR:Float = 1;
	public function new(parent:IFSM) 
	{
		super(parent);
		p = cast parent;
	}
	
	override public function update(dt:Float) 
	{
		
	}
	
}