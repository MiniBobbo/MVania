package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.ds.StringMap;
import inputhelper.InputHelper;
import platform.H;
import platform.PlatformState;
import tmxtools.TmxTools;

typedef MapArea = 
{
	var x:Int;
	var y:Int;
	var w:Int;
	var h:Int;
}

/**
 * ...
 * @author Dave
 */
class MinimapSubState extends FlxSubState 
{

	var overlay:FlxSprite;
	var map:FlxSprite;
	var areas:StringMap<MapArea>;
	var rooms:StringMap<FlxSprite>;
	
	var X_OFFSET:Float;
	var Y_OFFSET:Float;
	var X_SIZE:Int = 16;
	var Y_SIZE:Int = 16;
	
	public function new(BGColor:FlxColor=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
	}
	
	override public function create():Void 
	{
		super.create();
		areas = createAreas();
		rooms = new StringMap<FlxSprite>();
		overlay = new FlxSprite(0,0,'assets/images/mapAreas.png');
		map = new FlxSprite(0,0,'assets/images/mapRooms.png');
		var t = new FlxText(0, 20, FlxG.width, H.currentLevel, 20);
		t.scrollFactor.set();
		t.setFormat(null, 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
		add(t);
		map.scrollFactor.set();
		overlay.scrollFactor.set();
		//overlay.scale.set(2, 2);
		overlay.screenCenter();
		overlay.alpha = .5;
		//map.scale.set(2, 2);
		map.screenCenter();
		X_OFFSET = map.x;
		Y_OFFSET = map.y;
		add(map);
		
		//trace(areas.toString());
		
		//Create all the rooms
		for (a in areas.keys()) {
			//trace(createRoom(areas.get(a)));
			var s = createRoom(areas.get(a));
			s.scrollFactor.set();
			rooms.set(a, s);
			add(s);
		}


		for (e in H.playerDef.explored) {
			var er = rooms.get(e);
			if (er == null)
				trace('Error finding ' + e);
			else
				er.alpha = 0;
		}
		
		try {
		//Highlight the current room in blue if we are there.
				var r = rooms.get(H.currentLevel);
				if (r != null) {
					r.color = FlxColor.BLUE;
					r.alpha = 1;
					FlxTween.tween(r, {alpha:0}, 1,{type:FlxTween.PINGPONG});
				} else {
					trace('Error highlighting ' + H.currentLevel);
				}
		} catch (err:Dynamic)
		{
			trace(err);
		}
		
		add(overlay);

	}

	public static function getMapAreaNames():Array<String> {
		var a = createAreas();
		var allAreas:Array<String> = [];
		for (k in a.keys())
			allAreas.push(k);
		//trace(allAreas);
		return allAreas;
	}
	
	public static function createAreas():StringMap<MapArea> {
		var a = new StringMap<MapArea>();
		a.set('Pod Bay', {
			x:12,
			y:8,
			w:4,
			h:2
		});
		a.set('Life Support Computer Room', {
			x:11,
			y:9,
			w:1,
			h:1
		});
		a.set('Life Support - Boost Room', {
			x:14,
			y:6,
			w:1,
			h:1
		});
		a.set('T Junction', {
			x:15,
			y:6,
			w:1,
			h:1
		});
		a.set('Life Support Column', {
			x:16,
			y:5,
			w:1,
			h:5
		});
		a.set('Life Support - Maintenance', {
			x:14,
			y:7,
			w:2,
			h:1
		});
		a.set('Life Support - Maintenance Access', {
			x:11,
			y:6,
			w:3,
			h:2
		});
		a.set('Life Support - Maintenance Tunnel', {
			x:11,
			y:5,
			w:5,
			h:1
		});
		a.set('Life Support - Storage', {
			x:17,
			y:8,
			w:3,
			h:2
		});
		a.set('Life Support - Airlock', {
			x:20,
			y:9,
			w:1,
			h:1
		});
		a.set('Life Support - Space Dock', {
			x:21,
			y:9,
			w:1,
			h:1
		});
		a.set('Life Support - Aft', {
			x:17,
			y:5,
			w:3,
			h:3
		});
		a.set('Life Support - The Grid', {
			x:20,
			y:5,
			w:2,
			h:2
		});
		a.set('Life Support - Generator', {
			x:20,
			y:7,
			w:2,
			h:2
		});
		a.set('Engineering - Column', {
			x:22,
			y:5,
			w:1,
			h:3
		});
		a.set('Engineering - Machine Shop', {
			x:23,
			y:5,
			w:4,
			h:2
		});
		a.set('Engineering - Long Term Storage', {
			x:23,
			y:7,
			w:4,
			h:1
		});
		a.set('Engineering - Short Term Storage', {
			x:26,
			y:2,
			w:1,
			h:3
		});
		a.set('Engineering - Freight Elevator', {
			x:25,
			y:2,
			w:1,
			h:3
		});
		a.set('Engineering - Engine Room', {
			x:21,
			y:1,
			w:4,
			h:2
		});
		a.set('Engineering - Junction', {
			x:21,
			y:3,
			w:2,
			h:2
		});
		a.set('Engineering - Compactor', {
			x:23,
			y:3,
			w:2,
			h:2
		});
		a.set('Engineering - Crew Quarters', {
			x:19,
			y:2,
			w:2,
			h:3
		});
		a.set('Engineering - Officer Quarters', {
			x:18,
			y:2,
			w:1,
			h:3
		});
		a.set('Engineering - Hallway', {
			x:18,
			y:1,
			w:3,
			h:1
		});
		a.set('Engineering - Save Room', {
			x:20,
			y:0,
			w:1,
			h:1
		});
		a.set('Engineering - Systems Access', {
			x:21,
			y:0,
			w:4,
			h:1
		});
		a.set('Engineering - Thruster Control', {
			x:25,
			y:0,
			w:2,
			h:2
		});
		a.set('Engineering - Terraforming Access', {
			x:18,
			y:0,
			w:2,
			h:1
		});
		a.set('Terraforming - Shadowed Glade', {
			x:14,
			y:0,
			w:4,
			h:3
		});
		a.set('Terraforming - Great Tree', {
			x:13,
			y:0,
			w:1,
			h:5
		});
		a.set('Terraforming - Outdoors', {
			x:14,
			y:3,
			w:4,
			h:2
		});
		a.set('Terraforming - High Falls', {
			x:10,
			y:0,
			w:3,
			h:4
		});
		a.set('Terraforming - Caverns', {
			x:10,
			y:4,
			w:3,
			h:1
		});
		a.set('Terraforming - The Maw Entrance', {
			x:8,
			y:0,
			w:2,
			h:2
		});
		a.set('Terraforming - The Maw', {
			x:8,
			y:2,
			w:2,
			h:3
		});
		a.set('Terraforming - Deepmaw', {
			x:8,
			y:5,
			w:3,
			h:2
		});
		a.set('Terraforming - Depths', {
			x:8,
			y:7,
			w:3,
			h:1
		});
		a.set('Command - Computer Room', {
			x:6,
			y:2,
			w:2,
			h:2
		});
		a.set('Command - Network Access', {
			x:2,
			y:1,
			w:5,
			h:1
		});
		a.set('Command - Sub Command', {
			x:2,
			y:2,
			w:2,
			h:2
		});
		a.set('Command - Bridge', {
			x:1,
			y:2,
			w:1,
			h:2
		});
		a.set('Command - Central Computer', {
			x:4,
			y:2,
			w:2,
			h:2
		});
		a.set('Life Support - Command Access', {
			x:11,
			y:8,
			w:1,
			h:1
		});
		a.set('Command - Space Bridge', {
			x:7,
			y:8,
			w:4,
			h:1
		});
		a.set('Command - Backup', {
			x:7,
			y:7,
			w:1,
			h:1
		});
		a.set('Command - Junction', {
			x:7,
			y:6,
			w:1,
			h:1
		});
		a.set('Command - Lower Deck', {
			x:4,
			y:6,
			w:3,
			h:1
		});
		a.set('Command - Destroyed Area', {
			x:1,
			y:5,
			w:3,
			h:2
		});
		a.set('Command - Corridor', {
			x:1,
			y:4,
			w:3,
			h:1
		});
		a.set('Command - Trash Compactor', {
			x:4,
			y:4,
			w:1,
			h:2
		});
		a.set('Command - Equipment Storage', {
			x:5,
			y:4,
			w:2,
			h:2
		});
		a.set('Command - Backup Equipment', {
			x:7,
			y:4,
			w:1,
			h:2
		});
		
		
		
		
		return a;
	}
	
	override public function update(elapsed:Float):Void 
	{
		var i = InputHelper;
		i.updateKeys(elapsed);
		super.update(elapsed);
		
		if (i.isButtonJustPressed('map')) {
			_parentState.closeSubState();
		}
		
		#if debug
		if (FlxG.mouse.justPressed) {
			var p = FlxG.mouse.getScreenPosition();
			for (r in rooms.keys()) {
				if (rooms.get(r).overlapsPoint(p)) {
					trace('Switching to ' + r);
					H.currentLevel = r;
					H.previousLevel = 'teleport';
					FlxG.switchState(new PlatformState());
				}
			}
			p.put();
		}
		#end
	}
	
	function createRoom(m:MapArea):FlxSprite {
		var s = new FlxSprite(X_OFFSET + m.x * X_SIZE, Y_OFFSET + m.y * Y_SIZE);
		s.makeGraphic(m.w * X_SIZE, m.h * Y_SIZE);
		s.color = FlxColor.BLACK;
		return s;
	}
	
}