package platform.entities.enemies.mushboom;

import flixel.FlxG;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class MushboomSpawnFSM extends FSMModule 
{

	var c:Mushboom;
	var timer:FlxTimer;
	
	var SLAM_TIME:Float = .3;
	var AFTER_TIME:Float = 2;

	
	var SPAWN_COUNT = 2;
	
	var THROW_X_MIN:Float = 50;
	var THROW_Y:Float = 200;
	var THROW_X_MAX:Float = 200;

	public function new(parent:IFSM) 
	{
		super(parent);
		c = cast parent;
		timer = new FlxTimer();
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
		c.animation.play('idle');
	}
	
	override public function changeTo() 
	{
		c.facePlayer();
		throwSpawn();
	}
	
	private function throwSpawn() {
		c.animation.play('slam', true);
		timer.start(SLAM_TIME, function(_) {
			for (i in 0...SPAWN_COUNT) {
				var e = new MushboomSmall(H.ps.collision);
				e.reset(c.x, c.y);
				var throwX = FlxG.random.float(THROW_X_MIN, THROW_X_MAX);
				if (!c.flipX)
					throwX *= -1;
				e.velocity.set(throwX, -THROW_Y);
				H.ps.addEnemy(e);
			}
			
			timer.cancel();
			timer.start(AFTER_TIME, function(_) {
				parent.changeFSM('wait');
				c.animation.play('idle');
					
			});
		});
	}
	
	
}