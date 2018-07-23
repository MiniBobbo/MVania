package platform.entities.enemies.porter;

import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;
import platform.entities.Attack.AttackTypes;

/**
 * ...
 * @author Dave
 */
class PorterAttackFSM extends FSMModule 
{
	var p:Porter;
	var timer:FlxTimer;
	var SHOT_SPEED:Float = -250;
	public function new(parent:IFSM) 
	{
		super(parent);
		p = cast parent;
		timer = new FlxTimer();
	}
	
	override public function changeTo() 
	{
		p.animation.play('flash');
		timer.start(.75, function(_) {fire(); });
	}
	
	override public function changeFrom() 
	{
		super.changeFrom();
		timer.cancel();
	}
	
	private function fire() {
		p.animation.play('float');
		
		var a = H.ps.getEnemyAttack();
		AttackFactory.configAttack(a, AttackTypes.LARGESHOT);
		a.strength = 3;
		var v = FlxPoint.get(0, -SHOT_SPEED);
		var loc = FlxPoint.get();
		v.rotate(FlxPoint.weak(), H.ps.player.getMidpoint().angleBetween(p.getMidpoint()));
		//a.velocity.x = -SHOT_SPEED;
		a.newInitAttack(p.getMidpoint() , v, 5,AttackTypes.LARGESHOT);
		v.put();
		parent.changeFSM('wait');
	}
	
}