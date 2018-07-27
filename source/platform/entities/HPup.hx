package platform.entities;

import flixel.tile.FlxTilemap;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class HPup extends Enemy 
{
	var flag:Int;
	public function new(collisionMap:FlxTilemap, flag:Int) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('hpup', 'icons_hpup_', 12);
		animation.play('hpup');
		setFlagNum(flag);
	}
	
	public function setFlagNum(flag:Int){
		this.flag = flag;
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		super.overlapEntity(entity, data);
		H.ps.player.signal('hpup');
		kill();
		H.playerDef.flags[flag] = true;
		
	}
	
}