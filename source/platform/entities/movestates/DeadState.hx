package platform.entities.movestates;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import fsm.FSMModule;
import fsm.IFSM;
import shaders.PixelShader;
import sound.AllSounds;
import sound.Sounds;

/**
 * ...
 * @author Dave
 */
class DeadState extends FSMModule 
{
	var p:FlxSprite;
	var s:PixelShader;
	var pixelValue:Float;
	
	var DEATH_TIME:Float = .5;
	
	public function new(parent:IFSM) 
	{
		super(parent);
		try{
			
			p = cast parent;
		} catch (err:Dynamic)
		{
			trace('Trying to connect a DeadState to something that isn\'t an FlxSprite');
		}
		
		s = new PixelShader();
		pixelValue = .000001;
		s.uPixels.value = [pixelValue];
		p.shader = s;
	}

	override public function changeTo() 
	{
		Sounds.play(AllSounds.DEAD);
		p.velocity.set();
		FlxTween.tween(this, {pixelValue:20.0}, DEATH_TIME);
		FlxTween.tween(p, {alpha:0}, DEATH_TIME);
		new FlxTimer().start(DEATH_TIME, function(_) {p.kill(); } );

	}
	
	override public function update(dt:Float) 
	{
		s.uPixels.value = [pixelValue];
	}
}