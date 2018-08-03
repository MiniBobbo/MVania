package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;
import inputhelper.InputHelper;

/**
 * ...
 * @author Dave
 */
class IntroState extends FlxState 
{
	var console:FlxTypeText;
	var i:InputHelper;
	var typing:Bool = true;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		console = new FlxTypeText(0, 0, 300, 'This is a test of the typetext as well as the ttf that I downloaded.');
		console.setFormat('assets/data/font/TektrReg.ttf', 16, FlxColor.WHITE);
		console.start(null, true, false, [FlxKey.SPACE], finishTyping);
		console.skipKeys = [FlxKey.SPACE];
		add(console);
		//FlxG.watch.add(console, 'paused');
	}
	
	override public function update(elapsed:Float):Void 
	{
		
		super.update(elapsed);
		if (FlxG.keys.justPressed.SPACE) {
			console.resetText('This should not play unless the previous text is finished.');
			console.start();
		}
		if (FlxG.keys.justPressed.R) {
			console.resetText('You pressed the reset key and now I have to type a bunch more stuff');
			console.start();
		}
	}
	
	private function finishTyping() {
		typing = false;
	}
}