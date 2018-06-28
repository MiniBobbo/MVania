package;

import flixel.FlxGame;
import haxe.ds.StringMap;
import inputhelper.InputHelper;
import openfl.display.Sprite;
import platform.H;
import platform.PlatformState;
import platform.entities.Player.PlayerForm;

class Main extends Sprite
{
	public function new()
	{
		#if js
			trace('This is Javascript');
		#elseif cpp
			trace('This is CPP target');
		
		#end
		
		InputHelper.init();
		InputHelper.allowArrowKeys();
		InputHelper.allowWASD();
		InputHelper.addButton('jump');
		InputHelper.addButton('attack');
		InputHelper.addButton('use');
		InputHelper.addButton('weaponUp');
		InputHelper.addButton('weaponDown');
		InputHelper.assignKeyToButton('L', 'jump');
		InputHelper.assignKeyToButton('K', 'attack');
		InputHelper.assignKeyToButton('I', 'use');
		InputHelper.assignKeyToButton('E', 'weaponUp');
		InputHelper.assignKeyToButton('Q', 'weaponDown');
		H.currentLevel = '9';
		H.previousLevel = 'start';
		
		//Clear the save for testing.  This should be changed to LoadSave instead.
		
		H.defaultPlayerDef = {
			playerHealth:10,
			playerMaxHealth:10,
			playerForm:'ROBOT',
			upgradesCollected:new StringMap<Bool>(),
			flags:	new StringMap<Bool>(),
			checkpoint:'8',
			attacks:[true, false, false],
			attackSelected:0
			
		};
		H.clearSave();
		
		super();
		addChild(new FlxGame(480, 270, PlatformState));
	}
}
