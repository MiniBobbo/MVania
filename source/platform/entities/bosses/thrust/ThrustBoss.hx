package platform.entities.bosses.thrust;

import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import platform.entities.bosses.Boss;
import platform.entities.bosses.quash.SquashTurret;

/**
 * ...
 * @author Dave
 */
class ThrustBoss extends Boss 
{
	
	var body:ThrustBody;
	
	var testTimer:FlxTimer;
	
	var turret:SquashTurret;
	public function new(map:FlxTilemap) 
	{
		super();
		TotalHP = 10;
		
		testTimer = new FlxTimer();
		body = new ThrustBody(map);
		addPiece(body);
		
		testTimer.start(2, function(_) {
			H.signalAll('fire', 5); 
			
		}, 0);
		
		turret = new SquashTurret(map);
		turret.setCode(7);
		turret.connectToPiece(body);
		addPiece(turret);
		
		var weak = new ThrustWeak(map);
		weak.connectToPiece(body);
		addPiece(weak);
		weak.bossOffset.set(-10,48);
		
	}
	
	override public function takeDamage(damage:Float) 
	{
		super.takeDamage(damage);
				FlxSpriteUtil.flicker(body, .3);

	}
	
	override public function killAll() 
	{
		super.killAll();
		H.setFlag(1,true);
		testTimer.cancel();
	}
	
	
	
}