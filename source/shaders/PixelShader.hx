package shaders;
import flixel.system.FlxAssets.FlxShader;

/**
 * To use...
 * texSize - Send in the texture size (frameWidth, frameHeight)
 * pixels - the size of the pixel blocks.  So higher is a more pixeled image. You can tween this value from 0.0001 to a high number to pixelize something. 
 * 
 * @author 
 */
class PixelShader extends FlxShader
{
	 @:glFragmentSource('
        #pragma header
		
		uniform float uPixels;
		
		void main()
		{
			//Convert the normalized coordinate to a pixel coordinate.
			vec2 curCoord = vec2(openfl_TextureCoordv.x * openfl_TextureSize.x, openfl_TextureCoordv.y * openfl_TextureSize.y );
			//Sample the correct pixel for coloring
			vec2 newCoord = vec2(uPixels * floor(curCoord.x / uPixels) + (uPixels/2.0), uPixels * floor(curCoord.y / uPixels)+ (uPixels/2.0));
			
			//Convert back to a normalized coordinate for writing.
			newCoord.x = newCoord.x / openfl_TextureSize.x;
			newCoord.y = newCoord.y / openfl_TextureSize.y;
			
	gl_FragColor = flixel_texture2D(bitmap, newCoord);
		}
		
		')
		
	public function new() 
	{
		super();
		
	}
	
}