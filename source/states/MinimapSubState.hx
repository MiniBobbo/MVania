package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import inputhelper.InputHelper;
import platform.H;
import tmxtools.TmxTools;

/**
 * ...
 * @author Dave
 */
class MinimapSubState extends FlxSubState 
{

	var overlay:FlxTilemap;
	var map:FlxTilemap;
	public function new(BGColor:FlxColor=FlxColor.TRANSPARENT) 
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
		var t = new FlxText(0, 20, FlxG.width, H.currentLevel, 20);
		t.scrollFactor.set();
		t.setFormat(null, 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
		add(t);
		map.scrollFactor.set();
		overlay.scrollFactor.set();
		overlay.scale.set(2, 2);
		overlay.screenCenter();
		overlay.alpha = .5;
		map.scale.set(2, 2);
		map.screenCenter();
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