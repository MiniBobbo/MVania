package platform.entities.bosses;

import flixel.group.FlxSpriteGroup;

/**
 * A boss object is really just a collection of individual pieces that can be hit or targeted separately.  It doesn't have to be a boss, per se.
 * @author Dave
 */
class Boss extends FlxSpriteGroup 
{
	public var TotalHP:Float;
	
	public function new() 
	{
		
	}
	
	/**
	 * To defeat the boss the boss HP must be reduced to 0 or below, not the individual pieces.  This function applies to the Boss HP.
	 * @param	damage		How much damage to apply to the boss HP.
	 */
	public function takeDamage(damage:Float) {
		
	}
	
	public function killAll() {
		for (m in members) {
			m.kill();
		}
	}
}