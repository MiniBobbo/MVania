package platform.entities.enemies.porter;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import fsm.FSMModule;
import fsm.IFSM;

/**
 * Teleports near the player, but not too near.
 * @author Dave
 */
class FSMTeleportState extends FSMModule 
{
	var PORT_DISTANCE:Float = 100;
	var PORT_VAR:Float = 100;
	
	
	public function new(parent:IFSM) 
	{
		super(parent);
		
	}
	
	override public function update(dt:Float) 
	{
		var port = FlxPoint.get(0, -PORT_DISTANCE - FlxG.random.float(0, PORT_VAR));
		port.rotate(FlxPoint.weak(), FlxG.random.float( -70, 70));
		
		FlxG.camera.flash(FlxColor.WHITE, .1);
		cast(parent, Entity).setPosition(H.ps.player.x + port.x, H.ps.player.y + port.y);
		parent.changeFSM('wait');
	}
	
}