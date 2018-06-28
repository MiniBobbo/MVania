package platform.entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import haxe.Constraints.Function;

/**
 * ...
 * @author Dave
 */
class Bar extends FlxSpriteGroup 
{
	var maxValue:Float;
	var currentValue:Float;
	//The width of the bar in pixels
	public var barWidth(default, null) :Int = 100;
	var bar:FlxBar;
	
	/**
	 * Creates a new bar that tracks a specific value.
	 * @param	object		The object to track.
	 * @param	field		The field in the object.  
	 */
	public function new(parentRef:Dynamic, variable:String, maxValue:Float) 
	{
		super();
		var b1 = new FlxSprite();
		b1.frames = H.getFrames();
		b1.animation.frameName = 'icons_bar1_0';
		var b2 = new FlxSprite();
		b2.frames = H.getFrames();
		b2.animation.frameName = 'icons_bar3_0';
		b2.setPosition(barWidth + 2, 0);
		var s= new FlxSprite();
		s.frames = H.getFrames();
		s.animation.frameName = 'icons_bar3_0';
		
		var b3 = new FlxSprite(2,0);
		b3.makeGraphic(barWidth, 7, FlxColor.TRANSPARENT, true);
		for (i in 0...barWidth) {
			b3.stamp(s, i, 0);
		}
		bar  = new FlxBar(4, 0, FlxBarFillDirection.LEFT_TO_RIGHT, barWidth, 11, parentRef, variable, 0, maxValue, true);
		bar.createColoredEmptyBar(FlxColor.BLACK);
		bar.createColoredFilledBar(FlxColor.RED);
		add(bar);
		
		add(b3);
		add(b2);
		add(b1);
	}
	
	public function setBarColor(color:FlxColor) {
		bar.createColoredFilledBar(color);
	}
	
}