package platform.entities.enemies.porter;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import fsm.WaitFSM;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Porter extends Enemy 
{

	var PORTER_HP:Float = 8;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		collideMap = false;
		makeGraphic(20, 20, FlxColor.GRAY);
		var wait = new WaitFSM(this);
		fsm.addtoMap('wait', wait);
		fsm.addtoMap('port', new FSMTeleportState(this));
		fsm.changeState('wait');
		wait.setWait(1.5, 1);
		wait.addPossibleState('port');
		wait.addPossibleState('port');
		
		hp = PORTER_HP;
	}
	
}