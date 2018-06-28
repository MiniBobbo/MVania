package;

import flixel.FlxSprite;
import flixel.FlxState;
import inputhelper.InputHelper;

class PlayState extends FlxState
{
	var s:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		
		s = new FlxSprite(0, 0);
		
		add(s);
	}

	override public function update(elapsed:Float):Void
	{
		var i = InputHelper;
		i.updateKeys(elapsed);
		super.update(elapsed);
	}
}
