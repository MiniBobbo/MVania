package platform.entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

enum AttackTypes {
	TEST;
	PLAYER_SHOT;
}

/**
 * ...
 * @author Dave
 */
class Attack extends FlxSprite
{
	public var lifespan:Float;
	public var strength:Int = 1;
	
	public var particleSpread:Int = 10;
	public var particleLifespan:Float = .5;
	public var particleLifespanSpread:Float = .5;
	
	private var attackVelocity:FlxPoint;
	
	public var type(default, null):AttackTypes;
	
	public var partColor:FlxColor = FlxColor.BLUE;
	
	public function new(lifespan:Float = 3 ) 
	{
		super();
		
		//Add animations here.

		
		attackVelocity = new FlxPoint();
		this.lifespan = lifespan;
		
		//this.velocity.set(velocity.x, velocity.y);
	}
	
	override public function update(elapsed:Float):Void 
	{
		//trace('Velocity :' + velocity);
		if (H.paused)
		return;
		//velocity.copyFrom(attackVelocity);
		super.update(elapsed);
		lifespan -= elapsed;
		if (lifespan <= 0) {
			this.kill();
		}
		
	}
	
	/**
	 * Resets an attacks parameters.  This should be called every time the attack is used
	 * @param	p the point this attack should appear.
	 * @param	v Velocity that this attack should travel.
	 * @param	lifespan Lifespan of the attack.
	 * @param 	The animation that this attack should have.  Doesn't do anything right now.
	 */
	public function initAttack(p:FlxPoint, v:FlxPoint, lifespan:Float, anim:String) {
		ID = FlxG.random.int();
		visible = true;
		changeHitBoxSize(anim);
		
		reset(p.x-width/2, p.y - height/2);
		//trace('Attack velocity ' + v);
		acceleration.set();
		maxVelocity.set(1000,1000);
		this.lifespan = lifespan;
		animation.play(anim, true);

		attackVelocity.set(v.x, v.y);
		velocity.copyFrom(attackVelocity);

	}
	
	override public function kill():Void 
	{
		super.kill();
		//TODO:Add the particle effect for attacks here.
	}
	
	private function changeHitBoxSize(anim:String) {
		// Override this to change the hitbox size and location based on the animation.
	}
	
	/**
	 * Called by an enttiy when hit by an attack.  Override to make the attack disappear or something.
	 * @param	e
	 */
	public function hitEntity(e:Entity) {
		
	}
	
	/**
	 * Called when an attack hits the map.  Override to do soemthing.
	 */
	public function hitMap() {
			
	}
	
	
}