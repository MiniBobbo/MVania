package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxSpriteUtil;
import platform.H;
import platform.entities.Player.PlayerForm;

/**
 * ...
 * @author Dave
 */
class ReplicatedObject extends FlxSprite 
{

	public var form:String;
	
	public function new(x:Float, y:Float, form:String) 
	{
		super(x, y);
		frames = H.getFrames();
		animation.addByPrefix('robot', 'robot_offline_');
		switchForm(form);
		this.form = form;
		
	}
	
	private function switchForm(form:String) {
		switch (form) 
		{
			case 'ROBOT':
				trace('Made Robot.');
				animation.play('robot');
				setSize(32, 32);
				offset.set(16,32);
				acceleration.y = H.GRAVITY;
			default:
				
		}
	}
	
	public function disentigrate(clearPlayState:Bool = true) {
		acceleration.set();
		velocity.set();
		if(clearPlayState)
			H.ps.replicatedObject = null;
		FlxSpriteUtil.fadeOut(this, 1, function(_) {alive = false; exists = false; });
	}
	
}