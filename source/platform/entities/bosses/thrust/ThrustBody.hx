package platform.entities.bosses.thrust;

import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;
import platform.entities.Entity;
import platform.entities.bosses.Piece;

/**
 * ...
 * @author Dave
 */
class ThrustBody extends Piece 
{

	var antigravSignal:FlxTimer;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('idle','ThrustBoss_Idle_', 1,false);
		animation.addByPrefix('flash', 'ThrustBoss_flash_', 12, true);
		animation.play('idle');
		setSize(160, 160);
		antigravSignal = new FlxTimer();
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		entity.takeDamage();
		entity.signal('stun', new FlxPoint(-100,0));
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		if (signal == 'on') {
			antigravSignal.cancel();
			antigravSignal.start(12, function(_) {H.signalAll('off'); });
			
		}
	}
}