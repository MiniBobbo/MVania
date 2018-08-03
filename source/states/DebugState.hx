package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import platform.H;

/**
 * ...
 * @author Dave
 */
class DebugState extends FlxSubState 
{

	var debugText:FlxText;
	
	public function new(BGColor:FlxColor=FlxColor.WHITE) 
	{
		super(BGColor);
		
	}

	override public function create():Void 
	{
		super.create();
		debugText = new FlxText(0, 0, FlxG.width, 'Player Def:\n' + platform.H.playerDef);
		debugText.scrollFactor.set();
		add(debugText);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.SPACE)
			_parentState.closeSubState();
	}
}