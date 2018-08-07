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
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_data_font_tektrreg_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end
		
		var data, manifest, library;
		
		Assets.libraryPaths["default"] = rootPath + "manifest/default.json";
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_font_tektrreg_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_1_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_10_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_11_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_12_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_13_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_14_tmx extends null { }
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
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___backup_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___junction_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___lower_deck_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___space_bridge_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_control___computer_room_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___column_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___compactor_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___crew_quarters_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___engine_room_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___freight_elevator_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___hallway_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___junction_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___long_term_storage_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___machine_shop_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___officer_quarters_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___save_room_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___short_term_storage_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___systems_access_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___terraforming_access_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_engineering___thruster_control_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___aft_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___airlock_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___boost_room_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___command_access_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___generator_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___maintenance_access_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___maintenance_tunnel_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___maintenance_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___space_dock_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___storage_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support___the_grid_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support_column_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_life_support_computer_room_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_minimap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_minimap_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_outdoors_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_pod_bay_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_save_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_save1_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_save2_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_shiptileset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_shiptileset_tsx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_t_junction_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming___caverns_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming___deepmaw_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming___depths_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming___great_tree_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming___high_falls_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming___outdoors_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming___shadowed_glade_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming___the_maw_entrance_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming___the_maw_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_terraforming_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_temple2_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_templemgsheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_cavernbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_console_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_controlbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_forestbg1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_forestbg_layer_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_forestbg_layer_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_forestbg_layer_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_forestbg_layer_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_guts_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_main_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_main_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_mapareas_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_maprooms_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_meteor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_outsidebg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_pods_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sanitybar_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sanitybar_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_ship_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_starfield_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_starfield_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,4,1/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}

@:keep #if display private #end class __ASSET__assets_data_font_tektrreg_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/data/font/TektrReg.ttf"; name = "Tektrron-Regular"; super (); }}


#else

@:keep @:expose('__ASSET__assets_data_font_tektrreg_ttf') #if display private #end class __ASSET__assets_data_font_tektrreg_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/data/font/TektrReg.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Tektrron-Regular"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

@:keep @:expose('__ASSET__OPENFL__assets_data_font_tektrreg_ttf') #if display private #end class __ASSET__OPENFL__assets_data_font_tektrreg_ttf extends openfl.text.Font { public function new () { #if !html5 __fontPath = #if (ios || tvos) "assets/" + #end "assets/data/font/TektrReg.ttf"; #end name = "Tektrron-Regular"; super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}


#end
#end