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
		a.flipX = false;
		a.flipY = false;
		a.type = type;
		switch (type) 
		{
			case AttackTypes.SPORE:
				a.acceleration.set(0, 200);
				a.setSize(15, 15);
				a.centerOffsets();
				a.fireAnim = 'spore';
				a.endAnim = 'sporeend';
				var colors = ['blue', 'green', 'red'];
				var c = colors[FlxG.random.int(0, colors.length - 1)];
				a.animation.addByPrefix('spore', 'Attacks_spore_' + c, 1, false);
				a.setCompleteFunction(stopMoving);
				a.setUpdateFunction(floatDown);
			
			case AttackTypes.SHOCKWAVE:
				a.acceleration.set();
				a.setSize(15, 26);
				a.centerOffsets();
				a.offset.y  = 7;
				a.offset.x = 6;
				a.fireAnim = 'shockwave';
				a.endAnim = 'shockwaveend';
				a.setCompleteFunction(stopMoving);

			
			case AttackTypes.LARGESHOT:
				a.acceleration.set();
				a.setSize(16, 16);
				a.offset.set(8,8);
				a.centerOffsets();
				a.offset.y  = 2;
				a.offset.x = 6;
				a.fireAnim = 'largeshot';
				a.endAnim = 'largeshot';
				a.setUpdateFunction(AngleTowardsVelocity);
				//a.setCompleteFunction(stopMoving);
				a.setHitMapFunction(function(a) {return; });
				a.collideMap = false;
				
			case AttackTypes.SHOT:
				a.acceleration.set();
				a.setSize(10, 10);
				a.centerOffsets();
				a.fireAnim = 'shot';
				a.endAnim = 'end';
				a.setUpdateFunction(AngleTowardsVelocity);
				a.setCompleteFunction(stopMoving);
				a.collideMap = true;
			case AttackTypes.FIRE:
				a.acceleration.set(0, H.GRAVITY);
				a.setSize(10, 10);
				a.centerOffsets();
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
				a.collideMap = true;
			case AttackTypes.ACID:
				a.setSize(20, 20);
				a.centerOffsets();
				a.velocity.y += 0;
				a.fireAnim = 'acid';
				a.endAnim = 'acidend';
				a.setUpdateFunction(AngleTowardsVelocity);
				a.setInitFunction(function(a:UnivAttack) {
					a.animation.play(a.fireAnim); 
					//a.velocity.y += -FIRE_UPWARDS_VELOCITY;
					a.acceleration.set(0,H.GRAVITY/3);
					
				} );
				a.setCompleteFunction(stopMoving);
				a.collideMap = true;
				
				
			case AttackTypes.ELECTRIC:
				a.acceleration.set();
				a.fireAnim = 'elecshot';
				a.endAnim = 'elecshotend';
				a.setSize(10, 10);
				a.centerOffsets();

				//a.setUpdateFunction(AngleTowardsVelocity);
				a.setInitFunction(function(a:UnivAttack) {
					a.animation.play(a.fireAnim);
					a.velocity.y += FlxG.random.float(-ELECTRIC_SPREAD, ELECTRIC_SPREAD);
					
				});
				a.setCompleteFunction(stopMoving);
				a.collideMap = true;
			default:
				
		}
	}
	
	public static function AngleTowardsVelocity(a:UnivAttack, elapsed:Float):Void {
		a.angle = FlxPoint.weak().angleBetween(a.velocity);
	}

	public static function floatDown(a:UnivAttack, elapsed:Float):Void {
		if (a.velocity.y > 0) {
			a.acceleration.y = H.GRAVITY / 6;
			a.velocity.x = 0;
		}
			
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