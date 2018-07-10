package fsm;
import haxe.ds.StringMap;
import platform.entities.Entity;

/**
 * ...
 * @author Dave
 */
class FSM 
{
	var stateMap:StringMap<FSMModule>;
	var entity:IFSM;
	public var currentModule(default, null):FSMModule;
	public var currentModuleName(default, null):String;
	
	public function new(entity:IFSM) 
	{
		this.entity = entity;
		stateMap = new StringMap<FSMModule>();
	}
	
	public function addtoMap(key:String, module:FSMModule) {
		stateMap.set(key, module);
	}
	
	public function changeState(key:String) {
		if (!stateMap.exists(key))
			return;
		if (currentModule != null)
			currentModule.changeFrom();
		currentModule = stateMap.get(key);
		currentModule.changeTo();
		currentModuleName = key;
	}
	
}