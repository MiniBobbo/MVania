package platform.entities.enemies;

import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import platform.entities.Attack.AttackTypes;
import platform.entities.Entity;
import platform.entities.attacks.UnivAttack;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Cell extends Enemy 
{
	var CELL_SPEED:Float = 150;
	var CELL_MAX_SPEED:Float = 200;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		maxVelocity.set(CELL_MAX_SPEED, CELL_MAX_SPEED);
		frames = H.getFrames();
		animation.addByPrefix('pulse', 'cells_pulse_', 12);
		animation.play('pulse');
		centerOffsets();
		setSize(30, 30);
		hp = 3;
		collideMap = false;
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		super.overlapEntity(entity, data);
		entity.takeDamage(2);
	}
	
	override public function update(elapsed:Float):Void 
	{
		var dir = FlxPoint.get(0, -CELL_SPEED);
		dir.rotate(FlxPoint.weak(), getMidpoint().angleBetween(H.ps.player.getMidpoint()));
		acceleration.copyFrom(dir);
		super.update(elapsed);
		dir.put();
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		var a:UnivAttack = cast data;
		switch (signal) 
		{
			case 'hit':
				trace('Hit by attack ' + a.type);
				if (a.type == AttackTypes.FIRE) {
					takeDamage(a.strength *3);
				} else {
					takeDamage(a.strength);
				}
			default:
		}
	}
	
}