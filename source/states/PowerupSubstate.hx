package states;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Dave
 */
class PowerupSubstate extends FlxSubState 
{
	var text:FlxText;
	var box:FlxSprite;
	var e:FlxSpriteGroup;
	
	public function new(message:String) 
	{
		super();
		
		text = new FlxText(130,90, 220);
		text.scrollFactor.set();
		text.setFormat('assets/data/font/TektrReg.ttf', 16, FlxColor.WHITE, FlxTextAlign.CENTER);
		text.text = message;
		box = new FlxSprite();
		box.scrollFactor.set();
		box.makeGraphic(230, 105, FlxColor.BLACK);
		box.alpha = .7;
		box.screenCenter();
		
		e = new FlxSpriteGroup();
		e.scrollFactor.set();
		e.y -= 400;
		e.add(box);
		e.add(text);
		add(e);
		
		FlxTween.tween(e, {y:0}, .3).onComplete = function(_) {
			new FlxTimer().start(3, function(_) { 
				FlxTween.tween(e, {y: - 400}, .3, {onComplete: function(_) {_parentState.closeSubState(); }});
				
			});
		};
	}
	
}