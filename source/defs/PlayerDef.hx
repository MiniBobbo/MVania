package defs;
import haxe.ds.StringMap;
import platform.entities.Player.PlayerForm;

/**
 * @author Dave
 */
typedef PlayerDef =
{
	var playerHealth:Float;
	var playerMaxHealth:Float;
	var playerForm:String;
	var upgradesCollected:StringMap<Bool>;
	var boost:Bool;
	var boostUpgrade:Bool;
	var checkpoint:String;
	var attacks:Array<Bool>;
	var attackSelected:Int;
	
	
}