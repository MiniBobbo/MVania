package platform.entities.bosses.quash;

import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class SquashRandomStompFSM extends FSMModule 
{
	var s:Squasher;
	
	var WAIT_STOMP_TIME:Float = 1;
	
	var MIN_STOMP:Int = 3;
	var MAX_STOMP:Int = 7;
	var stompCount:Int;
	
	var MIN_X:Float = 32;
	var MAX_X:Float = 400;
	var MOVE_TIME:Float = .8;
	
	var stomping:Bool = false;
	var moving:Bool = false;
	var timer:FlxTimer;
	var tween:FlxTween;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		s = cast parent;
		timer = new FlxTimer();
	}
	
	
	override public function changeFrom() 
	{
		timer.cancel();
		if (tween != null)
			tween.destroy();
	}
	override public function changeTo() 
	{
		s.leftArm.signal('up');
		s.rightArm.signal('up');
		stompCount = FlxG.random.int(MIN_STOMP, MAX_STOMP);
		stomping = false;
		moving = false;
	}
	
	override public function update(dt:Float) 
	{
		if (stompCount == 0)
			parent.changeFSM('wait');
		
		if (!stomping) {
			move();
		}
		
	}
	
	
	private function stomp() {
		var sa:SquashArm;
		if (FlxG.random.bool())
			sa = s.leftArm;
		else
			sa = s.rightArm;
		
		sa.signal('crush');
		stomping = true;
		timer.start(WAIT_STOMP_TIME, function(_) {stomping = false; moving = false; });
		stompCount--;
	}
	
	private function move() {
		stomping = true;
		tween = FlxTween.tween(s.pos, {x:FlxG.random.float(MIN_X, MAX_X)}, MOVE_TIME, {onComplete:function(_) {stomp(); }});
	}
}