package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import inputhelper.InputHelper;

/**
 * ...
 * @author Dave
 */
class TestState extends FlxState 
{

	var bar:FlxSprite;
	var frame:FlxSprite;
	
	var value:Float = 200;
	
	override public function create():Void 
	{
		
		super.create();
		
		FlxG.camera.bgColor = FlxColor.GRAY;
		FlxG.camera.scroll.set(-100,-100);
		bar = new FlxSprite(1,1,'assets/images/SanityBar_1.png');
		frame = new FlxSprite(0, 0, 'assets/images/SanityBar_0.png');
		bar.origin.set();
		bar.scale.x = 200;
		add(bar);
		add(frame);
	}
	
	override public function update(elapsed:Float):Void 
	{
		var i = InputHelper;
		i.updateKeys();
		var drop:Float = 100;
		if (i.isButtonPressed('left'))
			value -= drop * elapsed;
		if (i.isButtonPressed('right'))
			value += drop * elapsed;
			
		super.update(elapsed);
		
		if (value < 0)
		 value = 0;
		if (value > 200)
			value = 200;
			
		bar.scale.x = value;
	}
	
}