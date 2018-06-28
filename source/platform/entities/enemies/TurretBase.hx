package platform.entities.enemies;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class TurretBase extends Enemy 
{

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		
		frames = H.getFrames();
		animation.addByPrefix('base', 'turret_base_');
		animation.play('base');
	}
	
}