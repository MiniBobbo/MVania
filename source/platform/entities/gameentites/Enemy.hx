package platform.entities.gameentites;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import platform.entities.Entity;

enum EnemyState {
	PATROL;
	ATTACK;
	DEAD;
}

/**
 * ...
 * @author Dave
 */
class Enemy extends Entity 
{

	var lastHitID:Int;
	
	var enemyState:EnemyState;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super();
		this.collisionMap = collisionMap;
		enemyState = EnemyState.PATROL;
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		switch (signal) 
		{
			case 'hit':
				var a:Attack = cast data;
				var damage = a.strength;
				takeDamage(damage);
				
			default:
				
		}
	}
	
	
	
}