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
				return ['Incoming message from Central Life Support Computer:', 'How in the world did those mushrooms get there?'];
			case '23': 
				return ['WARNING!!!  WARNING!!!\nLARGE MACHINE DETECTED AHEAD!!!', 'PROCEED WITH CAUTION!!!'];
			case '24': 
				return ['Incoming message from Central Life Support Computer:', 'The virus has affected the holographic projectors and is recreating a scene from some planet.', 'The specific planet is unknown.  Perhaps it is the source planet of this virus?'];
			case '25': 
				return ['Incoming message from Central Life Support Computer:', 'The Sub Command area was designed for the junior officers and support crew', 'Using holographic technology, all the space around the ship is broadcast onto all the walls and floors.', 'The intent was to offer 360 degree views to help with decision making, but in reality most humans find it extremely distracting.'];
			case '26': 
				return ['Incoming message from Central Life Support Computer:', 'The source of the virus is detected through this door. \n\nProceed with caution.'];
			case '27':
				return ['Incoming message from Central Life Support Computer:', 'An unknown entity (DESIGNATION : OPHIOCOR) has infected the HCS Phoenix.  OPHIOCOR shares characteristics with both a computer virus and a fungus and spreads through computer systems and through contact.', 
				'The HCS Phoenix network has been segmented to slow the spread of the virus.  The extent of the infection is currently unknown.',
				'You have been created to find the source of the virus and eliminate it.'];
			case '28':
				return ['Incoming message from Central Life Support Computer:', 'These are the cryo pods for the 1946 humans currently aboard the HCS Phoenix.', 
				'OPHICOR has yet to infect this area.  Please proceed to the rest of the ship.'];
			case '29':
				return ['Incoming message from Central Life Support Computer:', 'OPHICOR infection detected in these replicated robots.  Likely the engineering module has been infected by OPHICOR.'];
			case '30':
				return ['Incoming message from Central Life Support Computer:', 'Backup Station detected.  This station is likely infected by OPHIOCOR, but can be restored to its default state.', 'Please proceed to the save station and upload the restoration program.', 'In unlikely event that your body is destroyed it can be recreated at this station in the future.', 'Unfortunately, all the information gathered since your last backup will be lost.'];
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