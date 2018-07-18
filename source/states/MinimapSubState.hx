package states;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import inputhelper.InputHelper;
import tmxtools.TmxTools;

/**
 * ...
 * @author Dave
 */
class MinimapSubState extends FlxSubState 
{

	var overlay:FlxTilemap;
	var map:FlxTilemap;
	public function new(BGColor:FlxColor=FlxColor.BLACK) 
	{
		super(BGColor);
	}
	
	override public function create():Void 
	{
		super.create();
		var maps = new TmxTools('assets/data/levels/minimap.tmx',  'assets/data/levels/');
		overlay = maps.getMap('AreaLayer');
		//overlay.scale.set(2, 2);
		map = maps.getMap('MapLayer');
		overlay.screenCenter();
		overlay.alpha = .5;
		map.screenCenter();
		//map.scale.set(2, 2);
		add(map);
		add(overlay);
		
	}

	override public function update(elapsed:Float):Void 
	{
		var i = InputHelper;
		i.updateKeys(elapsed);
		super.update(elapsed);
		
		if (i.isButtonJustPressed('map')) {
			_parentState.closeSubState();
		}
	}
	
}