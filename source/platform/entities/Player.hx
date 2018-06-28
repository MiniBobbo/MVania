package platform.entities;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import platform.entities.Attack.AttackTypes;
import platform.entities.movestates.PlayerBallAir;
import platform.entities.movestates.PlayerBallGround;
import platform.entities.movestates.PlayerPop;
import platform.entities.movestates.PlayerRobotAir;
import platform.entities.movestates.PlayerRobotBoost;
import platform.entities.movestates.PlayerRobotGround;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import fsm.FSM;
import inputhelper.InputHelper;
import platform.H;
import platform.entities.movestates.PlayerRobotPowerUp;
import platform.entities.movestates.PlayerRobotStun;

enum PlayerForm
{
	BALL;
	ROBOT;
}



/**
 * ...
 * @author Dave
 */
class Player extends Entity
{
	var i = InputHelper;
	var GRAVITY:Float = 4000;

	public var maxHP:Float = 10;
	public var maxEnergy:Float = 10;
	public var energy:Float = 10;
	//Energy charge per second.
	public var energyChargeRate:Float = 5;
	private var shotEnergyCost:Float = 2;
	
	
	
	var attackStatus:String = '';
	public var attackDelay(default, null):Float = 0;
	var ATTACK_DELAY:Float = .1;
	var attackHeight:Float = 18;
	var attackOffset:FlxPoint;
	
	//The Type of attack. 
	// 0 - normal
	// 1 - electric
	// 2 - fire
	public  var attackType:Int = 0;
	
	public var currentAttackType:AttackTypes;
	
	//Boost variables
public var currentBoostCount(default, null) :Int = 0;
	var maxBoostCount:Int = 0;
	
	public var playerForm(default, null):String;

	public function new(m:FlxTilemap)
	{
		super();
		changeForm(H.playerDef.playerForm);
		hp = maxHP;
		currentAttackType = AttackTypes.SHOT;
	}

	public function changeForm(newForm:String)
	{

		playerForm = newForm;
		H.playerDef.playerForm = newForm;
		
		switch (newForm)
		{
			case 'ROBOT':
				this.acceleration.y = H.GRAVITY;
				//Set the animation here.
				FlxG.watch.add(this,'width');
				FlxG.watch.add(this,'height');
				drag.set(0,0);
				maxVelocity.set(1000,1000);
				attackOffset = new FlxPoint(10,17);
				frames = FlxAtlasFrames.fromTexturePackerJson('assets/images/main.png', 'assets/images/main.json');
				animation.addByPrefix('jumpup', 'robot_jumpup', 6, false);
				animation.addByPrefix('stun', 'robot_jumpup', 6, false);
				animation.addByPrefix('jumpshot', 'robot_jumpshot', 12, false);
				animation.addByPrefix('jumpdown', 'robot_jumpdown', 6, false);
				animation.addByPrefix('idle', 'robot_idle_');
				animation.addByPrefix('powerup', 'robot_powerup_', 12, false);
				animation.addByPrefix('idleshoot', 'robot_idleshoot_');
				animation.addByPrefix('run', 'robot_running_', 12);
				animation.addByPrefix('boost', 'robot_boost_', 30, false);
				animation.addByPrefix('runshoot', 'robot_runningshoot_', 12);
				animation.play('run');
				centerOffsets();
				offset.y += 20;
				offset.x += 4;
				setSize(25, 28);

				fsm.addtoMap('ground', new PlayerRobotGround(this));
				fsm.addtoMap('air', new PlayerRobotAir(this));
				fsm.addtoMap('pop', new PlayerPop(this));
				fsm.addtoMap('powerup', new PlayerRobotPowerUp(this));
				fsm.addtoMap('stun', new PlayerRobotStun(this));
				fsm.addtoMap('boost', new PlayerRobotBoost(this));
				fsm.changeState('ground');
				trace('After changestate ' + toString() );

			case 'BALL':
				this.acceleration.y = H.GRAVITY;
				maxVelocity.set(200,200);
				setSize(8, 10);
				attackOffset = new FlxPoint(10,20);
				frames = H.getFrames();
				animation.addByPrefix('float', 'Ball_float_', 12);
				animation.addByPrefix('floatup', 'Ball_float_', 36);
				animation.play('float');
				centerOffsets();
				offset.y += 16;
				drag.set(700, 0);
				fsm.addtoMap('ground', new PlayerBallGround(this));
				fsm.addtoMap('air', new PlayerBallAir(this));
				fsm.addtoMap('stun', new PlayerBallAir(this));
				fsm.changeState('ground');

			default:

		}
	}

	override public function update(elapsed:Float):Void
	{
		//This assumes infinite acceleration and instant stopping.
		//This can be eliminated if using drag.
		attackDelay -= elapsed;

		if (!H.allowInput)
		{
			return;
		}

		//Allow weapons to be changed.
		if (InputHelper.isButtonJustPressed('weaponup' )) {
			weaponUp();
			H.ps.hud.selectWeapon(attackType);
			H.playerDef.attackSelected = attackType;
			setWeaponAttributes();
		}
		if (InputHelper.isButtonJustPressed('weapondown' )) {
			weaponDown();
			H.ps.hud.selectWeapon(attackType);
			H.playerDef.attackSelected = attackType;
			setWeaponAttributes();
		}
		
		
		super.update(elapsed);
		if (velocity.x > 0)
			flipX = true;
		if (velocity.x < 0)
			flipX = false;

	}
	
	/**
	 * Sets the attributes of this weapon, for example, the energy cost, damage, 
	 */
	private function setWeaponAttributes() {
		switch (currentAttackType) 
		{
			case AttackTypes.ELECTRIC:
				ATTACK_DELAY = .1;
				shotEnergyCost = 1;
			case AttackTypes.FIRE:
				ATTACK_DELAY = .15;
				shotEnergyCost = 2;
			default:
				ATTACK_DELAY = .2;
				shotEnergyCost = 2;
		}
	}

	private function weaponUp() {
		attackType++;
		if (attackType >= H.playerDef.attacks.length)
		attackType = 0;
		if (!H.playerDef.attacks[attackType])
		weaponUp();
	}
	
	private function weaponDown() {
		attackType--;
		if (attackType < 0)
		attackType = H.playerDef.attacks.length-1;
		if (!H.playerDef.attacks[attackType])
		weaponDown();
		
	}
	/**
	 * Sets the bottom of the player's hitbox on the specified y level.
	 * @param	floor
	 */
	public function setBottom(floor:Float)
	{
		y = floor - height;
	}

	override public function signal(signal:String, ?data:Dynamic)
	{
		switch (signal)
		{
			case 'hit':
				var a:Attack = cast data;
				takeDamage(a.strength);
			case 'addFire':
				H.playerDef.attacks[1] = true;
				attackType = 1;
				H.ps.hud.createWeaponBoxes();
				H.ps.hud.selectWeapon(attackType);
			case 'addLightning':
				H.playerDef.attacks[2] = true;
				attackType = 2;
				H.ps.hud.createWeaponBoxes();
			case 'stun':
				if (data == null || !Std.is(data, FlxPoint))
					return;
				fsm.changeState('stun');
				velocity.copyFrom(cast(data, FlxPoint));
			case 'boost':
				if (currentBoostCount > 0) {
					currentBoostCount--;
					fsm.changeState('boost');
				}
				
			default:

		}

	}

	private function getAttackDelay(type:AttackTypes):Float {
		switch (type) 
		{
			default:
				return .15;
				
		}
	}
	
	public function shoot2() {
		var attackType = AttackTypes.FIRE;
		if (attackDelay > 0 || energy < shotEnergyCost)
			return;
		attackDelay = getAttackDelay(attackType);
		changeEnergy(-shotEnergyCost);
		var a = H.ps.getUnivAttack();
		AttackFactory.configAttack(a, attackType );
		var direction = FlxPoint.get( -500, 0);
		var position = FlxPoint.get().copyFrom(getMidpoint());
		position.y = y + height - attackOffset.y;
		if (flipX)
		{
			position.x += attackOffset.x;
			direction.x *= -1;
		}
		else
			position.x -= attackOffset.x;		
			a.newInitAttack(position, direction, 4, AttackTypes.SHOT);

	}
	
	public function shoot()
	{
		if (attackDelay > 0 || energy < shotEnergyCost)
			return;
		attackDelay = ATTACK_DELAY;
		changeEnergy(-shotEnergyCost);
		var a = H.ps.getPlayerAttack();
		var direction = FlxPoint.get( -500, 0);
		var position = FlxPoint.get().copyFrom(getMidpoint());
		position.y = y + height - attackOffset.y;
		if (flipX)
		{
			position.x += attackOffset.x;
			direction.x *= -1;
		}
		else
			position.x -= attackOffset.x;
		if (attackType == 0)
			a.initAttack(position, direction, 10, 'playershot');
			
		else if (attackType == 1)
			a.initAttack(position, direction, 10, 'fireshot');
		else if (attackType == 2)
			a.initAttack(position, direction, 10, 'elecshot');
		direction.put();
		position.put();
		a.flipX = flipX;

	}

	override public function takeDamage(damage:Int = 1)
	{
		if (iTime > 0)
		return;
		
		hp -= damage;
		
		iTime = .5;
		FlxTween.color(this, .5, FlxColor.RED, FlxColor.WHITE);
		if (hp <= 0)
		{
			dead();
		}
	}

	private function dead() {
		
		//TODO:  Add Player death animation here.
		alive = false;
		visible = false;
		new FlxTimer().start(1, function(_) { H.ps.resetState(); });
	}
	
	public function changeEnergy(change:Float)
	{
		energy += change;
		if (energy > maxEnergy)
			energy = maxEnergy;
		if (energy < 0)
			energy = 0;
	}
	
	public function addEnergyStep(dt:Float) {
		changeEnergy(energyChargeRate * dt);
	}

	public function popOut()
	{
		if (playerForm != 'BALL')
			changeForm('BALL');
		fsm.changeState('pop');

	}
	
	public function resetBoost() {
		currentBoostCount = maxBoostCount;
	}
	
	public function setBoostCount(count:Int) {
		maxBoostCount = count;
	}
	
	
}