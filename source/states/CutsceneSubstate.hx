package states;

import dialogwindow.DialogWindow;
import dialogwindow.DialogWindowManager;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

/**
 * ...
 * @author Dave
 */
class CutsceneSubstate extends FlxSubState 
{
	var dm:DialogWindowManager;
	var dw:DialogWindow;
	
	public function new(BGColor:FlxColor=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		dw = new DialogWindow(FlxPoint.weak(FlxG.width, 100), null);
		
		
	}
	
}