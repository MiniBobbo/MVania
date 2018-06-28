package platform;
import flixel.math.FlxPoint;
import platform.entities.Attack;
import platform.entities.attacks.UnivAttack;

/**
 * ...
 * @author Dave
 */
class AttackFactory 
{
	static var FIRE_UPWARDS_VELOCITY:Float = 150;
	static var ELECTRIC_SPREAD:Float = 30;
	
	
	public static function configAttack(a:UnivAttack, type:AttackTypes) {
		a.setUpdateFunction(null);
		a.setInitFunction(null);
		switch (type) 
		{
			case AttackTypes.SHOT:
				a.acceleration.set();
				a.fireAnim = 'shot';
				a.endAnim = 'end';
				a.setUpdateFunction(AngleTowardsVelocity);
			case AttackTypes.FIRE:
				a.acceleration.set(0, H.GRAVITY);
				a.velocity.y += -FIRE_UPWARDS_VELOCITY;
				a.fireAnim = 'fireshot';
				a.endAnim = 'fireshotend';
				a.setUpdateFunction(AngleTowardsVelocity);
				a.setInitFunction(function(a:UnivAttack) {
					a.animation.play(a.fireAnim); 
					a.velocity.y += -FIRE_UPWARDS_VELOCITY;
					a.acceleration.set(0,H.GRAVITY/3);
					
				} );
				
				a.setCompleteFunction(stopMoving);
			default:
				
		}
	}
	
	public static function AngleTowardsVelocity(a:UnivAttack, elased:Float):Void {
		a.angle = FlxPoint.weak().angleBetween(a.velocity);
	}
	
	public static function stopMoving(a:UnivAttack):Void {
		a.animation.play(a.endAnim);
		a.velocity.set();
		a.acceleration.set();
	}
	
	public static function printTest(a:UnivAttack):Void {
		trace('Called from a universal attack init');
	}
	
}