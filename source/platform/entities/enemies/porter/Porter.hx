package platform.entities.enemies.porter;

import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
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
		makeGraphic(20, 20, FlxColor.GRAY);
		fsm.addtoMap('wait', new PorterWait(this));
		fsm.changeState('wait');
		hp = PORTER_HP;
	}
	
}