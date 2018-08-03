package dialogwindow;
import dialogwindow.DialogWindowManager.DialogItem;
import flixel.util.FlxTimer;

typedef DialogItem = {
	var message:String;
	@:optional var emot:String;
	var left:Bool;
	var name:String;
}

/**
 * This class manages the dialog window.  Basically allows multiple dialogs to display in a row as well as maybe 
 * some additional features...
 * @author Dave
 */
class DialogWindowManager 
{
	var d:DialogWindow;
	public var finished(default, null):Bool  = true;
	
	var dialogs:Array<DialogItem>;
	
	public function new(dialogWindow:DialogWindow) 
	{
		d = dialogWindow;
		dialogs = [];
	}
	
	
	public function addDialog(message:String, ?emot:String, left:Bool  = true, name:String='') {
		dialogs.push( {
			message:message,
			emot:emot,
			left:left,
			name:name
		});
	}
	
	/**
	 * Plays the next dialog.
	 */
	public function next() {
		d.finished();
		if (dialogs.length == 0)
			return;
		finished = false;
		if (d.hidden) {
			var di:DialogItem = dialogs.shift();
			d.display(di.message, di.emot, di.left, di.name);
		} else {
			var di = dialogs.shift();
			d.finished();
			new FlxTimer().start(d.hideSpeed, function(_) { d.display(di.message, di.emot, di.left, di.name); } );
		}
		if (dialogs.length == 0) {
			finished = true;
		}
	}
	
	
	
}