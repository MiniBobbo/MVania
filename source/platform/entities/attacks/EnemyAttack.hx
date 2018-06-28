package platform.entities.attacks;

import platform.entities.Attack;

enum AttackType {
	SHOT;
}

/**
 * ...
 * @author Dave
 */
class EnemyAttack extends Attack 
{

	public function new(lifespan:Float=3) 
	{
		super(lifespan);
		
	}
	
	
}