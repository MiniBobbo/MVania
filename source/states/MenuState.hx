package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxButtonPlus;
import flixel.text.FlxText;
import platform.H;
import platform.PlatformState;

/**
 * ...
 * @author Dave
 */
class MenuState extends FlxState 
{

	var startGame:FlxButtonPlus;
	var clearData:FlxButtonPlus;
	
	
	var currentPlayerDef:FlxText;
	var savedPlayerDef:FlxText;
	
	
	override public function create():Void 
	{
		H.loadGame();
		super.create();
		startGame = new FlxButtonPlus(0, 0, start, 'Start Game');
		
		startGame.screenCenter();
		add(startGame);
		
		clearData = new FlxButtonPlus(0, 0, clearSave, 'Clear Saved Data');
		add(clearData);
		
		currentPlayerDef = new FlxText(100, 0, 300, H.playerDef + '');
		add(currentPlayerDef);
	}
	
	function start() {
		H.loadGame();
		FlxG.switchState(new PlatformState());
	}
	
	function clearSave(){
		H.clearSave();
		refreshPlayerDefDisplay();
	}
	
	function refreshPlayerDefDisplay() {
		currentPlayerDef.text = H.playerDef + '';
	}
}