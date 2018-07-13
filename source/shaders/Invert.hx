package shaders;
import flixel.system.FlxAssets.FlxShader;

class Invert extends FlxShader
{
    @:glFragmentSource('
        #pragma header

	uniform float uNum;
		
        void main()
        {
            vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
	gl_FragColor = vec4((1.0 *uNum - color.r) * color.a, (1.0 *uNum- color.g) * color.a, (1.0 * uNum- color.b) * color.a,   color.a);
        }'
    )

    public function new()
    {
        super();
    }
}