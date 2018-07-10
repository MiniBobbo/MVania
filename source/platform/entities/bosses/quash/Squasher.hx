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

	var t1:SquashTurret;
	var t2:SquashTurret;

	public function new(map:FlxTilemap) 
	{
		super();
		TotalHP = 40;
		
		createBody(map);
		createTurrets(map);
	}
	
	
	private function createBody(map:FlxTilemap) {
		addPiece(new Body(map) );
	}
	
	private function createTurrets(map:FlxTilemap) {
		t1 = new SquashTurret(map);
		t1.bossOffset.set(32, 64);
		addPiece(t1);
		t2 = new SquashTurret(map);
		t2.bossOffset.set(256, 64);
		addPiece(t2);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
}