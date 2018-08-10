package platform.entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import sound.AllSounds;
import sound.Sounds;


enum EffectTypes {
	EXPLODE;
}
/**
 * ...
 * @author Dave
 */
class EffectSprite extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super();
		frames = H.getFrames();
		animation.addByPrefix('explode', 'effects_explode_', 12, false);
		animation.play('explode'); 
		setSize(1, 1);
		centerOffsets();
	}
	
	
	public function init(loc:FlxPoint, type:EffectTypes) {
		reset(loc.x, loc.y);
		switch (type) 
		{
			case EffectTypes.EXPLODE:
				animation.play('explode');
				Sounds.play(AllSounds.EXPLODE);
			default:
				
		}
		
	}
	
	
}