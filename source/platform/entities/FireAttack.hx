package platform.entities;
import flixel.tile.FlxTilemap;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class FireAttack extends Enemy 
{

	public function new(map:FlxTilemap) 
	{
		super(map);
		frames = H.getFrames();
		animation.addByPrefix('powerup', 'icons_powerup_', 12);
		animation.play('powerup');
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		H.ps.player.signal('addFire');
		kill();
	}
	
}