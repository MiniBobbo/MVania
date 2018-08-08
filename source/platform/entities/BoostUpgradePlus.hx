package platform.entities;

import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class BoostUpgradePlus extends Enemy 
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
		H.playerDef.boostUpgrade = true;
		H.ps.player.setBoostCount(2);
		H.ps.hud.createHUD();
		kill();
	}

	
}