package platform.entities.enemies.mushboom;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;
import platform.entities.Attack.AttackTypes;

/**
 * ...
 * @author Dave
 */
class MushboomSmallSpores extends FSMModule 
{
	var e:MushboomSmall;
	var timer:FlxTimer;
	
	var SPORE_COUNT:Int = 6;
	var SPORE_VEL_X:Float = 300;
	var SPORE_VEL_Y:Float = 300;
	
	var SPORE_DELAY:Float = 1;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		e = cast parent;
		timer = new FlxTimer();
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
		e.animation.play('idle');
	}
	
	override public function changeTo() 
	{
		e.velocity.x = 0;
		e.animation.play('explode');
		timer.start(SPORE_DELAY, function (_) {
			spores(); 
			timer.start(SPORE_DELAY, function(_) {parent.changeFSM('wait'); });
			
		});
		super.changeTo();
	}
	
	private function spores() {
		for (i in 0...SPORE_COUNT) {
			var s = H.ps.getEnemyAttack();
			AttackFactory.configAttack(s, AttackTypes.SPORE);
			var t = FlxPoint.get(FlxG.random.float(-SPORE_VEL_X, SPORE_VEL_X), -SPORE_VEL_Y);
			s.newInitAttack(e.getMidpoint() , t, 10, AttackTypes.SPORE);
			t.put();		
		}
	}
	
}