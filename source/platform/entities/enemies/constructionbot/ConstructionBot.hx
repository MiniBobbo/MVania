package platform.entities.enemies.constructionbot;

import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import fsm.WaitFSM;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class ConstructionBot extends Enemy 
{

	var MAX_HP:Float = 35;
	
	//The bot will jump from the right to the left side of the screen.  This keeps track of what side he is on.
	public var right:Bool = true;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('idle', 'constructbot_idle_', 16);
		animation.addByPrefix('jumping', 'constructbot_jumping_', 16);
		animation.addByPrefix('prepjump', 'constructbot_prepjump_', 16, false);
		animation.addByPrefix('up', 'constructbot_up_', 8, false);
		animation.addByPrefix('down', 'constructbot_down_', 8, false);
		animation.addByPrefix('getup', 'constructbot_getup_', 8, false);
		animation.addByPrefix('side', 'constructbot_side_', 8, false);
		animation.addByPrefix('land', 'constructbot_land_', 8, false);
		animation.addByPrefix('explode', 'constructbot_exploding_', 8);
		animation.play('idle');
		
		setSize(75, 65);
		centerOffsets();
		offset.y += 14;
		hp = MAX_HP;
		
		acceleration.y = H.GRAVITY;
		
		
		var wait = new WaitFSM(this);
		wait.addPossibleState('shoot');
		wait.addPossibleState('jump');
		wait.setWait(.25, 0);
		
		fsm.addtoMap('wait', wait);
		fsm.addtoMap('jump', new ConstructBotJumpFSM(this));
		fsm.addtoMap('shoot', new ConstructionBotShootFSM(this));
		fsm.addtoMap('explode', new ConstructionBotExplodeFSM(this));
		
		fsm.changeState('wait');
		
		
	}
	
	override public function kill():Void 
	{
		super.kill();
		H.setFlag(0, false);
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		if (alive)
			entity.takeDamage(1);
		
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