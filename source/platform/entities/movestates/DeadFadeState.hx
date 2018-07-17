package platform.entities.movestates;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class DeadFadeState extends FSMModule 
{
	var p:FlxSprite;
	var DEATH_TIME:Float = .5;

	public function new(parent:IFSM) 
	{
		super(parent);
		p = cast parent;
		
	}
	
	override public function changeTo() 
	{
		FlxSpriteUtil.fadeOut(p, DEATH_TIME, function(_) {p.kill(); });
	}
	
}