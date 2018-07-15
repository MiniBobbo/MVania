package platform.entities.bosses;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import fsm.FSM;
import fsm.IFSM;
import platform.entities.bosses.quash.SquashTurret;
import platform.entities.gameentites.Enemy;

/**
 * A boss object is really just a collection of individual pieces that can be hit or targeted separately.  It doesn't have to be a boss, per se.
 * @author Dave
 */
class Boss extends FlxTypedGroup<Piece> implements IFSM
{
	public var TotalHP:Float;
	
	public var pos:FlxPoint;
	
	public var fsm:FSM;
	
	public function new() 
	{
		super();
		pos = FlxPoint.get();
		fsm = new FSM(this);
	}
	
	public function changeFSM(name:String):Void {
		fsm.changeState(name);
	}
	/**
	 * To defeat the boss the boss HP must be reduced to 0 or below, not the individual pieces.  This function applies to the Boss HP.
	 * @param	damage		How much damage to apply to the boss HP.
	 */
	public function takeDamage(damage:Float) {
		TotalHP -= Std.int(damage);
		if (TotalHP <= 0) {
			
			killAll();
		}
		

	}
	
	
	
	public function killAll() {
		fsm.hold();
		fsm.changeState('none');
		for (m in members) {
			m.changeFSM('dead');
		}
	}
	
	public function setPositon(x:Float, y:Float) {
		pos.x = x;
		pos.y = y;
	}
	
	public function addPiece(piece:Piece) {
		add(piece);
		piece.setParent(this);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (fsm.currentModule != null)
			fsm.currentModule.update(elapsed);
	}
}