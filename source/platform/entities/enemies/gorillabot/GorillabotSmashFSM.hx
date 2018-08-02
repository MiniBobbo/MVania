package platform.entities.enemies.gorillabot;

import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;
import platform.entities.Attack.AttackTypes;

/**
 * ...
 * @author Dave
 */
class GorillabotSmashFSM extends FSMModule 
{
	var g:Gorillabot;
	var timer:FlxTimer;
	
	var DELAY_TIME:Float = .5;
	var ATTACK_FINISH_TIME:Float = 1;
	var ATTACK_SPEED:Float = 300;
	public function new(parent:IFSM) 
	{
		super(parent);
		g = cast parent;
		timer = new FlxTimer();
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
	}
	
	override public function changeTo() 
	{
		g.animation.play('smash');
		g.facePlayer();
		timer.start(DELAY_TIME, function(_) {
			var a = H.ps.getEnemyAttack();
			AttackFactory.configAttack(a, AttackTypes.SHOCKWAVE);
			var v = FlxPoint.get(ATTACK_SPEED, 0);
			if (!g.flipX) {
				a.flipX = true;
				v.x *= -1;
			}
			var p = g.getMidpoint();
			p.y += 6;
			
			a.newInitAttack(p, v, 4, AttackTypes.SHOCKWAVE);
			timer.cancel();
			timer.start(ATTACK_FINISH_TIME, function(_) {
				g.animation.play('idle');
				parent.changeFSM('attack');
			});
		});
	}
}