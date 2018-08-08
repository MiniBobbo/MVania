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
import platform.H;

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
	var TEXT_WIDTH:Int = 360;
	var SIZE:Int = 20;
	
	var TYPE_TIME:Float = .015;
	
	var everything:FlxSpriteGroup;
	var closing:Bool = false;
	
	public function new(code:String, onlyOnce:Bool = true) 
	{
		super();
		if (onlyOnce) {
			H.setFlag(Std.parseInt(code));
		}
		
		messages = getMessages(code);
		everything = new FlxSpriteGroup();
		everything.scrollFactor.set();
		everything.setPosition(X_OFFSET, -500);
		text = new FlxTypeText(TEXT_BORDER, Y_OFFSET + TEXT_BORDER, TEXT_WIDTH, '');
		text.scrollFactor.set();
		text.setFormat('assets/data/font/TektrReg.ttf', SIZE, FlxColor.WHITE, null, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
		
		var c = new FlxSprite(0, 0, 'assets/images/consolesmall.png');
		c.scrollFactor.set();
		everything.add(c);
		everything.add(text);
		add(everything);
		
		FlxTween.tween(everything, {y:Y_OFFSET}, .5, {ease:FlxEase.quadIn, onComplete:function(_) {next(); }});
	}
	
	private function getMessages(code:String):Array<String> {
		switch(code) {
			case '21': 
				return ['This is the first cutscene', 'Isn\t it great?'];
				
			case '22': 
				return ['Incoming message from Central Life Support Computer:', 'How in the world did that mushroom get there?'];
				
			default:
				return ['This isn\'t right.  You shouldn\'t be seeing this.  How did you get here?', 'This is cutscene ' + code];
				
		}
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.SPACE && !closing) {
			next();
		}
	}
	
	private function next() {
		if (messages.length == 0) {
			closeMe();
			return;
		}
		var m = messages.shift();
		text.resetText(m);
		text.start(TYPE_TIME, true, false);
	}
	
	private function closeMe() {
		closing = true;
		FlxTween.tween(everything, {y: -400}, .5, {ease:FlxEase.quadOut, onComplete: function(_) {_parentState.closeSubState(); }});
	}
	
}