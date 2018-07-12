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
	//Should this piece follow another?
	private var connectedTo:Piece;
	
	public function new(collisionMap:FlxTilemap) 
	{
		super(collisionMap);
		bossOffset = new FlxPoint();
		
	}
	
	public function setParent(b:Boss) {
		parent = b;
	}
	
	/**
	 * Connect this piece to another piece.  This piece's location will be calculated from the piece's location instead of the bosses.
	 * Normally at the top of the tree eventually a piece would attach to the boss.
	 * @param	p	
	 */
	public function connectToPiece(p:Piece) {
		connectedTo = p;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (parent == null)  {
			throw 'No parent for this piece.  This is probably an error';
		}
		
		//If there is no connected to piece, follow the boss.
		if(connectedTo == null)
			this.setPosition(parent.pos.x + bossOffset.x, parent.pos.y + bossOffset.y);
		else
			setPosition(connectedTo.x + bossOffset.x, connectedTo.y + bossOffset.y);
	}
	
}