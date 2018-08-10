package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author Dave
 */
class EndGameState extends FlxState 
{

	var hud:FlxSpriteGroup;
	var bg1:FlxBackdrop;
	var bg2:FlxBackdrop;
	var ship:FlxSprite;
	var meteor:FlxSprite;
	var logo:FlxSprite;
	
	var text:FlxText;
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		var bg1 = new FlxBackdrop('assets/images/starfield_0.png');
		bg1.scrollFactor.set(.2, .2);
		bg1.velocity.x = 50;
		var bg2 = new FlxBackdrop('assets/images/starfield_1.png');
		bg2.scrollFactor.set(.5, .5);
		bg2.velocity.x = 200;
		
		add(bg1);
		add(bg2);

		ship = new FlxSprite(0, -20, 'assets/images/ship.png');
		FlxTween.tween(ship, {y:0}, 2, {ease:FlxEase.quadInOut, type:FlxTween.PINGPONG});
		add(ship);

		text = new FlxText(50, FlxG.height + 100, FlxG.width - 100 );
		text.setFormat('assets/data/font/TektrReg.ttf', 12, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK );
		text.text = 'Status update: OPHIOCOR infection eliminated.\n\nCongratulations!\n\nSorry for the crappy ending.\n\nMusic: Dark City (main game loop) by Muncheybobo\nIntro music: Empty City (Public Domain)\n\nEverything else by Dave (MiniBobbo)\n\nThanks for playing!';
		FlxTween.tween(text, {y:20}, 30);
		add(text);
	}
	
}