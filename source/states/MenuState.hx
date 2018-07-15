package states;

import flixel.FlxState;
import flixel.addons.ui.FlxButtonPlus;

/**
 * ...
 * @author Dave
 */
class MenuState extends FlxState 
{

	var startGame:FlxButtonPlus;
	
	
	override public function create():Void 
	{
		super.create();
		startGame = new FlxButtonPlus(0, 0, start, 'Start Game');
		startGame.screenCenter();
	}
	
	function start() {
		
	}
}