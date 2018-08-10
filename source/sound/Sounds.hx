package sound;
import flixel.FlxG;
import platform.H;
import sound.AllSounds;


/**
 * ...
 * @author Dave
 */
class Sounds 
{

	public static function play(sound:AllSounds) {
		switch (sound) 
		{
			case AllSounds.HIT:
				FlxG.sound.play('assets/sounds/hit.wav', H.SOUND_MULT);
			case AllSounds.IMMUNE:
				FlxG.sound.play('assets/sounds/immune.wav', H.SOUND_MULT);
			case AllSounds.EXPLODE:
				FlxG.sound.play('assets/sounds/explode.wav', H.SOUND_MULT);
			case AllSounds.SHOT:
				FlxG.sound.play('assets/sounds/shot.wav', H.SOUND_MULT);
			case AllSounds.ELECTRIC:
				FlxG.sound.play('assets/sounds/electric.wav', H.SOUND_MULT);
			case AllSounds.SHOCKWAVE:
				FlxG.sound.play('assets/sounds/shockwave.wav', H.SOUND_MULT);
			case AllSounds.LAND:
				FlxG.sound.play('assets/sounds/player_land.wav', H.SOUND_MULT);
			case AllSounds.EXPLODE_LONG:
				FlxG.sound.play('assets/sounds/explodelong.wav', H.SOUND_MULT);
			case AllSounds.JUMP:
				FlxG.sound.play('assets/sounds/jump.wav', H.SOUND_MULT);
			case AllSounds.BOOST:
				FlxG.sound.play('assets/sounds/boost.wav', H.SOUND_MULT);
			case AllSounds.DEAD:
				FlxG.sound.play('assets/sounds/dead.wav', H.SOUND_MULT);
			case AllSounds.FIRE:
				FlxG.sound.play('assets/sounds/shot.wav', H.SOUND_MULT);
			case AllSounds.POUND:
				FlxG.sound.play('assets/sounds/pound.wav', H.SOUND_MULT);
			case AllSounds.AIRBLADE:
				FlxG.sound.play('assets/sounds/airblade.wav', H.SOUND_MULT);

			default:
				
		}
	}
	
}