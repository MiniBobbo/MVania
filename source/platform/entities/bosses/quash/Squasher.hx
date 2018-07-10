package platform.entities.bosses.quash;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Squasher extends Boss 
{

	public function new(map:FlxTilemap) 
	{
		super();
		TotalHP = 40;
		
		createBody(map);
	}
	
	
	private function createBody(map:FlxTilemap) {
		var body = new Body(map);
	}
}