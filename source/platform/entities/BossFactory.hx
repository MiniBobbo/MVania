package platform.entities;
import flixel.tile.FlxTilemap;
import platform.entities.bosses.Boss;
import platform.entities.bosses.quash.Squasher;
import platform.entities.bosses.thrust.ThrustBoss;
import platform.entities.bosses.final.FinalBoss;
import tmxtools.TmxRect;

/**
 * ...
 * @author Dave
 */
class BossFactory 
{

	/**
	 * Creates an enemy and places it in the correct location and then returns it.
	 * @param	type	The type to create
	 * @param	rect	The rectangle to create it in.  really, just lines up the bottom
	 * @return	The new enemy.  Be sure to add it to the game.
	 */
	public static function createBoss(type:String, rect:TmxRect, map:FlxTilemap):Boss {
		var b:Boss = null;
		switch (type) 
		{
			case 'thrust':
				b = new ThrustBoss(map);
				H.rectToTile(rect);
				b.setPositon(rect.r.x, rect.r.y);
			case 'squasher':
				b = new Squasher(map);
				H.rectToTile(rect);
				b.setPositon(rect.r.x, rect.r.y);
			case 'finalboss':
				b = new FinalBoss(map);
				H.rectToTile(rect);
				b.setPositon(rect.r.x, rect.r.y);
			default:
				
		}
		
		return b;
	}
}