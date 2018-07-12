package platform.entities.bosses.quash;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.FlxTweenManager;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import platform.entities.Entity;
import platform.entities.bosses.Piece;

/**
 * ...
 * @author Dave
 */
class SquashArm extends Piece 
{
	var upY:Float = 32;
	var downY:Float = 128;
	var tweens:FlxTweenManager;
	
	var CRUSH_SPEED:Float =.2;
	var DOWN_SPEED:Float = 1;
	var HIT_DAMAGE:Int = 2;
	var KNOCKBACK_STR:Float = 300;

	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('lefty', 'squasharm_lefty_0', 1,false);
		animation.addByPrefix('righty', 'squasharm_righty_0', 1, false);
		animation.play('lefty');
		setSize(64, 128);
		centerOrigin();
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		switch (signal) 
		{
			case 'crush':
				FlxTween.tween(this.bossOffset, {y:downY}, CRUSH_SPEED, {ease:FlxEase.quadIn, onComplete:function(_) {FlxG.camera.shake(.02, .2); }}).wait(.5).then(FlxTween.tween(this.bossOffset, {y:upY}, CRUSH_SPEED * 2));
				
			case 'down':
				FlxTween.tween(this.bossOffset, {y:downY}, DOWN_SPEED);
			case 'up':
				FlxTween.tween(this.bossOffset, {y:upY}, DOWN_SPEED);
				
				
			default:
				
		}
	}
	
	override public function overlapEntity(entity:Entity, ?data:Dynamic) 
	{
		entity.takeDamage(2);
		entity.signal('stun', FlxPoint.weak(0, -KNOCKBACK_STR).rotate(FlxPoint.weak(), getMidpoint().angleBetween(entity.getMidpoint())));

	}
	
	
}