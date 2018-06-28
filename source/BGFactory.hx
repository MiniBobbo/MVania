package;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Dave
 */
class BGFactory 
{

	public static function createSpecialBG(bg:String, state:FlxState) {
		switch (bg) 
		{
			case '2':
				var bgs:Array<FlxBackdrop> = [];
				
				for (i in 0...6) {
					var mod:Float = 1- (i / 10);
				var layer:FlxBackdrop = new FlxBackdrop('assets/images/pods.png', mod - .1 , 1, true, false);
				layer.y = 350 - (40 * mod) * i;
				layer.scale.set(mod, mod);
				bgs.unshift(layer);
				}
				
				for (bg in bgs)
				state.add(bg);
			
				
			case '6':
				var bgs = new FlxBackdrop('assets/images/outsidebg.png', .3, 0);
				state.add(bgs);
			case '1':
				var bgs = new FlxBackdrop('assets/images/outsidebg.png', .3, 0);
			default:
				
		}
	}
}