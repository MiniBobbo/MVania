package platform;
import haxe.ds.Vector;

/**
 * @author Dave
 */
typedef GameData =
{
	var flags:Array<Bool>;
	var world:Int;
	var checkpoint:String;
	var maxHealth:Int;
	
	var saveWorld:Int;
	var saveCheckpoint:String;
	
	var upgrades:Array<Bool>;
}