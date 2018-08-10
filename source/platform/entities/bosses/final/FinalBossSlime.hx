package platform.entities.bosses.final;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import platform.H;
import platform.entities.Attack.AttackTypes;
import platform.entities.attacks.UnivAttack;
import platform.entities.bosses.Piece;
import platform.entities.enemies.Bouncer;
import sound.AllSounds;
import sound.Sounds;


/**
 * ...
 * @author Dave
 */
class FinalBossSlime extends Piece
{

	var bouncers:FlxTypedGroup<Bouncer>;
	var MAX_BOUNCERS:Int = 5;
	
	public function new(collisionMap:FlxTilemap)
	{
		super(collisionMap);
		frames = H.getFrames();
		animation.addByPrefix('s', 'finalbossslime', 1, false);
		animation.play('s');
		setSize(70, 50);
		centerOffsets();
		bossOffset.set(60,420);

		bouncers = new FlxTypedGroup<Bouncer>();
		for (i in 0...MAX_BOUNCERS) {
			var b = new Bouncer(collisionMap);
			b.kill();
			bouncers.add(b);
		}
		
	}
	
	override public function signal(signal:String, ?data:Dynamic) 
	{
		switch (signal) 
		{
			case 'spawn':
				trace('Trying to spawn bouncer');
				if (bouncers.countLiving() >= MAX_BOUNCERS)
					return;
				var b = bouncers.getFirstAvailable();
				b.newDirection();
				var center = getGraphicMidpoint();
				b.reset(center.x, center.y);
		case 'hit':
				var a:UnivAttack = cast data;
				if (a.type == AttackTypes.FIRE) {
					FlxSpriteUtil.flicker(this, .2);
					H.signalAll('down');
					Sounds.play(AllSounds.HIT);
					
				} else {
					Sounds.play(AllSounds.IMMUNE);
				}
								
			default:
				
		}
		
	}
	

}