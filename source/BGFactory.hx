package;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;
import haxe.ds.StringMap;

/**
 * ...
 * @author Dave
 */
class BGFactory 
{

	
	public static function createSpecialBG(bg:String, state:FlxState) {
		var bgMap = new StringMap<String>();
		createMap(bgMap);
		bg = bgMap.get(bg);
		
		
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
			
				
			case 'outdoors':
				var bgs = new FlxBackdrop('assets/images/outsidebg.png', .3, 0);
				bgs.scale.set(.6,.6);
				state.add(bgs);
			case 'caverns':
				var bgs = new FlxBackdrop('assets/images/cavernbg.png', .3, 0);
				bgs.scale.set(.5,.5);
				state.add(bgs);
			case 'guts':
				var bgs = new FlxBackdrop('assets/images/guts.png', .3, .3);
				bgs.scale.set(.3,.3);
				state.add(bgs);
				
			case 'starfield':
				var bgs = new FlxBackdrop('assets/images/starfield_0.png', .3, 0 );
				bgs.velocity.x = 100;
				state.add(bgs);
				var bgs2 = new FlxBackdrop('assets/images/starfield_1.png', .8, 0);
				bgs2.velocity.x = 200;
				state.add(bgs2);
			default:
				
		}
	}
	
	private static function createMap(map:StringMap<String>) {
		map.set('Engineering - Save Room', 'starfield');
		map.set('Engineering - Systems Access', 'starfield');
		map.set('Engineering - Terraforming Access', 'outdoors');
		map.set('Terraforming - Shadowed Glade', 'outdoors');
		map.set('Terraforming - Great Tree', 'outdoors');
		map.set('Terraforming - High Falls', 'outdoors');
		map.set('Terraforming - Outdoors', 'outdoors');
		map.set('Terraforming - Caverns', 'caverns');
		map.set('Terraforming - The Maw Entrance', 'caverns');
		map.set('Terraforming - The Maw', 'guts');
		map.set('Terraforming - Deepmaw', 'guts');
		map.set('Life Support - Space Dock', 'starfield');
		map.set('Life Support - Storage', 'starfield');
	}
}