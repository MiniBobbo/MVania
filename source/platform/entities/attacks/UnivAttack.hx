package platform.entities.attacks;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import platform.entities.Attack;
import platform.entities.Entity;
import sound.AllSounds;
import sound.Sounds;

/**
 * ...
 * @author Dave
 */
class UnivAttack extends Attack 
{
	public var onUpdate:UnivAttack->Float->Void;
	public var onInit:UnivAttack->Void;
	public var onComplete:UnivAttack->Void;
	public var onHitMap:UnivAttack->Void;
	public var onHit:UnivAttack->Void;
	
	public var fireAnim:String;
	public var endAnim:String;
	
	public var energyCost:Float = 2;
	
	public var collideMap:Bool = true;
	
	public function new(lifespan:Float=3) 
	{
		super(lifespan);
		onHitMap = function(a:UnivAttack) {
			if (!alive)
				return;
			alive = false;
			if (onComplete == null) {
				animation.play(endAnim);
				new FlxTimer().start(1, function(_) {exists = false; });

			} else {
				onComplete(this);
			}
		}; 
		
		onHit = function(a:UnivAttack) {
			if (!alive)
				return;
			alive = false;
			if (onComplete == null) {
				animation.play(endAnim);
				new FlxTimer().start(1, function(_) {exists = false; });

			} else {
				onComplete(this);
			}
		}; 
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (onUpdate != null) {
			onUpdate(this, elapsed);
		}
		 
	}
	
	public function setHitboxSize(type:AttackTypes) {
		switch (type) 
		{
			case AttackTypes.LARGESHOT:
				setSize(20, 32);
				
			default:
				setSize(10, 10);
		}
	}
	/**
	 * Resets an attacks parameters.  This should be called every time the attack is used
	 * @param	p the point this attack should appear.
	 * @param	v Velocity that this attack should travel.
	 * @param	lifespan Lifespan of the attack.
	 * @param 	The type of attack
	 */
	public function newInitAttack(p:FlxPoint, v:FlxPoint, lifespan:Float, type:AttackTypes) {
		ID = FlxG.random.int();
		visible = true;
		startSound(type);
		//setHitboxSize(type);
		//centerOffsets();
		reset(p.x-width/2, p.y - height/2);
		//trace('Attack velocity ' + v);
		maxVelocity.set(1000, 1000);
		velocity.copyFrom(v);
		this.lifespan = lifespan;
		if(onInit != null)
			onInit(this);
		else {
			animation.play(fireAnim);
			centerOffsets();
		}

	}
	
	private function startSound(type:AttackTypes) {
		switch (type) 
		{
			case AttackTypes.SHOT:
				Sounds.play(AllSounds.SHOT);
			case AttackTypes.ELECTRIC:
				Sounds.play(AllSounds.ELECTRIC);
			case AttackTypes.SHOCKWAVE:
				Sounds.play(AllSounds.SHOCKWAVE);
			case AttackTypes.AIRBLADE:
				Sounds.play(AllSounds.AIRBLADE);
			case AttackTypes.FIRE:
				Sounds.play(AllSounds.FIRE);
				
				
			default:
				
		}
	}
	
	public function setUpdateFunction(f:UnivAttack->Float->Void) {
		onUpdate = f;
		
	}
	public function setInitFunction(f:UnivAttack->Void) {
		onInit = f;
	}
	public function setHitMapFunction(f:UnivAttack->Void) {
		onHitMap = f;
	}
	public function setHitFunction(f:UnivAttack->Void) {
		onHit = f;
	}

	public function setCompleteFunction(f:UnivAttack->Void) {
		onComplete = f;
	}
	override public function hitMap() 
	{
		if (onHitMap != null) {
			onHitMap(this);
			return;
		}
		
		if (!alive)
			return;
		alive = false;
		if (onComplete == null) {
			animation.play(endAnim);
			new FlxTimer().start(1, function(_) {exists = false; });

		} else {
			onComplete(this);
		}
	}
	
	override public function hitEntity(e:Entity) 
	{
		onHit(this);
	}
}