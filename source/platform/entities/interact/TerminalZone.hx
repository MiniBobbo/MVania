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
	
	var flag:String = '';
	
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
	
	public function setFlag(flag:String) {
		this.flag = flag;
	}
	
	override public function interact() 
	{
		//H.ps.spawnPlayerForm(PlayerForm.ROBOT, 1);
		H.signalAll(signal, code);
		trace('Flag value is ' + flag);
		if (flag != '') {
			trace('trying to set flag' + flag);
			H.setFlag(Std.parseInt(flag));
		}
	}
}