package platform;
import defs.PlayerDef;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.util.FlxSave;
import haxe.Json;
import platform.entities.EffectSprite.EffectTypes;
import platform.entities.Entity;
import platform.entities.Player.PlayerForm;
import tmxtools.TmxRect;

/**
 * ...
 * @author Dave
 */
class H
{

	//Holds a copy of the game data.  This is the one that should be updated.
	public static var gd:GameData;
	
	public static var defaultPlayerDef:PlayerDef;
	public static var playerDef:PlayerDef;
	//public static var savedPlayerDef:PlayerDef;
	
	public static var currentLevel:String;
	public static var previousLevel:String;
	
	
	public static var paused:Bool = false;
	public static var allowInput:Bool = true;
	public static var health:Int = 0;
	public static var textureAtlas:FlxAtlasFrames;
	public static var attacks:FlxTypedGroup<FlxSprite>;
	
	public static var ENEMY_FLICKER_TIME:Float = .2;
	
	public static var GRAVITY:Float = 2400;
	
	public static var bgScrollValue:FlxPoint;
	
	public static var ps:PlatformState;

	public static var helpText:FlxText;
	
	public static var r:FlxRandom;
	
	public static function getScrollValue():FlxPoint {
		if (bgScrollValue == null)
		bgScrollValue = new FlxPoint(.8, .8);
		return bgScrollValue;
	}
	
	public static function distanceBetween(e1:Entity, e2:Entity):Float {
		return e1.getPosition().distanceTo(e2.getPosition());
	}
	


	public static function worldToTileLocation(p:FlxPoint):FlxPoint {
		//TODO: Change this to be user defined in the H file or something.
		p.x = Math.floor(p.x / 32) * 32;
		p.y = Math.floor(p.y / 32) * 32;
		
		return p;
	}

	/**
	 * Changes a TmxRect object to fill the tile that it is in.  
	 * So a rect drawn in the center of a tile will expand to fill the entire tile.
	 * Measured from the upper left point
	 * @param	rect	The rect to change.
	 */
	public static function rectToTile(rect:TmxRect) {
		var startPoint = worldToTileLocation(FlxPoint.weak(rect.r.x, rect.r.y));
		rect.r.x = startPoint.x;
		rect.r.y = startPoint.y;
		rect.r.width = 32;
		rect.r.height = 32;
	}
	
	public static function rectToRects(rect:TmxRect):Array<TmxRect> {
		var startPoint = worldToTileLocation(FlxPoint.weak(rect.r.x, rect.r.y));
		var width:Int = Std.int((rect.r.width / 32) + 1);
		var height:Int = Std.int((rect.r.height / 32) + 1);
		
		var newrects:Array<TmxRect> = [];
		
		for (w in 0...width) {
			for (h in 0...height) {
				var newr:TmxRect = {
				name:rect.name,
				properties:rect.properties,
				r: new FlxRect(startPoint.x + (w * 32), startPoint.y + (h * 32), 32, 32)};
				newrects.push(newr);
			}
		}
		
		return newrects;
	}
	
	public static function setPlaystate(playState:PlatformState) {
		ps = playState;
	}
	
	public static function signalAll(signal:String, ?data:Dynamic) {
		H.ps.entities.forEachAlive(function(e:Entity) { e.signal(signal, data); } );
	}
	
	public static function getFrames():FlxFramesCollection {
		return FlxAtlasFrames.fromTexturePackerJson('assets/images/main.png', 'assets/images/main.json');
	}
	
	public static function saveGame() {
		var save = initSave();	
		playerDef.playerHealth = playerDef.playerMaxHealth;
		playerDef.playerEnergy = playerDef.playerMaxEnergy;
		playerDef.attackSelected = 0;
		
		
		save.data.d = Json.stringify(H.playerDef);
		save.close();
	}
	
	public static function loadGame():Bool {
		var save = initSave();	
		//trace('Saved data: ' + save.data.d);
		H.playerDef = Json.parse(save.data.d);
		H.playerDef.playerHealth = H.playerDef.playerMaxHealth;
		H.currentLevel = playerDef.checkpoint;
		H.previousLevel = 'save';
		
		save.close();
		
		if (playerDef == null)
		return false;
		return true;
	}
	
	public static function clearSave() {
		var save = initSave();
		try{
		save.data.d = Json.stringify(H.defaultPlayerDef);
		save.close();
		loadGame();
		} catch (err:Dynamic)
		{
			trace(err);
		}
	}
	
	static private function initSave():FlxSave 
	{
		var save = new FlxSave();
		save.bind('mvania');
		return save;
	}
	
	public static function checkFlag(flag:String):Bool {
		try{
			var num = Std.parseInt(flag);
			return H.playerDef.flags[num];
		} catch (err:Dynamic)
		{
			trace('Error checking flag: ' + err);
			return false;
		}
		
	}
	
	public static function setFlag(flagNum:Int, value:Bool = true) {
		trace('Setting flag ' + flagNum + ' to ' + value);
		H.playerDef.flags[flagNum] = value;
	}
	
	public static function playEffect(effect:EffectTypes, loc:FlxPoint) {
		if (ps == null)
			return;
		var s = ps.getEffectsprite();
		s.init(loc, effect);
		
	}
	
	/**
	 * Marks this room as explored so it shows on the minimap
	 * @param	room
	 */
	public static function exploreRoom(room:String) {
		if (playerDef.explored.indexOf(room) == -1)
			playerDef.explored.push(room);
	}
}