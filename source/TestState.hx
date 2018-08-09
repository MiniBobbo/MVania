package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import inputhelper.InputHelper;
import shaders.Invert;
import shaders.PixelShader;
import states.PowerupSubstate;

/**
 * ...
 * @author Dave
 */
class TestState extends FlxState 
{

	var bg:FlxSprite;
	var s:PixelShader;
	var pixelValue:Float;
	
	override public function create():Void 
	{
		
		super.create();
		FlxG.camera.bgColor = FlxColor.BLUE;
		//bg = new FlxSprite(0, 0, 'assets/images/pods.png');
		//s = new PixelShader();
		//pixelValue = .000001;
		//s.uPixels.value = [pixelValue];
		//bg.shader = s;
		//add(bg);
		//
		//FlxTween.tween(s.uPixels, {value:[20.0]}, .5, {type:FlxTween.PINGPONG});
		//FlxTween.tween(bg, {alpha:0}, .5, {type:FlxTween.PINGPONG});
	}
	
	override public function update(elapsed:Float):Void 
	{
		//s.uPixels.value = [pixelValue];
		
		if (FlxG.keys.justPressed.SPACE) {
			openSubState(new PowerupSubstate('This is a test message') );
		}
		
	}
	
}