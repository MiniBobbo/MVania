package platform.entities.enemies.mushboom;

import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import fsm.WaitFSM;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Mushboom extends Enemy 
{

	var HP_MAX:Float = 55;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		hp = HP_MAX;
		frames = H.getFrames();
		
		animation.addByPrefix('explode', 'Mushboom_explode', 1,false);
		animation.addByPrefix('idle', 'Mushboom_idle', 1,false);
		animation.addByPrefix('jumping', 'Mushboom_jumping_', 12);
		animation.addByPrefix('prepjump', 'Mushboom_prepjump_', 12, false);
		animation.addByPrefix('slam', 'Mushboom_slam_', 12, false);
		animation.addByPrefix('land', 'Mushboom_land_', 12, false);
		
		animation.play('idle');
		
		setSize(50, 50);
		centerOffsets();
		offset.y += 6;
		maxVelocity.set(1000,1000);
		
		var wait = new WaitFSM(this);
		wait.addPossibleState('spore');
		wait.addPossibleState('spawn');
		wait.addPossibleState('jump');
		
		wait.setWait(.5, .5);
		
		fsm.addtoMap('wait', wait);
		fsm.addtoMap('spore', new MushboomSporeFSM(this));
		fsm.addtoMap('spawn', new MushboomSpawnFSM(this));
		fsm.addtoMap('jump', new MushboomJumpFSM(this));
		fsm.addtoMap('explode', new MushboomExplode(this));
		fsm.addtoMap('jumping', new MushboomJumpingFSM(this));
		fsm.changeState('jumping');
		
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		entity.takeDamage(2);
	}
	
	override public function takeDamage(damage:Int = 1) 
	{
		if (hp == -1 || iTime > 0)
		return;
		
		//if (FlxSpriteUtil.isFlickering(this))
		//return;
		hp -= damage;
		FlxSpriteUtil.flicker(this, .2);
		if (hp <= 0) {
			velocity.x = 0;
			if (attack != null)
				attack.kill();
			alive = false;
			fsm.changeState('explode');
			//FlxSpriteUtil.fadeOut(this, .3, function(_) { this.kill(); } );
		}	
		
	}
}