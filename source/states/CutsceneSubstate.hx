package states;

import dialogwindow.DialogWindow;
import dialogwindow.DialogWindowManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.plugin.FlxScrollingText;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author Dave
 */
class CutsceneSubstate extends FlxSubState 
{
	
	var messages:Array<String>;
	
	var text:FlxTypeText;
	var X_OFFSET:Float = 40;
	var Y_OFFSET:Float = 10;
	var TEXT_BORDER:Float = 10;
	var TEXT_WIDTH:Float = 380;
	var SIZE:Float = 12;
	
	var TYPE_TIME:Float = .015;
	
	var everything:FlxSpriteGroup;
	var closing:Bool = false;
	
	public function new(code:String) 
	{
		super(BGColor);
		messages = getMessages(code);
		everything = new FlxSpriteGroup();
		everything.scrollFactor.set();
		everything.setPosition(X_OFFSET, Y_OFFSET);
		text = new FlxTypeText(X_OFFSET + TEXT_BORDER, Y_OFFSET + TEXT_BORDER, TEXT_WIDTH, '');
		text.setFormat('assets/data/font/TektrReg.ttf', SIZE, FlxColor.WHITE, null, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
		
		var c = new FlxSprite(0, 0, 'assets/images/consolesmall.png');
		everything.add(c);
		everything.add(text);
		
		FlxTween.tween(everything, {y:0}, .5, {ease:FlxEase.quadIn, onComplete:next});
	}
	
	private function getMessages(code:String):Array<String> {
		return ['This is a test', 'There is another string after this', 'This is the last one'];
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.SPACE && !closing) {
			next();
		}
	}
	
	private function next() {
		if (messages.length == 0)
			closeMe();
		var m = messages.shift();
		text.resetText(m);
		text.start(TYPE_TIME, true, false);
	}
	
	private function closeMe() {
		closing = true;
		FlxTween.tween(everything, {y: -400}, .5, {ease:FlxEase.quadOut, onComplete: function(_) {_parentState.closeSubState(); }});
	}
	
}