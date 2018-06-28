package platform.entities.interact;

import platform.entities.InteractZone;
import platform.entities.Player.PlayerForm;

/**
 * ...
 * @author Dave
 */
class ReplicatorZone extends InteractZone 
{
	

	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float) 
	{
		super(X, Y, WIDTH, HEIGHT);
		
	}
	
	override public function interact() 
	{
		//H.ps.spawnPlayerForm(PlayerForm.ROBOT, 1);
		H.ps.spawnPlayerForm('ROBOT', ID);
	}
	
}