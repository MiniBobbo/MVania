package platform.entities;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import platform.entities.Attack.AttackTypes;
import platform.entities.attacks.UnivAttack;
import platform.entities.enemies.Cell;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Organ extends Enemy 
{
	var flies:FlxTypedGroup<Cell>;
	var enemies:FlxTypedGroup<Enemy>;
	
	var MAX_FLIES:Int = 4;
	var START_FLIES:Int = 1;
	
	var FLY_SPAWN_TIME:Float = 3;
	var spawnTime:Float = 3;
	var KNOCKBACK_STR:Float = 300;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('organ', 'organ', 1, false);
		animation.play('organ');
		centerOffsets();
		setSize(50, 50);
		centerOffsets();
		flies = new FlxTypedGroup<Cell>();
		hp = 8;
		immovable = true;
	}
	
	/**
	 * Stores the PlatformState enemies group so this object can add new enemies to it.
	 */
	public function setEnemies(enemies:FlxTypedGroup<Enemy>) {
		this.enemies = enemies;
	}

	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		spawnTime -= elapsed;
		
		if (spawnTime <= 0) {
			spawnTime = FLY_SPAWN_TIME;
			if (flies.countLiving() >= MAX_FLIES) {
				return;
			} else {
				var fly = flies.getFirstDead();
				if (fly == null) {
					fly = new Cell(collisionMap);
					enemies.add(fly);
					flies.add(fly);
				}
				var mp = getGraphicMidpoint();
				fly.reset(mp.x, mp.y-10);
				fly.hp = 3;
				fly.changeFSM('pulse');
				fly.shader = null;
				fly.alpha = 1;	
			}
		}
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (alive) {
			entity.signal('stun', FlxPoint.weak(0, -KNOCKBACK_STR).rotate(FlxPoint.weak(), getMidpoint().angleBetween(entity.getMidpoint())));
			entity.takeDamage(1);
		}
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		var a:UnivAttack = cast data;
		switch (signal) 
		{
			case 'hit':
				trace('Hit by attack ' + a.type);
				if (a.type == AttackTypes.FIRE) {
					takeDamage(a.strength *2);
				} else {
					takeDamage(a.strength);
				}
			default:
		}
	}
}