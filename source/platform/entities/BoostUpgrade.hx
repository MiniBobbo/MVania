package platform.entities;

import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class BoostUpgrade extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('powerup', 'icons_boost_', 6);
		animation.play('powerup');
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		H.playerDef.boost = true;
		H.ps.player.setBoostCount(1);
		H.ps.hud.createHUD();
		kill();
	}

	
}