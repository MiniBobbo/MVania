package platform.entities.bosses.quash;
import flixel.FlxG;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Squasher extends Boss 
{

	public var t1(default,null):SquashTurret;
	public var t2(default,null):SquashTurret;

	public function new(map:FlxTilemap) 
	{
		super();
		TotalHP = 40;
		
		createBody(map);
		createTurrets(map);
		fsm.addtoMap('fire', new SquashFireFSM(this));
		fsm.addtoMap('wait', new SquashWaitFSM(this));
		fsm.changeState('wait');
		FlxG.watch.add(this.fsm, 'currentModule', 'Squash mod');
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
	
	public function getMidX():Float {
		return pos.x + 160;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
}