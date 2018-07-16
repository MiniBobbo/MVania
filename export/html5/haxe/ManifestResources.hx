package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR0y30:assets%2Fdata%2Flevels%2F1.tmxR2i3469R3R4R5R7R6tgoR0y31:assets%2Fdata%2Flevels%2F10.tmxR2i3740R3R4R5R8R6tgoR0y31:assets%2Fdata%2Flevels%2F11.tmxR2i3693R3R4R5R9R6tgoR0y31:assets%2Fdata%2Flevels%2F12.tmxR2i3799R3R4R5R10R6tgoR0y31:assets%2Fdata%2Flevels%2F13.tmxR2i4832R3R4R5R11R6tgoR0y30:assets%2Fdata%2Flevels%2F2.tmxR2i8221R3R4R5R12R6tgoR0y30:assets%2Fdata%2Flevels%2F3.tmxR2i3663R3R4R5R13R6tgoR0y37:assets%2Fdata%2Flevels%2F32blocks.pngR2i1846R3y5:IMAGER5R14R6tgoR0y30:assets%2Fdata%2Flevels%2F4.tmxR2i3681R3R4R5R16R6tgoR0y30:assets%2Fdata%2Flevels%2F5.tmxR2i3838R3R4R5R17R6tgoR0y30:assets%2Fdata%2Flevels%2F6.tmxR2i5301R3R4R5R18R6tgoR0y30:assets%2Fdata%2Flevels%2F7.tmxR2i3717R3R4R5R19R6tgoR0y30:assets%2Fdata%2Flevels%2F8.tmxR2i3591R3R4R5R20R6tgoR0y30:assets%2Fdata%2Flevels%2F9.tmxR2i4118R3R4R5R21R6tgoR0y42:assets%2Fdata%2Flevels%2FCombinedTiles.pngR2i7873R3R15R5R22R6tgoR0y33:assets%2Fdata%2Flevels%2Fsave.tmxR2i3053R3R4R5R23R6tgoR0y40:assets%2Fdata%2Flevels%2FshipTileset.pngR2i8760R3R15R5R24R6tgoR0y40:assets%2Fdata%2Flevels%2Fshiptileset.tsxR2i201R3R4R5R25R6tgoR0y27:assets%2Fdata%2Ftemple2.tmxR2i81251R3R4R5R26R6tgoR0y33:assets%2Fdata%2Ftemplemgsheet.pngR2i21804R3R15R5R27R6tgoR0y27:assets%2Fimages%2Fmain.jsonR2i64409R3R4R5R28R6tgoR0y26:assets%2Fimages%2Fmain.pngR2i35546R3R15R5R29R6tgoR0y31:assets%2Fimages%2Foutsidebg.pngR2i3631R3R15R5R30R6tgoR0y26:assets%2Fimages%2Fpods.pngR2i271R3R15R5R31R6tgoR0y33:assets%2Fimages%2FSanityBar_0.pngR2i184R3R15R5R32R6tgoR0y33:assets%2Fimages%2FSanityBar_1.pngR2i135R3R15R5R33R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R34R6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R35R6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3y9:pathGroupaR37y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R36R5y28:flixel%2Fsounds%2Fflixel.mp3R38aR40y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3y5:SOUNDR5R39R38aR37R39hgoR2i33629R3R42R5R41R38aR40R41hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R43R44y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R15R5R49R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R15R5R50R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_1_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_10_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_11_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_12_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_13_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_2_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_3_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_32blocks_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_4_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_5_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_6_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_7_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_8_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_9_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_combinedtiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_save_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_shiptileset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_shiptileset_tsx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_temple2_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_templemgsheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_main_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_main_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_outsidebg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_pods_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sanitybar_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sanitybar_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/data-goes-here.txt") #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/1.tmx") #if display private #end class __ASSET__assets_data_levels_1_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/10.tmx") #if display private #end class __ASSET__assets_data_levels_10_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/11.tmx") #if display private #end class __ASSET__assets_data_levels_11_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/12.tmx") #if display private #end class __ASSET__assets_data_levels_12_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/13.tmx") #if display private #end class __ASSET__assets_data_levels_13_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/2.tmx") #if display private #end class __ASSET__assets_data_levels_2_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/3.tmx") #if display private #end class __ASSET__assets_data_levels_3_tmx extends haxe.io.Bytes {}
@:keep @:image("assets/data/levels/32blocks.png") #if display private #end class __ASSET__assets_data_levels_32blocks_png extends lime.graphics.Image {}
@:keep @:file("assets/data/levels/4.tmx") #if display private #end class __ASSET__assets_data_levels_4_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/5.tmx") #if display private #end class __ASSET__assets_data_levels_5_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/6.tmx") #if display private #end class __ASSET__assets_data_levels_6_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/7.tmx") #if display private #end class __ASSET__assets_data_levels_7_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/8.tmx") #if display private #end class __ASSET__assets_data_levels_8_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/9.tmx") #if display private #end class __ASSET__assets_data_levels_9_tmx extends haxe.io.Bytes {}
@:keep @:image("assets/data/levels/CombinedTiles.png") #if display private #end class __ASSET__assets_data_levels_combinedtiles_png extends lime.graphics.Image {}
@:keep @:file("assets/data/levels/save.tmx") #if display private #end class __ASSET__assets_data_levels_save_tmx extends haxe.io.Bytes {}
@:keep @:image("assets/data/levels/shipTileset.png") #if display private #end class __ASSET__assets_data_levels_shiptileset_png extends lime.graphics.Image {}
@:keep @:file("assets/data/levels/shiptileset.tsx") #if display private #end class __ASSET__assets_data_levels_shiptileset_tsx extends haxe.io.Bytes {}
@:keep @:file("assets/data/temple2.tmx") #if display private #end class __ASSET__assets_data_temple2_tmx extends haxe.io.Bytes {}
@:keep @:image("assets/data/templemgsheet.png") #if display private #end class __ASSET__assets_data_templemgsheet_png extends lime.graphics.Image {}
@:keep @:file("assets/images/main.json") #if display private #end class __ASSET__assets_images_main_json extends haxe.io.Bytes {}
@:keep @:image("assets/images/main.png") #if display private #end class __ASSET__assets_images_main_png extends lime.graphics.Image {}
@:keep @:image("assets/images/outsidebg.png") #if display private #end class __ASSET__assets_images_outsidebg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/pods.png") #if display private #end class __ASSET__assets_images_pods_png extends lime.graphics.Image {}
@:keep @:image("assets/images/SanityBar_0.png") #if display private #end class __ASSET__assets_images_sanitybar_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/SanityBar_1.png") #if display private #end class __ASSET__assets_images_sanitybar_1_png extends lime.graphics.Image {}
@:keep @:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}


#end
#end