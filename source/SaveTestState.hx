package;

import defs.PlayerDef;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import haxe.Json;
import platform.H;

/**
 * ...
 * @author Dave
 */
class SaveTestState extends FlxState 
{

	var text:FlxText;
	var text2:FlxText;
	
	override public function create():Void 
	{
		var save = new FlxButton(0,0,'Save', onSave);
		var load = new FlxButton(0,25,'Load', onLoad);
		var addHP = new FlxButton(0, 50, 'Add HP', onAdd);
		var clearSave = new FlxButton(0, 75, 'Clear Save', onClear);
		
		text = new FlxText(100,0,200);
		text2 = new FlxText(100,100,200);
		
		add(save);
		add(load);
		add(addHP);
		add(clearSave);
		add(text);
		add(text2);
		
		onLoad();
	}
	
	private function onSave() {
		H.saveGame();
	}
	private function onLoad() {
		var success = H.loadGame();
		trace('Was load successful?  ' + success);
		if (!success) {
			trace('Creating default save');
			H.clearSave();
		}
		
		
	}
	private function onAdd() {
		H.playerDef.playerMaxHealth++;
	}
	private function onClear() {
		H.clearSave();
	}
	
	override public function update(elapsed:Float):Void 
	{
		text.text = 'Active: ' + Json.stringify(H.playerDef);
		text2.text = 'Saved: ' + Json.stringify(H.savedPlayerDef);
		super.update(elapsed);
		
	}
	
}