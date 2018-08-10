package platform.entities.enemies;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import platform.entities.Entity;
import platform.entities.gameentites.Enemy;
import sound.AllSounds;
import sound.Sounds;

/**
 * ...
 * @author Dave
 */
class Stomper extends Enemy 
{
	
	var back:FlxPoint;
	var DOWN_SPEED:Float = .25;
	var DOWN_TIME:Float = 1;
	var WAIT_TIME:Float = 1;
	var timer:FlxTimer;
	var waitTimer:Float;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('stomp', 'stomper_down', 1, false);
		animation.play('stomp');
		setSize(96, 96);
		centerOffsets();
		back = new FlxPoint();
		timer = new FlxTimer();
		waitTimer = WAIT_TIME;
		collideMap = false;
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		entity.takeDamage(3);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		waitTimer -= elapsed;
		if (waitTimer <= 0) {
			down();
			waitTimer = 1000;
		}
	}
	
	private function down() {
		back.set(x, y);
		FlxTween.tween(this, {y:y + 96}, DOWN_SPEED, {ease:FlxEase.quadIn, onComplete: function(_) { FlxG.camera.shake(.02, .1); Sounds.play(AllSounds.POUND); }});
		timer.start(WAIT_TIME, function(_) {
			FlxTween.tween(this, {y:back.y}, DOWN_SPEED, {ease:FlxEase.quadIn, onComplete:function(_) {waitTimer = WAIT_TIME; }});
		});
	}
	
}