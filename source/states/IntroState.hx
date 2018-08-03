package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import inputhelper.InputHelper;
import platform.H;
import platform.PlatformState;

/**
 * ...
 * @author Dave
 */
class IntroState extends FlxState 
{
	
	var LIGHT_X:Float = 350;
	var LIGHT_Y:Float = 25;
	var LIGHT_SPACE:Float = 38;
	var LABEL_X:Float = 378;
	var LABEL_Y:Float = 37;
	var LABEL_SPACE:Float = 38;
	
	
	var console:FlxTypeText;
	var i:InputHelper;
	var typing:Bool = true;

	var hud:FlxSpriteGroup;
	var controlLight:FlxSprite;
	var terraformingLight:FlxSprite;
	var engineeringLight:FlxSprite;
	var lifeSupportLight:FlxSprite;
	
	var bg:FlxSprite;
	
	var lines:Array<String> = [
	'External entity detected. \n\nStarting intrusion countermeasures.',
	'Bio-digital virus detected.  \n\nControl firewall breached.  \n\nLaunching antivirus.',
	"Control systems compromised. \n\nAttempting repair.",
	"Control Repair failed.\n\nVirus propagating. \n\nTerraforming systems compromised.  \n\nAntivirus ineffective.  \n\nAttempting restore of infected systems.",
	"Restore attempt blocked by unknown intruder.  \n\nPrepping network segmentation to preserve intact systems.",
	"Launching network segmentation."
	];

	var currentLine:Int = 0;
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		hud = new FlxSpriteGroup();
		hud.centerOrigin();
		
		bg = new FlxSprite(0, 0, 'assets/images/console.png');
		hud.add(bg);
		
		console = new FlxTypeText(20, 20, 270, '');
		console.setFormat('assets/data/font/TektrReg.ttf', 16, FlxColor.WHITE);
		console.start(.015, true, false, [FlxKey.SPACE], finishTyping);
		console.skipKeys = [FlxKey.SPACE];
		hud.add(console);
		
		var info = new FlxText(0, 250, FlxG.width, 'Press Space to continue.  Escape to Skip.', 8);
		info.setFormat('assets/data/font/TektrReg.ttf', 8, FlxColor.WHITE, FlxTextAlign.CENTER);
		
		hud.add(info);
		controlLight = makeLight(LIGHT_X, LIGHT_Y);
		hud.add(controlLight);
		hud.add(makeText(LABEL_X, LABEL_Y, 'CONTROL'));
		
		terraformingLight = makeLight(LIGHT_X, LIGHT_Y + LIGHT_SPACE);
		hud.add(terraformingLight);
		hud.add(makeText(LABEL_X, LABEL_Y + LABEL_SPACE-10, 'TERRA\nFORMING'));

		engineeringLight= makeLight(LIGHT_X, LIGHT_Y + LIGHT_SPACE*2);
		hud.add(engineeringLight);
		hud.add(makeText(LABEL_X, LABEL_Y + LABEL_SPACE*2, 'ENGINEERING'));

		lifeSupportLight = makeLight(LIGHT_X, LIGHT_Y + LIGHT_SPACE*3);
		hud.add(lifeSupportLight);
		hud.add(makeText(LABEL_X, LABEL_Y + LABEL_SPACE*3-10, 'LIFE\nSUPPORT'));

		
		
		add(hud);
		nextLine();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.SPACE) {
			if (!typing)
				nextLine();
		}
	}
	
	private function finishTyping() {
		typing = false;
	}
	
	function makeLight(x:Float, y:Float):FlxSprite {
		var s = new FlxSprite(x,y);
		s.frames = platform.H.getFrames();
		s.animation.addByPrefix('red', 'icons_redlight_');
		s.animation.addByPrefix('yellow', 'icons_yellowlight_', 15);
		s.animation.addByPrefix('green', 'icons_greenlight_'); 
		s.animation.play('green');
		return s;
	}
	
	function makeText(x:Float, y:Float, text:String):FlxText {
		var t = new FlxText(x,y);
		t.setFormat('assets/data/font/TektrReg.ttf', 10, FlxColor.WHITE);
		t.text = text;
		return t;
	}
	
	function nextLine() {
		switch (currentLine) 
		{
			case 1:
				controlLight.animation.play('yellow');
			case 2:
				controlLight.animation.play('red');
			case 3:
				terraformingLight.animation.play('yellow');
			case 4:
				engineeringLight.animation.play('yellow');
			case 5:
				terraformingLight.animation.play('red');
			case 6:
				shutdown();
				return;
			default:
				
		}
		typing = true;
		console.resetText(lines[currentLine]);
		console.start(.015, true, false, [FlxKey.SPACE], finishTyping);
		currentLine++;
	}
	
	function shutdown() {
		typing = true;
		console.visible = false;
		FlxTween.tween(hud.scale, {y:.01}, .3, {ease:FlxEase.quadIn, onComplete:finish});
	}
	
	function finish(_) {
		//FlxG.camera.fade(FlxColor.BLACK, 2);
		FlxG.camera.fade(FlxColor.BLACK, .5, false, function() {FlxG.switchState(new PlatformState()); });
	}
}