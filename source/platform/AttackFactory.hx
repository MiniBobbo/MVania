package platform;
import flixel.FlxG;
import flixel.math.FlxPoint;
import haxe.Constraints.Function;
import lime.text.unifill.Exception.InvalidCodeUnitSequence;
import platform.entities.Attack;
import platform.entities.attacks.UnivAttack;

/**
 * ...
 * @author Dave
 */
class AttackFactory 
{
	static var FIRE_UPWARDS_VELOCITY:Float = 150;
	static var ELECTRIC_SPREAD:Float = 40;
	
	
	public static function configAttack(a:UnivAttack, type:AttackTypes) {
		a.setUpdateFunction(null);
		a.setInitFunction(null);
		a.type = type;
		switch (type) 
		{
			case AttackTypes.LARGESHOT:
				a.acceleration.set();
				a.setSize(20, 32);
				a.centerOffsets();
				a.offset.x = 6;
				a.fireAnim = 'largeshot';
				a.endAnim = 'largeshot';
				a.setUpdateFunction(AngleTowardsVelocity);
				//a.setCompleteFunction(stopMoving);
				a.setHitMapFunction(function(a) {return; });
				
			case AttackTypes.SHOT:
				a.acceleration.set();
				a.setSize(10, 10);
				a.centerOffsets();
				a.fireAnim = 'shot';
				a.endAnim = 'end';
				a.setUpdateFunction(AngleTowardsVelocity);
				a.setCompleteFunction(stopMoving);
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
			case AttackTypes.ELECTRIC:
				a.acceleration.set();
				a.fireAnim = 'elecshot';
				a.endAnim = 'elecshotend';
				//a.setUpdateFunction(AngleTowardsVelocity);
				a.setInitFunction(function(a:UnivAttack) {
					a.animation.play(a.fireAnim);
					a.velocity.y += FlxG.random.float(-ELECTRIC_SPREAD, ELECTRIC_SPREAD);
					
				});
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