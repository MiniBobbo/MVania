package platform.entities.enemies.porter;

import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import fsm.WaitFSM;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Porter extends Enemy 
{

	var PORTER_HP:Float = 8;
	
	var floatOffset:Float = 0;
	
	var tween:FlxTween;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		collideMap = false;
		frames = H.getFrames();
		animation.addByPrefix('float', 'porter_float_');
		animation.addByPrefix('flash', 'porter_flash_');
		animation.play('float');
		setSize(33, 40);
		centerOffsets();
		offset.y = -10;
		var wait = new WaitFSM(this);
		fsm.addtoMap('wait', wait);
		fsm.addtoMap('port', new FSMTeleportState(this));
		fsm.addtoMap('attack', new PorterAttackFSM(this));
		fsm.changeState('wait');
		wait.setWait(1.5, 1);
		wait.addPossibleState('port');
		wait.addPossibleState('port');
		wait.addPossibleState('attack');
		
		hp = PORTER_HP;
		
		tween = FlxTween.tween(this, {floatOffset: 8}, 1, {type:FlxTween.PINGPONG, ease:FlxEase.quadInOut});
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		offset.y = floatOffset;
		super.update(elapsed);
	}
	
	override public function kill():Void 
	{
		super.kill();
		tween.cancel();
		tween.destroy();
	}
}