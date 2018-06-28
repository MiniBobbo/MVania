package platform.entities;

import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class LightningAttack extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('powerup', 'icons_powerup_', 12);
		animation.play('powerup');
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		H.ps.player.signal('addLightning');
		kill();
	}
	
	
}