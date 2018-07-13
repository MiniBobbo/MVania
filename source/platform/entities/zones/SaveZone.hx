package platform.entities.zones;

import flixel.util.FlxTimer;
import platform.entities.Player;
import platform.entities.Zone;
import platform.entities.things.SavePoint;
import shaders.PixelShader;

/**
 * ...
 * @author Dave
 */
class SaveZone extends InteractZone  
{
	
	var savePoint:SavePoint;
	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float) 
	{
		super(X, Y, WIDTH, HEIGHT);
	}
	
	/**
	 * Sets the save point for this interactive zone.
	 * @param	sp		The savepoint to use
	 */
	public function setSavePoint(sp:SavePoint) {
		savePoint = sp;
	}
	
	override public function interact() 
	{
		var p:Player = H.ps.player;
		//Do all the animations and stuff here I guess.  Not sure where else to do it.
		//Set the player position to the middle of the zone.
		H.ps.player.setPosition(x + 32, y + 32);
		H.ps.player.fsm.hold();
		try{
			
			p.shader = new PixelShader();
			p.shader.data.uPixels.value = 1;
			
		} catch (err:Dynamic)
		{
			trace(err);
		}
		savePoint.animation.play('prep');
		
		
		//var t = new FlxTimer().start();
		
	}
	
}