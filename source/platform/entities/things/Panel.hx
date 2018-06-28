package platform.entities.things;

import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Panel extends Enemy 
{
	var code:Int = 0;
	var off:Bool = true;
	public function new(collisionMap:FlxTilemap, code:Int = 0 ) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('off', 'icons_paneloff_',6);
		animation.addByPrefix('on', 'icons_panelon_',6);
		animation.play('off');
		setCode(0);
	}
	
	public function setCode(code:Int) {
		this.code = code;
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		switch (signal) 
		{
			case 'hit':
				if (off) {
					var a:Attack = cast data;
					if (a.animation.name == 'elecshotend') {
						H.signalAll('activate', code);
						off = false;
						animation.play('on');
					}
				}
					
					
			default:
				
		}
	}
	
}