package platform.entities.bosses.final;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import platform.H;
import platform.entities.bosses.Boss;
import platform.entities.bosses.Piece;
import platform.entities.bosses.quash.Body;
import sound.AllSounds;
import sound.Sounds;
import states.EndGameState;

/**
 * ...
 * @author Dave
 */
class FinalBoss extends Boss 
{

	var body:MainComputer;
	var shield:FinalShield;
	var meteor:FinalMeteor;
	var slime:FinalBossSlime;
	
	public function new(map:FlxTilemap) {
		super();
		TotalHP = 20;
		body = new MainComputer(map);
		addPiece(body);
		meteor = new FinalMeteor(map);
		addPiece(meteor);
		
		shield = new FinalShield(map);
		addPiece(shield);
		
		slime = new FinalBossSlime(map);
		addPiece(slime);
		
		fsm.addtoMap('main', new FinalBossFSM(this));
		fsm.changeState('main');
	}
	
	override public function takeDamage(damage:Float) {
		TotalHP -= Std.int(damage);
		if (TotalHP <= 0) {
			Sounds.play(AllSounds.EXPLODE_LONG);
			var s = new FlxSprite();
			s.scrollFactor.set();
			s.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
			H.ps.add(s);
			new FlxTimer().start(3, function(_) {FlxG.switchState(new EndGameState()); });
		}
		

	}
	
}