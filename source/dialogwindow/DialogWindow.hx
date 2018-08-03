package dialogwindow;


import dialogwindow.DialogWindow.Position;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

enum Position {
	TOP;
	BOTTOM;
}

/**
 * Creates a new FlxTypeText box with a window.
 * @author Dave
 */
class DialogWindow extends FlxSpriteGroup 
{
	var position:Position;
	public var hidden(default, null):Bool = true;
	
	var dialogWidth:Int;
	var dialogHeight:Int;
	
	var textMargins:FlxPoint;
	
	public var hideSpeed(default,null):Float = .1;
	
	var showPosition:FlxPoint;
	var hidePosition:FlxPoint;
	
	
	var portrait:FlxSprite;
	var window:FlxSprite;
	var text:FlxText;
	var nameText:FlxText;
	
	var textOffset:Float = 0;
	var textSize:Int = 16;
	
	
	public function new(?size:FlxPoint, ?portraitSize:FlxPoint) 
	{
		super();
		//This shouldn't scroll with the camera.
		scrollFactor.set();
		dialogWidth = 960;
		dialogHeight = 200;

		textMargins = new FlxPoint(50,20);
		
		//Common sense default to displaying on the bottom of the screen.
		showPosition = new FlxPoint(0, FlxG.height - dialogHeight);
		hidePosition = new FlxPoint(0, FlxG.height);
		
		//Off the bottom of the screen.
		y = hidePosition.y;
		
		if (size != null) {
			dialogWidth = Std.int(size.x);
			dialogHeight = Std.int(size.y);
		}
		
		window = new FlxSprite();
		window.makeGraphic(Std.int(dialogWidth), Std.int(dialogHeight), FlxColor.GRAY);
		window.alpha = .3;
		add(window);
		text = new FlxText(textMargins.x, textMargins.y, dialogWidth - textMargins.x, '', textSize);
		setTextFormat(text);
		add(text);
		
	}
	
	public function addPortrait(sprite:FlxSprite, left:Bool = true) {
		portrait = sprite;
		textOffset = sprite.width;
		remove(text);
		text = new FlxText(textMargins.x, textMargins.y, Std.int(dialogWidth - sprite.width - textMargins.x), '', textSize);
		add(text);
		setTextFormat(text);
		add(portrait);
		//nameText = new FlxText(0,0, portrait.width, 'TEST', 14);
		nameText = new FlxText(portrait.x, 180, portrait.width, 'TEST', 14);
		nameText.setFormat(null, 14, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(nameText);
	}
	
	private function setTextFormat(text:FlxText) {
		text.setFormat(null, textSize, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	}
	
	/**
	 * Displays a new message box.  
	 * @param	text		The text that should be displayed.
	 * @param	emot		Actually the animation value that the portrait sprite should display, if any.
	 */
	public function display(message:String, ?emot:String, left:Bool = true, name:String = 'TEST') {
		hidden = false;
		
		if (portrait != null) {
			if(emot != null)
				portrait.animation.play(emot);
			if (left) {
				portrait.x = 0;
				nameText.x = 0;
				text.x = portrait.width + textMargins.x;
				nameText.text = name;
			}
			else  {
				portrait.x = dialogWidth - portrait.width;
				nameText.x = dialogWidth - portrait.width;
				text.x = 0 + textMargins.x;
				nameText.text = name;
			}
		}
		
		text.text = message;
		//text.start();
		
		FlxTween.linearMotion(this, this.x, this.y, showPosition.x, showPosition.y, hideSpeed, true);
		//fadeIn();
		
		
	}
	
	private function fadeIn(out:Bool = false) {
		if (out) {
			FlxTween.tween(this, 'alpha:0', hideSpeed );
		} else 
			FlxTween.tween(this, 'alpha:1', hideSpeed );

		
	}
	
	public function finished() {
		FlxTween.linearMotion(this, this.x, this.y, hidePosition.x, hidePosition.y, hideSpeed, true);
		//fadeIn(true);
		hidden = true;
	}
	
	public function changeShowHidePositions(show:FlxPoint, hide:FlxPoint) {
		showPosition.copyFrom(show);
		hidePosition.copyFrom(hide);
		
		if (hidden)
			setPosition(hidePosition.x, hidePosition.y);
		else
			setPosition(showPosition.x, showPosition.y);
	}

	
}