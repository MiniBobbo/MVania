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
		
		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR2i27496R3y4:FONTy9:classNamey38:__ASSET__assets_data_font_tektrreg_ttfR5y35:assets%2Fdata%2Ffont%2FTektrReg.ttfR6tgoR0y30:assets%2Fdata%2Flevels%2F1.tmxR2i3469R3R4R5R11R6tgoR0y31:assets%2Fdata%2Flevels%2F10.tmxR2i3740R3R4R5R12R6tgoR0y31:assets%2Fdata%2Flevels%2F11.tmxR2i3693R3R4R5R13R6tgoR0y31:assets%2Fdata%2Flevels%2F12.tmxR2i3838R3R4R5R14R6tgoR0y31:assets%2Fdata%2Flevels%2F13.tmxR2i4747R3R4R5R15R6tgoR0y31:assets%2Fdata%2Flevels%2F14.tmxR2i3550R3R4R5R16R6tgoR0y30:assets%2Fdata%2Flevels%2F2.tmxR2i10628R3R4R5R17R6tgoR0y30:assets%2Fdata%2Flevels%2F3.tmxR2i3663R3R4R5R18R6tgoR0y37:assets%2Fdata%2Flevels%2F32blocks.pngR2i1846R3y5:IMAGER5R19R6tgoR0y30:assets%2Fdata%2Flevels%2F4.tmxR2i3681R3R4R5R21R6tgoR0y30:assets%2Fdata%2Flevels%2F5.tmxR2i3838R3R4R5R22R6tgoR0y30:assets%2Fdata%2Flevels%2F6.tmxR2i5301R3R4R5R23R6tgoR0y30:assets%2Fdata%2Flevels%2F7.tmxR2i3717R3R4R5R24R6tgoR0y30:assets%2Fdata%2Flevels%2F8.tmxR2i3591R3R4R5R25R6tgoR0y30:assets%2Fdata%2Flevels%2F9.tmxR2i4118R3R4R5R26R6tgoR0y42:assets%2Fdata%2Flevels%2FCombinedTiles.pngR2i7873R3R20R5R27R6tgoR0y58:assets%2Fdata%2Flevels%2FControl%20-%20Computer%20Room.tmxR2i11466R3R4R5R28R6tgoR0y53:assets%2Fdata%2Flevels%2FEngineering%20-%20Column.tmxR2i7853R3R4R5R29R6tgoR0y56:assets%2Fdata%2Flevels%2FEngineering%20-%20Compactor.tmxR2i9781R3R4R5R30R6tgoR0y62:assets%2Fdata%2Flevels%2FEngineering%20-%20Crew%20Quarters.tmxR2i14644R3R4R5R31R6tgoR0y60:assets%2Fdata%2Flevels%2FEngineering%20-%20Engine%20Room.tmxR2i16012R3R4R5R32R6tgoR0y65:assets%2Fdata%2Flevels%2FEngineering%20-%20Freight%20Elevator.tmxR2i9180R3R4R5R33R6tgoR0y54:assets%2Fdata%2Flevels%2FEngineering%20-%20Hallway.tmxR2i9755R3R4R5R34R6tgoR0y55:assets%2Fdata%2Flevels%2FEngineering%20-%20Junction.tmxR2i10161R3R4R5R35R6tgoR0y68:assets%2Fdata%2Flevels%2FEngineering%20-%20Long%20Term%20Storage.tmxR2i8877R3R4R5R36R6tgoR0y61:assets%2Fdata%2Flevels%2FEngineering%20-%20Machine%20Shop.tmxR2i17005R3R4R5R37R6tgoR0y65:assets%2Fdata%2Flevels%2FEngineering%20-%20Officer%20Quarters.tmxR2i8549R3R4R5R38R6tgoR0y58:assets%2Fdata%2Flevels%2FEngineering%20-%20Save%20Room.tmxR2i3804R3R4R5R39R6tgoR0y69:assets%2Fdata%2Flevels%2FEngineering%20-%20Short%20Term%20Storage.tmxR2i6841R3R4R5R40R6tgoR0y63:assets%2Fdata%2Flevels%2FEngineering%20-%20Systems%20Access.tmxR2i10108R3R4R5R41R6tgoR0y68:assets%2Fdata%2Flevels%2FEngineering%20-%20Terraforming%20Access.tmxR2i5844R3R4R5R42R6tgoR0y65:assets%2Fdata%2Flevels%2FEngineering%20-%20Thruster%20Control.tmxR2i16779R3R4R5R43R6tgoR0y53:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Aft.tmxR2i21337R3R4R5R44R6tgoR0y57:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Airlock.tmxR2i4536R3R4R5R45R6tgoR0y62:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Boost%20Room.tmxR2i2829R3R4R5R46R6tgoR0y59:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Generator.tmxR2i9632R3R4R5R47R6tgoR0y70:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Maintenance%20Access.tmxR2i15778R3R4R5R48R6tgoR0y70:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Maintenance%20Tunnel.tmxR2i11942R3R4R5R49R6tgoR0y61:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Maintenance.tmxR2i6154R3R4R5R50R6tgoR0y62:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Space%20Dock.tmxR2i3512R3R4R5R51R6tgoR0y57:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Storage.tmxR2i14760R3R4R5R52R6tgoR0y60:assets%2Fdata%2Flevels%2FLife%20Support%20-%20The%20Grid.tmxR2i10611R3R4R5R53R6tgoR0y52:assets%2Fdata%2Flevels%2FLife%20Support%20Column.tmxR2i13443R3R4R5R54R6tgoR0y61:assets%2Fdata%2Flevels%2FLife%20Support%20Computer%20Room.tmxR2i2847R3R4R5R55R6tgoR0y36:assets%2Fdata%2Flevels%2Fminimap.pngR2i743R3R20R5R56R6tgoR0y36:assets%2Fdata%2Flevels%2Fminimap.tmxR2i2118R3R4R5R57R6tgoR0y37:assets%2Fdata%2Flevels%2FOutdoors.tmxR2i15826R3R4R5R58R6tgoR0y38:assets%2Fdata%2Flevels%2FPod%20Bay.tmxR2i13454R3R4R5R59R6tgoR0y33:assets%2Fdata%2Flevels%2Fsave.tmxR2i3056R3R4R5R60R6tgoR0y34:assets%2Fdata%2Flevels%2Fsave1.tmxR2i3056R3R4R5R61R6tgoR0y34:assets%2Fdata%2Flevels%2Fsave2.tmxR2i3140R3R4R5R62R6tgoR0y40:assets%2Fdata%2Flevels%2FshipTileset.pngR2i31224R3R20R5R63R6tgoR0y40:assets%2Fdata%2Flevels%2Fshiptileset.tsxR2i201R3R4R5R64R6tgoR0y41:assets%2Fdata%2Flevels%2FT%20Junction.tmxR2i3092R3R4R5R65R6tgoR0y55:assets%2Fdata%2Flevels%2FTerraforming%20-%20Caverns.tmxR2i7285R3R4R5R66R6tgoR0y55:assets%2Fdata%2Flevels%2FTerraforming%20-%20Deepmaw.tmxR2i15101R3R4R5R67R6tgoR0y54:assets%2Fdata%2Flevels%2FTerraforming%20-%20Depths.tmxR2i8018R3R4R5R68R6tgoR0y60:assets%2Fdata%2Flevels%2FTerraforming%20-%20Great%20Tree.tmxR2i13637R3R4R5R69R6tgoR0y60:assets%2Fdata%2Flevels%2FTerraforming%20-%20High%20Falls.tmxR2i26178R3R4R5R70R6tgoR0y56:assets%2Fdata%2Flevels%2FTerraforming%20-%20Outdoors.tmxR2i20590R3R4R5R71R6tgoR0y64:assets%2Fdata%2Flevels%2FTerraforming%20-%20Shadowed%20Glade.tmxR2i23924R3R4R5R72R6tgoR0y68:assets%2Fdata%2Flevels%2FTerraforming%20-%20The%20Maw%20Entrance.tmxR2i8968R3R4R5R73R6tgoR0y57:assets%2Fdata%2Flevels%2FTerraforming%20-%20The%20Maw.tmxR2i14494R3R4R5R74R6tgoR0y41:assets%2Fdata%2Flevels%2FTerraforming.tmxR2i2917R3R4R5R75R6tgoR0y27:assets%2Fdata%2Ftemple2.tmxR2i81251R3R4R5R76R6tgoR0y33:assets%2Fdata%2Ftemplemgsheet.pngR2i21804R3R20R5R77R6tgoR0y30:assets%2Fimages%2Fcavernbg.pngR2i7894R3R20R5R78R6tgoR0y31:assets%2Fimages%2Fcontrolbg.pngR2i4453R3R20R5R79R6tgoR0y26:assets%2Fimages%2Fguts.pngR2i12371R3R20R5R80R6tgoR0y26:assets%2Fimages%2Flogo.pngR2i12899R3R20R5R81R6tgoR0y27:assets%2Fimages%2Fmain.jsonR2i109063R3R4R5R82R6tgoR0y26:assets%2Fimages%2Fmain.pngR2i75592R3R20R5R83R6tgoR0y31:assets%2Fimages%2Foutsidebg.pngR2i3631R3R20R5R84R6tgoR0y26:assets%2Fimages%2Fpods.pngR2i271R3R20R5R85R6tgoR0y33:assets%2Fimages%2FSanityBar_0.pngR2i184R3R20R5R86R6tgoR0y33:assets%2Fimages%2FSanityBar_1.pngR2i135R3R20R5R87R6tgoR0y26:assets%2Fimages%2Fship.pngR2i2162R3R20R5R88R6tgoR0y33:assets%2Fimages%2Fstarfield_0.pngR2i22145R3R20R5R89R6tgoR0y33:assets%2Fimages%2Fstarfield_1.pngR2i1255R3R20R5R90R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R91R6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R92R6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3y9:pathGroupaR94y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R93R5y28:flixel%2Fsounds%2Fflixel.mp3R95aR97y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3y5:SOUNDR5R96R95aR94R96hgoR2i33629R3R99R5R98R95aR97R98hgoR2i15744R3R7R8y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R7R8y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R20R5R104R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R20R5R105R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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
@:keep @:bind #if display private #end class __ASSET__assets_images_controlbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_guts_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_main_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_main_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_outsidebg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_pods_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sanitybar_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sanitybar_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_ship_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_starfield_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_starfield_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
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
@:keep @:font("export/html5/obj/webfont/TektrReg.ttf") #if display private #end class __ASSET__assets_data_font_tektrreg_ttf extends lime.text.Font {}
@:keep @:file("assets/data/levels/1.tmx") #if display private #end class __ASSET__assets_data_levels_1_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/10.tmx") #if display private #end class __ASSET__assets_data_levels_10_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/11.tmx") #if display private #end class __ASSET__assets_data_levels_11_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/12.tmx") #if display private #end class __ASSET__assets_data_levels_12_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/13.tmx") #if display private #end class __ASSET__assets_data_levels_13_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/14.tmx") #if display private #end class __ASSET__assets_data_levels_14_tmx extends haxe.io.Bytes {}
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
@:keep @:file("assets/data/levels/Control - Computer Room.tmx") #if display private #end class __ASSET__assets_data_levels_control___computer_room_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Column.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___column_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Compactor.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___compactor_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Crew Quarters.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___crew_quarters_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Engine Room.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___engine_room_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Freight Elevator.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___freight_elevator_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Hallway.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___hallway_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Junction.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___junction_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Long Term Storage.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___long_term_storage_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Machine Shop.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___machine_shop_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Officer Quarters.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___officer_quarters_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Save Room.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___save_room_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Short Term Storage.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___short_term_storage_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Systems Access.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___systems_access_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Terraforming Access.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___terraforming_access_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Engineering - Thruster Control.tmx") #if display private #end class __ASSET__assets_data_levels_engineering___thruster_control_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - Aft.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___aft_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - Airlock.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___airlock_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - Boost Room.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___boost_room_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - Generator.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___generator_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - Maintenance Access.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___maintenance_access_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - Maintenance Tunnel.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___maintenance_tunnel_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - Maintenance.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___maintenance_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - Space Dock.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___space_dock_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - Storage.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___storage_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support - The Grid.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___the_grid_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support Column.tmx") #if display private #end class __ASSET__assets_data_levels_life_support_column_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Life Support Computer Room.tmx") #if display private #end class __ASSET__assets_data_levels_life_support_computer_room_tmx extends haxe.io.Bytes {}
@:keep @:image("assets/data/levels/minimap.png") #if display private #end class __ASSET__assets_data_levels_minimap_png extends lime.graphics.Image {}
@:keep @:file("assets/data/levels/minimap.tmx") #if display private #end class __ASSET__assets_data_levels_minimap_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Outdoors.tmx") #if display private #end class __ASSET__assets_data_levels_outdoors_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Pod Bay.tmx") #if display private #end class __ASSET__assets_data_levels_pod_bay_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/save.tmx") #if display private #end class __ASSET__assets_data_levels_save_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/save1.tmx") #if display private #end class __ASSET__assets_data_levels_save1_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/save2.tmx") #if display private #end class __ASSET__assets_data_levels_save2_tmx extends haxe.io.Bytes {}
@:keep @:image("assets/data/levels/shipTileset.png") #if display private #end class __ASSET__assets_data_levels_shiptileset_png extends lime.graphics.Image {}
@:keep @:file("assets/data/levels/shiptileset.tsx") #if display private #end class __ASSET__assets_data_levels_shiptileset_tsx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/T Junction.tmx") #if display private #end class __ASSET__assets_data_levels_t_junction_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming - Caverns.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming___caverns_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming - Deepmaw.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming___deepmaw_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming - Depths.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming___depths_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming - Great Tree.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming___great_tree_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming - High Falls.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming___high_falls_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming - Outdoors.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming___outdoors_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming - Shadowed Glade.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming___shadowed_glade_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming - The Maw Entrance.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming___the_maw_entrance_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming - The Maw.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming___the_maw_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Terraforming.tmx") #if display private #end class __ASSET__assets_data_levels_terraforming_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/temple2.tmx") #if display private #end class __ASSET__assets_data_temple2_tmx extends haxe.io.Bytes {}
@:keep @:image("assets/data/templemgsheet.png") #if display private #end class __ASSET__assets_data_templemgsheet_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cavernbg.png") #if display private #end class __ASSET__assets_images_cavernbg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/controlbg.png") #if display private #end class __ASSET__assets_images_controlbg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/guts.png") #if display private #end class __ASSET__assets_images_guts_png extends lime.graphics.Image {}
@:keep @:image("assets/images/logo.png") #if display private #end class __ASSET__assets_images_logo_png extends lime.graphics.Image {}
@:keep @:file("assets/images/main.json") #if display private #end class __ASSET__assets_images_main_json extends haxe.io.Bytes {}
@:keep @:image("assets/images/main.png") #if display private #end class __ASSET__assets_images_main_png extends lime.graphics.Image {}
@:keep @:image("assets/images/outsidebg.png") #if display private #end class __ASSET__assets_images_outsidebg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/pods.png") #if display private #end class __ASSET__assets_images_pods_png extends lime.graphics.Image {}
@:keep @:image("assets/images/SanityBar_0.png") #if display private #end class __ASSET__assets_images_sanitybar_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/SanityBar_1.png") #if display private #end class __ASSET__assets_images_sanitybar_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ship.png") #if display private #end class __ASSET__assets_images_ship_png extends lime.graphics.Image {}
@:keep @:image("assets/images/starfield_0.png") #if display private #end class __ASSET__assets_images_starfield_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/starfield_1.png") #if display private #end class __ASSET__assets_images_starfield_1_png extends lime.graphics.Image {}
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

@:keep @:expose('__ASSET__assets_data_font_tektrreg_ttf') #if display private #end class __ASSET__assets_data_font_tektrreg_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/data/font/TektrReg"; #else ascender = 666; descender = -140; height = 866; numGlyphs = 238; underlinePosition = -100; underlineThickness = 100; unitsPerEM = 1000; #end name = "Tektrron-Regular"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

@:keep @:expose('__ASSET__OPENFL__assets_data_font_tektrreg_ttf') #if display private #end class __ASSET__OPENFL__assets_data_font_tektrreg_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_data_font_tektrreg_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}


#end
#end