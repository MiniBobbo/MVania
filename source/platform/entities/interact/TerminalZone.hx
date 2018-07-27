package platform.entities.interact;

import platform.entities.InteractZone;

/**
 * ...
 * @author Dave
 */
class TerminalZone extends InteractZone 
{

	var code:Int = 0;
	var signal:String = 'activate';
	public function new(X:Float, Y:Float, WIDTH:Float, HEIGHT:Float) 
	{
		super(X, Y, WIDTH, HEIGHT);
		
	}
	
	public function setCode(code:Int) {
		this.code = code;
	}
	
	public function setSignal(signal:String) {
		this.signal = signal;
	}
	
	override public function interact() 
	{
		//H.ps.spawnPlayerForm(PlayerForm.ROBOT, 1);
		H.signalAll(signal, code);
	}
}