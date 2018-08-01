package platform.entities.enemies.mushboom;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import fsm.WaitFSM;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class MushboomSmall extends Enemy 
{
	var colors = ['red', 'blue', 'green'];

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		hp = 5;
		frames = H.getFrames();
		var type = colors[FlxG.random.int(0, colors.length - 1)];
		
		acceleration.y = H.GRAVITY/3;
		
		animation.addByPrefix('walk', 'mushboom_small_walk_' + type, 12);
		animation.addByPrefix('idle', 'mushboom_small_idle_' + type);
		animation.addByPrefix('fall', 'mushboom_small_falling_' + type);
		animation.addByPrefix('explode', 'mushboom_small_explode_' + type);
		animation.play('idle');
		
		var wait = new WaitFSM(this);
		wait.addPossibleState('walk');
		wait.addPossibleState('wait');
		wait.addPossibleState('spore');
		fsm.addtoMap('wait', wait);
		fsm.addtoMap('walk', new MushBoomSmallWalk(this) );
		fsm.addtoMap('air', new MushboomSmallAir(this));
		fsm.addtoMap('spore', new MushboomSmallSpores(this));
		
		fsm.changeState('air');
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		entity.takeDamage(1);
	}
	
}