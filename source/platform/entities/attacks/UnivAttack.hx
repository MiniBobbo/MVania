package platform.entities.attacks;

import platform.entities.Attack;

/**
 * ...
 * @author Dave
 */
class UnivAttack extends Attack 
{
	private var onUpdate:Attack->Float->Void;
	private var onInit:Attack->Void;
	private var onComplete:Attack->Void;
	
	public function new(lifespan:Float=3) 
	{
		super(lifespan);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (onUpdate != null) {
			onUpdate(this, elapsed);
		}
		 
	}
	
}