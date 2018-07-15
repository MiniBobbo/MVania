package platform.entities.bosses.quash;
import flixel.FlxG;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Squasher extends Boss 
{
	private var body:Body;
	public var t1(default,null):SquashTurret;
	public var t2(default,null):SquashTurret;
	public var rightArm:SquashArm;
	public var leftArm:SquashArm;
	public var weakLeft:SquashWeak;
	public var weakRight:SquashWeak;
	
	//Store the last state so we don't pick it twice in a row.
	public var lastState(default, null):String;
	
	
	public function new(map:FlxTilemap) 
	{
		super();
		TotalHP = 20;
		
		createBody(map);
		createTurrets(map);
		createArms(map);
		fsm.addtoMap('fire', new SquashFireFSM(this));
		fsm.addtoMap('contain', new SquasherContainFSM(this));
		fsm.addtoMap('wait', new SquashWaitFSM(this));
		fsm.addtoMap('crush', new SquashCrushFSM(this));
		fsm.addtoMap('randomStomp', new SquashRandomStompFSM(this));
		fsm.changeState('wait');
		FlxG.watch.add(this.fsm, 'currentModuleName', 'Squash mod');
		FlxG.watch.add(this.fsm, 'skipModule', 'Squash stop');
	}
	
	
	private function createBody(map:FlxTilemap) {
		body = new Body(map);
		addPiece(body );
	}
	
	private function createTurrets(map:FlxTilemap) {
		t1 = new SquashTurret(map);
		t1.bossOffset.set(64, 64);
		t1.connectToPiece(body);
		addPiece(t1);
		t2 = new SquashTurret(map);
		t2.bossOffset.set(224, 64);
		t2.connectToPiece(body);
		addPiece(t2);
		
	}
	
	private function createArms(map:FlxTilemap) {
		leftArm = new SquashArm(map);
		leftArm.bossOffset.y = 32;
		leftArm.connectToPiece(body);
		rightArm = new SquashArm(map);
		rightArm.bossOffset.y = 32;
		rightArm.bossOffset.x = 256;
		rightArm.connectToPiece(body);
		rightArm.flipX = true;
		addPiece(leftArm);
		addPiece(rightArm);
		
		weakLeft = new SquashWeak(map);
		weakLeft.bossOffset.set(32, 31);
		weakLeft.connectToPiece(leftArm);
		weakLeft.offset.x = 2;
		addPiece(weakLeft);
		weakRight = new SquashWeak(map);
		weakRight.flipX = true;
		weakRight.offset.x = -8;
		weakRight.bossOffset.set(-10, 31);
		weakRight.connectToPiece(rightArm);
		
		addPiece(weakRight);
	}
	
	public function getMidX():Float {
		return pos.x + 160;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
	override public function takeDamage(damage:Float) 
	{
		super.takeDamage(damage);
		FlxSpriteUtil.flicker(body, .3);
		
	}
	
	override public function changeFSM(name:String):Void 
	{	if (fsm.currentModuleName == 'dead')
			return;
		if (name != 'wait')
			lastState = name;
		super.changeFSM(name);
	}
}