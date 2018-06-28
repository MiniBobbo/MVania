package platform;
import flixel.math.FlxPoint;
import platform.entities.Attack;

/**
 * ...
 * @author Dave
 */
class AttackFactory 
{
	public static function configAttack(a:Attack, type:AttackTypes) {
		
	}
	
	public function AngleTowardsVelocity(a:Attack):Void {
		a.angle = FlxPoint.weak().angleBetween(a.velocity);
	}
	
}