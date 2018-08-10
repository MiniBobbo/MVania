package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.text.FlxTypeText;
import flixel.addons.ui.FlxButtonPlus;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import platform.H;
import platform.PlatformState;
import sound.AllSounds;
import sound.Sounds;

/**
 * ...
 * @author Dave
 */
class MenuState extends FlxState 
{

	var startGame:FlxButtonPlus;
	var clearData:FlxButtonPlus;
	
	var hud:FlxSpriteGroup;
	var bg1:FlxBackdrop;
	var bg2:FlxBackdrop;
	var ship:FlxSprite;
	var meteor:FlxSprite;
	var logo:FlxSprite;
	
	var text:FlxText;
	
	var currentPlayerDef:FlxText;
	var savedPlayerDef:FlxText;
	
	
	override public function create():Void 
	{
		H.loadGame();
		super.create();
		
		FlxG.sound.playMusic('assets/music/EmptyCity.ogg');
		
		var bg1 = new FlxBackdrop('assets/images/starfield_0.png');
		bg1.scrollFactor.set(.2, .2);
		bg1.velocity.x = 50;
		var bg2 = new FlxBackdrop('assets/images/starfield_1.png');
		bg2.scrollFactor.set(.5, .5);
		bg2.velocity.x = 200;
		
		add(bg1);
		add(bg2);
		
		meteor = new FlxSprite( FlxG.width, 20, 'assets/images/meteor.png');
		//meteor.makeGraphic(300, 300, FlxColor.RED);
		meteor.centerOffsets();
		meteor.centerOrigin();
		
		ship = new FlxSprite(0, -20, 'assets/images/ship.png');
		FlxTween.tween(ship, {y:0}, 2, {ease:FlxEase.quadInOut, type:FlxTween.PINGPONG});
		add(ship);
		
		add(meteor);
		
		text = new FlxText(0, 0, 300, 'HCS Phoenix\n2,000 souls (cryosleep)\n126 years into a 350 year jouney.', 12);
		text.setFormat('assets/data/font/TektrReg.tff', 16);
		text.alpha = 0;
		add(text);
	
		hud = new FlxSpriteGroup();
		
		logo = new FlxSprite(0, 0, 'assets/images/logo.png');
		logo.screenCenter();
		logo.y = 20; 
		
		hud.add(logo);
		startGame = new FlxButtonPlus(0, 0, start, 'Start Game');
		startGame.screenCenter();
		startGame.y += 100;
		hud.add(startGame);
		clearData = new FlxButtonPlus(10, 240, clearSave, 'Clear Saved Data');
		hud.add(clearData);
		
		#if debug
		var debugGame = new FlxButtonPlus(400, 240, debug, 'Debug game');
		hud.add(debugGame);
		#end
		add(hud);
		
		currentPlayerDef = new FlxText(0, 200, 300, H.playerDef + '');
		//add(currentPlayerDef);
	}
	
	function start() {
		//H.loadGame();
		FlxTween.tween(hud, {alpha:0}, 1, {onComplete:function(_) {
			new FlxTimer().start(1,startText);
		}});
		
		//FlxG.switchState(new PlatformState());
		
	}
	
	function startText(_) {
		FlxSpriteUtil.fadeIn(text, 1);
		
		//text.resetText('HCS Phoenix\n2,000 souls aboard (cryosleep)\n126 years in into\na 350 year jouney.');
		new FlxTimer().start(4, function(_) {
			FlxSpriteUtil.fadeOut(text, 1, waitMeteor);
		});
	}
	
	function waitMeteor(_) {
		new FlxTimer().start(1.5, sendMeteor);
	}
	
	function sendMeteor(_) {
		
		
		meteor.visible = true;
		FlxTween.tween(meteor, {angle:88, x:0});
		FlxTween.tween(meteor.scale, {x:.01, y:.01}, 1, {onComplete:fadeScreen});
		
	}
	
	function fadeScreen(_) {
		Sounds.play(AllSounds.EXPLODE_LONG);
		FlxG.sound.music.stop();
		FlxG.camera.flash(FlxColor.RED, 500);
		new FlxTimer().start(2, function(_) {
		FlxG.camera.fade(FlxColor.BLACK, 1, false, function() {
			if(H.checkFlag('20'))
				FlxG.switchState(new PlatformState());
			else {
				H.setFlag(20);
				FlxG.switchState(new IntroState());
			}
		} );
		});
	}
	
	function clearSave(){
		H.clearSave();
		refreshPlayerDefDisplay();
	}
	
	function refreshPlayerDefDisplay() {
		currentPlayerDef.text = H.playerDef + '';
		currentPlayerDef.text += '\nCurrent level ' + H.currentLevel;
		currentPlayerDef.text += '\nPrevious level ' + H.previousLevel;
	}
	
	private function debug() {
		//H.playerDef.flags[13] = true;
		H.playerDef.flags[20] = true;
		H.previousLevel = 'temp';
		H.currentLevel = 'Command - Central Computer';
		H.playerDef.boost = true;
		H.playerDef.boostUpgrade = true;
		//H.playerDef.attacks[3] = true;
		H.playerDef.attacks[2] = true;
		H.playerDef.attacks[1] = true;
		refreshPlayerDefDisplay();
		FlxG.switchState(new PlatformState());
	}
}