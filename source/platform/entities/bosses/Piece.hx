package platform.entities.bosses;

import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import platform.entities.gameentites.Enemy;

/**
 * ...
 * @author Dave
 */
class Piece extends Enemy 
{
	
	public var bossOffset:FlxPoint;
	private var parent:Boss;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		bossOffset = new FlxPoint();
		
	}
	
	public function setParent(b:Boss) {
		parent = b;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (parent == null)  {
			throw 'No parent for this piece.  This is probably an error';
		}
		
		this.setPosition(parent.pos.x + bossOffset.x, parent.pos.y + bossOffset.y);
		
	}
	
}