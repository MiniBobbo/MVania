package platform.entities;
import defs.PlayerDef;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import platform.entities.Attack.AttackTypes;
import platform.entities.movestates.PlayerRobotAir;
import platform.entities.movestates.PlayerRobotBoost;
import platform.entities.movestates.PlayerRobotBoostUp;
import platform.entities.movestates.PlayerRobotGround;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import fsm.FSM;
import inputhelper.InputHelper;
import platform.H;
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
		applyPlayerDef(H.playerDef);
	}
	
	private function applyPlayerDef(pd:PlayerDef) {
		attackType = pd.attackSelected;
		hp = pd.playerHealth;
		maxHP = pd.playerMaxHealth;
		energy = pd.playerEnergy;
		maxEnergy = pd.playerMaxEnergy;
		attackType = pd.attackSelected;
		currentAttackType = weaponIntToEnum(attackType);
		if (pd.boost)
			currentBoostCount = 1;
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
				//FlxG.watch.add(this,'width');
				//FlxG.watch.add(this,'height');
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
				animation.addByPrefix('boostup', 'robot_boostup_', 30, false);
				animation.addByPrefix('runshoot', 'robot_runningshoot_', 12);
				animation.play('run');
				centerOffsets();
				offset.y += 20;
				offset.x += 4;
				setSize(25, 28);

				fsm.addtoMap('ground', new PlayerRobotGround(this));
				fsm.addtoMap('air', new PlayerRobotAir(this));
				fsm.addtoMap('stun', new PlayerRobotStun(this));
				fsm.addtoMap('boost', new PlayerRobotBoost(this));
				fsm.addtoMap('boostup', new PlayerRobotBoostUp(this));
				fsm.changeState('ground');
				//trace('After changestate ' + toString() );

		

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
			currentAttackType = weaponIntToEnum(attackType);
			setWeaponAttributes();
		}
		if (InputHelper.isButtonJustPressed('weapondown' )) {
			weaponDown();
			H.ps.hud.selectWeapon(attackType);
			H.playerDef.attackSelected = attackType;
			currentAttackType = weaponIntToEnum(attackType);
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
		trace('Received generic signal ' + signal);
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
				H.ps.hud.selectWeapon(attackType);
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
			case 'boostup':
				if (currentBoostCount > 0) {
					currentBoostCount--;
					trace('Boost up signal received.');
					fsm.changeState('boostup');
				}
			case 'energyup':
				energyBoost();
			case 'hpup':
				hpBoost();
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

	
	public function shoot(attackType:AttackTypes)
	{
		if (attackDelay > 0 || energy < shotEnergyCost)
			return;
		attackDelay = getAttackDelay(attackType);
		changeEnergy(-shotEnergyCost);
		var a = H.ps.getPlayerAttack();
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
		a.newInitAttack(position, direction, 4, attackType);

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
		fsm.changeState('dead');
		new FlxTimer().start(1, function(_) { 
			H.loadGame();
			H.ps.resetState(); 
			
		});
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
	
	private function weaponIntToEnum(attackInt:Int):AttackTypes {
		var attackEnum:AttackTypes;
		switch (attackInt) 
		{
			case 0:
				attackEnum = AttackTypes.SHOT;
			case 1:
				attackEnum = AttackTypes.FIRE;
			case 2:
				attackEnum = AttackTypes.ELECTRIC;
				
			default:
				attackEnum = AttackTypes.SHOT;
		}
		
		return attackEnum;
	}
	
	private function hpBoost(add:Int = 3) {
		maxHP += add;
		hp += add;
	}	
	
	private function energyBoost(add:Int = 3) {
		maxEnergy += add;
		energy += add;
	}
}