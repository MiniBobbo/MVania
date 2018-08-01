package platform.entities.enemies.mushboom;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class MushboomJumpFSM extends FSMModule
{
	var c:Mushboom;
	var timer:FlxTimer;
	var JUMP_STR_X:Float = 200;
	var JUMP_STR_Y:Float = 500;

	var jumpLeft:Bool = true;
	
	var JUMP_PREP:Float = .5;
	public function new(parent:IFSM) 
	{
		super(parent);
		c = cast parent;
		timer = new FlxTimer();
	}
	
	override public function changeFrom() 
	{
		timer.cancel();
	}
	
	override public function changeTo() 
	{
		c.acceleration.y = H.GRAVITY / 3;
			if (H.ps.player.x < c.x) {
				c.flipX = false;
				jumpLeft = true;
			} else {
				c.flipX = true;
				jumpLeft = false;
			}
		c.animation.play('prepjump');
		timer.start(JUMP_PREP, function(_) {
			c.velocity.y = -JUMP_STR_Y;
			c.velocity.x = JUMP_STR_X;
			if (jumpLeft)
				c.velocity.x *= -1;
			c.y -= 1;	
			c.touching = 0;
			parent.changeFSM('jumping');
		});
	}
	
	
}