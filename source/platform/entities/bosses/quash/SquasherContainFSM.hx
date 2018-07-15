package platform.entities.bosses.quash;

import flixel.tweens.FlxTween;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class SquasherContainFSM extends FSMModule 
{

	var s:Squasher;
	
	var MOVE_TIME:Float = .5;
	var t:FlxTween;
	
	var MIN_X:Float = 32;
	var MAX_X:Float = 380;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		s = cast parent;
	}
	
	override public function changeFrom() 
	{
		if (t != null)
		t.cancelChain();
	}
	
	override public function changeTo() 
	{
		s.rightArm.signal('up');
		s.leftArm.signal('up');
		var moveX = H.ps.player.x - 180;
		if (moveX < MIN_X)
		moveX = MIN_X;
		if (moveX > MAX_X)
		moveX = MAX_X;
		t = FlxTween.tween(s.pos, {x:moveX }, MOVE_TIME, {onComplete:function(_) {
			parent.changeFSM('fire'); 
			s.leftArm.signal('down'); 
			s.rightArm.signal('down'); 
		}});
	}
	
	
	
}