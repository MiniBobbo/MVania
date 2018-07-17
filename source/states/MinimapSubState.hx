package states;

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
	public function new(BGColor:FlxColor=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		var maps = new TmxTools('assets/data/levels/minimap.tmx',  'assets/data/levels/');
		overlay = maps.getMap('AreaLayer');
		
		
		
	}
	
	override public function create():Void 
	{
		super.create();
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