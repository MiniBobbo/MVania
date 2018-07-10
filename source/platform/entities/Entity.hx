package platform.entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import fsm.FSM;
import fsm.IFSM;

/**
 * ...
 * @author Dave
 */
class Entity extends FlxSprite implements IFSM
{

	public var collisionMap(default, null):FlxTilemap;

	//
	//var currentMoveEnum:MovementStateEnum;
	//var currentMoveState:MoveState;
	//var moveStateMap:Map<MovementStateEnum, MoveState>;
	var restoreSize:Float = 0;
	
	public var attack(default, null):Attack;
	
	public var collideMap:Bool = true;
	
	public var fsm:FSM;
	
	public var tempGravity(default, null) :Float;
	public var permGravity(default, null) :FlxPoint;
	public var gravityHold:Float;
	
	//What is the ID of the last hit on this entity?  Basically allows an entity to not be hit by the same attack multiple times.  
	//This isn't really needed if entities have an invincibility like with a flash or something.  It was trying to solve a problem that
	//I didn't have, so I abandoned it.
	public var IDLastAttackHit(default, null):Int;
	
	//Invincibility time.
	var iTime:Float = 0;
	
	//How many HP does this entity have?  If -1, then it is invincible.
	public var hp:Float = -1;
	
	public function new() 
	{
		super();
		fsm = new FSM(this);
	}
	
	public function changeFSM(name:String):Void {
		fsm.changeState(name);
	}
	/**
	 * When two entities overlap, this is passed to each entity.  
	 * @param	entity  The entity that overlaps with this one.
	 * @param   data	Misc data.  This can be anything.
	 */
	public function overlapEntity(entity:Entity, ?data:Dynamic) {
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		//TODO Be smarter about temp gravity.  Maybe something event based?
		
		
		if (iTime > 0)
		 iTime -= elapsed;
		if(collideMap)
			FlxG.collide(this, collisionMap);
		if (fsm.currentModule != null)
			fsm.currentModule.update(elapsed);

		super.update(elapsed);
	}
	
	/**
	 * Sends a signal to this entity.  Use H.signal to send it to all entities.  Override this on entities to do something.
	 * @param	signal  The signal to send.
	 * @param	data	Optional data parameter.
	 */
	public function signal(signal:String, ?data:Dynamic) {
		
	}
	
	public function takeDamage(damage:Int = 1) {
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
			FlxSpriteUtil.fadeOut(this, .3, function(_) { this.kill(); } );
		}
	}
	
	/**
	 * Shrinks the hitbox down from the top, leaving the bottom of the hitbox in the same place.
	 * @param	percent		The percent to shrink the hitbox.
	 */
	public function shrinkHitboxY(percent:Float = .5) {
		restoreSize = height;
		var bottom = y + height;
		var change = height * percent;
		height = change;
		y += change;
		offset.y += change;
		
	}
	
	public function restoreHitboxY() {
		var bottom = y + height;
		var change = restoreSize - height;
		y -= change;
		height = restoreSize;
		offset.y -= change;
		
	}
	
	public function dropDown() {
		y += 4;
	}
	
	public function registerAttack(a:Attack) {
		attack = a;
	}
	
	public function releaseAttack() {
		attack = null;
	}
	
	/**
	 * Flexes this entity.  Basically stretches it in the X and/or Y direction and then returns it quickly.
	 * Used for things like jumping.
	 * @param	xDirection	Percentage of stretch in the X direction.  So 1.2 would stretch 20% in the X.
	 * @param	yDirection	Samwe for Y
	 */
	public function flex(xDirection:Float, yDirection:Float, returnTime:Float = .2) {
		var oldX = scale.x;
		var oldY = scale.y;
		
		scale.x = xDirection;
		scale.y = yDirection;
		
		FlxTween.tween(this.scale, {x:oldX, y:oldY}, returnTime);
	}
	
	public function isInvincible():Bool {
		if (iTime > 0)
			return true;
		return false;
	}
	
	public function applyTempGravity() {
		
	}
}