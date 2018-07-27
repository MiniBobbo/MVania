package platform.entities;

import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class EnergyUp extends Enemy 
{

	var flag:Int;
	public function new(collisionMap:FlxTilemap, flag:Int) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('eup', 'icons_energyup_', 12);
		animation.play('eup');
		setFlagNum(flag);
		
	}
	
	public function setFlagNum(flag:Int){
		this.flag = flag;
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		super.overlapEntity(entity, data);
		H.ps.player.signal('energyup');
		kill();
		H.playerDef.flags[flag] = true;
		
	}
	
}