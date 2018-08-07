package platform.entities.enemies.flybot;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class FlyBotGenerator extends Enemy 
{

	var flies:FlxTypedGroup<FlyBot>;
	var enemies:FlxTypedGroup<Enemy>;
	
	var MAX_FLIES:Int = 15;
	var START_FLIES:Int = 5;
	
	var FLY_SPAWN_TIME:Float = 1;
	var spawnTime:Float = 3;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('flash', 'FlyBotGenerator_flash_', 12);
		animation.play('flash');
		setSize(64, 64);
		centerOffsets();
		flies = new FlxTypedGroup<FlyBot>();
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
				trace('Making fly');
				var fly = flies.getFirstDead();
				if (fly == null) {
					fly = new FlyBot(collisionMap);
					enemies.add(fly);
					flies.add(fly);
				}
				var mp = getGraphicMidpoint();
				fly.reset(mp.x, mp.y-20);
				fly.hp = 1;
				fly.changeFSM('wait');
				fly.shader = null;
				fly.alpha = 1;	
			}
		}
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		FlxG.collide(this, entity);
	}
	
}