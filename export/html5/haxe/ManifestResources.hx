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
		
		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR2i27496R3y4:FONTy9:classNamey38:__ASSET__assets_data_font_tektrreg_ttfR5y35:assets%2Fdata%2Ffont%2FTektrReg.ttfR6tgoR0y30:assets%2Fdata%2Flevels%2F1.tmxR2i3469R3R4R5R11R6tgoR0y31:assets%2Fdata%2Flevels%2F10.tmxR2i3740R3R4R5R12R6tgoR0y31:assets%2Fdata%2Flevels%2F11.tmxR2i3693R3R4R5R13R6tgoR0y31:assets%2Fdata%2Flevels%2F12.tmxR2i3838R3R4R5R14R6tgoR0y31:assets%2Fdata%2Flevels%2F13.tmxR2i4747R3R4R5R15R6tgoR0y31:assets%2Fdata%2Flevels%2F14.tmxR2i3550R3R4R5R16R6tgoR0y30:assets%2Fdata%2Flevels%2F2.tmxR2i10628R3R4R5R17R6tgoR0y30:assets%2Fdata%2Flevels%2F3.tmxR2i3663R3R4R5R18R6tgoR0y37:assets%2Fdata%2Flevels%2F32blocks.pngR2i1846R3y5:IMAGER5R19R6tgoR0y30:assets%2Fdata%2Flevels%2F4.tmxR2i3681R3R4R5R21R6tgoR0y30:assets%2Fdata%2Flevels%2F5.tmxR2i3838R3R4R5R22R6tgoR0y30:assets%2Fdata%2Flevels%2F6.tmxR2i5301R3R4R5R23R6tgoR0y30:assets%2Fdata%2Flevels%2F7.tmxR2i3717R3R4R5R24R6tgoR0y30:assets%2Fdata%2Flevels%2F8.tmxR2i3591R3R4R5R25R6tgoR0y30:assets%2Fdata%2Flevels%2F9.tmxR2i4118R3R4R5R26R6tgoR0y42:assets%2Fdata%2Flevels%2FCombinedTiles.pngR2i7873R3R20R5R27R6tgoR0y61:assets%2Fdata%2Flevels%2FCommand%20-%20Backup%20Equipment.tmxR2i6687R3R4R5R28R6tgoR0y49:assets%2Fdata%2Flevels%2FCommand%20-%20Backup.tmxR2i4216R3R4R5R29R6tgoR0y49:assets%2Fdata%2Flevels%2FCommand%20-%20Bridge.tmxR2i6250R3R4R5R30R6tgoR0y61:assets%2Fdata%2Flevels%2FCommand%20-%20Central%20Computer.tmxR2i9816R3R4R5R31R6tgoR0y58:assets%2Fdata%2Flevels%2FCommand%20-%20Computer%20Room.tmxR2i11567R3R4R5R32R6tgoR0y51:assets%2Fdata%2Flevels%2FCommand%20-%20Corridor.tmxR2i10856R3R4R5R33R6tgoR0y59:assets%2Fdata%2Flevels%2FCommand%20-%20Destroyed%20Area.tmxR2i15903R3R4R5R34R6tgoR0y62:assets%2Fdata%2Flevels%2FCommand%20-%20Equipment%20Storage.tmxR2i11665R3R4R5R35R6tgoR0y51:assets%2Fdata%2Flevels%2FCommand%20-%20Junction.tmxR2i4318R3R4R5R36R6tgoR0y55:assets%2Fdata%2Flevels%2FCommand%20-%20Lower%20Deck.tmxR2i8713R3R4R5R37R6tgoR0y59:assets%2Fdata%2Flevels%2FCommand%20-%20Network%20Access.tmxR2i14346R3R4R5R38R6tgoR0y57:assets%2Fdata%2Flevels%2FCommand%20-%20Space%20Bridge.tmxR2i10353R3R4R5R39R6tgoR0y56:assets%2Fdata%2Flevels%2FCommand%20-%20Sub%20Command.tmxR2i10387R3R4R5R40R6tgoR0y60:assets%2Fdata%2Flevels%2FCommand%20-%20Trash%20Compactor.tmxR2i6887R3R4R5R41R6tgoR0y53:assets%2Fdata%2Flevels%2FEngineering%20-%20Column.tmxR2i7853R3R4R5R42R6tgoR0y56:assets%2Fdata%2Flevels%2FEngineering%20-%20Compactor.tmxR2i9781R3R4R5R43R6tgoR0y62:assets%2Fdata%2Flevels%2FEngineering%20-%20Crew%20Quarters.tmxR2i14644R3R4R5R44R6tgoR0y60:assets%2Fdata%2Flevels%2FEngineering%20-%20Engine%20Room.tmxR2i14577R3R4R5R45R6tgoR0y65:assets%2Fdata%2Flevels%2FEngineering%20-%20Freight%20Elevator.tmxR2i9180R3R4R5R46R6tgoR0y54:assets%2Fdata%2Flevels%2FEngineering%20-%20Hallway.tmxR2i9755R3R4R5R47R6tgoR0y55:assets%2Fdata%2Flevels%2FEngineering%20-%20Junction.tmxR2i10126R3R4R5R48R6tgoR0y68:assets%2Fdata%2Flevels%2FEngineering%20-%20Long%20Term%20Storage.tmxR2i9439R3R4R5R49R6tgoR0y61:assets%2Fdata%2Flevels%2FEngineering%20-%20Machine%20Shop.tmxR2i17005R3R4R5R50R6tgoR0y65:assets%2Fdata%2Flevels%2FEngineering%20-%20Officer%20Quarters.tmxR2i8549R3R4R5R51R6tgoR0y58:assets%2Fdata%2Flevels%2FEngineering%20-%20Save%20Room.tmxR2i3804R3R4R5R52R6tgoR0y69:assets%2Fdata%2Flevels%2FEngineering%20-%20Short%20Term%20Storage.tmxR2i7154R3R4R5R53R6tgoR0y63:assets%2Fdata%2Flevels%2FEngineering%20-%20Systems%20Access.tmxR2i10108R3R4R5R54R6tgoR0y68:assets%2Fdata%2Flevels%2FEngineering%20-%20Terraforming%20Access.tmxR2i5931R3R4R5R55R6tgoR0y65:assets%2Fdata%2Flevels%2FEngineering%20-%20Thruster%20Control.tmxR2i16779R3R4R5R56R6tgoR0y53:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Aft.tmxR2i21275R3R4R5R57R6tgoR0y57:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Airlock.tmxR2i4515R3R4R5R58R6tgoR0y62:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Boost%20Room.tmxR2i2829R3R4R5R59R6tgoR0y66:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Command%20Access.tmxR2i3833R3R4R5R60R6tgoR0y59:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Generator.tmxR2i9632R3R4R5R61R6tgoR0y70:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Maintenance%20Access.tmxR2i15896R3R4R5R62R6tgoR0y70:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Maintenance%20Tunnel.tmxR2i11942R3R4R5R63R6tgoR0y61:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Maintenance.tmxR2i6154R3R4R5R64R6tgoR0y62:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Space%20Dock.tmxR2i3482R3R4R5R65R6tgoR0y57:assets%2Fdata%2Flevels%2FLife%20Support%20-%20Storage.tmxR2i14736R3R4R5R66R6tgoR0y60:assets%2Fdata%2Flevels%2FLife%20Support%20-%20The%20Grid.tmxR2i10611R3R4R5R67R6tgoR0y52:assets%2Fdata%2Flevels%2FLife%20Support%20Column.tmxR2i13443R3R4R5R68R6tgoR0y61:assets%2Fdata%2Flevels%2FLife%20Support%20Computer%20Room.tmxR2i2933R3R4R5R69R6tgoR0y36:assets%2Fdata%2Flevels%2Fminimap.pngR2i755R3R20R5R70R6tgoR0y36:assets%2Fdata%2Flevels%2Fminimap.tmxR2i2118R3R4R5R71R6tgoR0y37:assets%2Fdata%2Flevels%2FOutdoors.tmxR2i15826R3R4R5R72R6tgoR0y38:assets%2Fdata%2Flevels%2FPod%20Bay.tmxR2i13646R3R4R5R73R6tgoR0y33:assets%2Fdata%2Flevels%2Fsave.tmxR2i3056R3R4R5R74R6tgoR0y34:assets%2Fdata%2Flevels%2Fsave1.tmxR2i3056R3R4R5R75R6tgoR0y34:assets%2Fdata%2Flevels%2Fsave2.tmxR2i3140R3R4R5R76R6tgoR0y40:assets%2Fdata%2Flevels%2FshipTileset.pngR2i33015R3R20R5R77R6tgoR0y40:assets%2Fdata%2Flevels%2Fshiptileset.tsxR2i201R3R4R5R78R6tgoR0y41:assets%2Fdata%2Flevels%2FT%20Junction.tmxR2i3092R3R4R5R79R6tgoR0y55:assets%2Fdata%2Flevels%2FTerraforming%20-%20Caverns.tmxR2i7285R3R4R5R80R6tgoR0y55:assets%2Fdata%2Flevels%2FTerraforming%20-%20Deepmaw.tmxR2i15101R3R4R5R81R6tgoR0y54:assets%2Fdata%2Flevels%2FTerraforming%20-%20Depths.tmxR2i8018R3R4R5R82R6tgoR0y60:assets%2Fdata%2Flevels%2FTerraforming%20-%20Great%20Tree.tmxR2i13637R3R4R5R83R6tgoR0y60:assets%2Fdata%2Flevels%2FTerraforming%20-%20High%20Falls.tmxR2i26178R3R4R5R84R6tgoR0y56:assets%2Fdata%2Flevels%2FTerraforming%20-%20Outdoors.tmxR2i20679R3R4R5R85R6tgoR0y64:assets%2Fdata%2Flevels%2FTerraforming%20-%20Shadowed%20Glade.tmxR2i29519R3R4R5R86R6tgoR0y68:assets%2Fdata%2Flevels%2FTerraforming%20-%20The%20Maw%20Entrance.tmxR2i8968R3R4R5R87R6tgoR0y57:assets%2Fdata%2Flevels%2FTerraforming%20-%20The%20Maw.tmxR2i14494R3R4R5R88R6tgoR0y41:assets%2Fdata%2Flevels%2FTerraforming.tmxR2i2917R3R4R5R89R6tgoR0y27:assets%2Fdata%2Ftemple2.tmxR2i81251R3R4R5R90R6tgoR0y33:assets%2Fdata%2Ftemplemgsheet.pngR2i21804R3R20R5R91R6tgoR0y30:assets%2Fimages%2Fcavernbg.pngR2i7894R3R20R5R92R6tgoR0y29:assets%2Fimages%2Fconsole.pngR2i1827R3R20R5R93R6tgoR0y34:assets%2Fimages%2Fconsolesmall.pngR2i1768R3R20R5R94R6tgoR0y31:assets%2Fimages%2Fcontrolbg.pngR2i4453R3R20R5R95R6tgoR0y31:assets%2Fimages%2Fforestbg1.pngR2i932R3R20R5R96R6tgoR0y40:assets%2Fimages%2Fforestbg_Layer%200.pngR2i1895R3R20R5R97R6tgoR0y40:assets%2Fimages%2Fforestbg_Layer%201.pngR2i2053R3R20R5R98R6tgoR0y40:assets%2Fimages%2Fforestbg_Layer%202.pngR2i2540R3R20R5R99R6tgoR0y40:assets%2Fimages%2Fforestbg_Layer%203.pngR2i2942R3R20R5R100R6tgoR0y26:assets%2Fimages%2Fguts.pngR2i12371R3R20R5R101R6tgoR0y26:assets%2Fimages%2Flogo.pngR2i9764R3R20R5R102R6tgoR0y27:assets%2Fimages%2Fmain.jsonR2i111535R3R4R5R103R6tgoR0y26:assets%2Fimages%2Fmain.pngR2i83796R3R20R5R104R6tgoR0y30:assets%2Fimages%2FmapAreas.pngR2i2499R3R20R5R105R6tgoR0y30:assets%2Fimages%2FmapRooms.pngR2i4665R3R20R5R106R6tgoR0y28:assets%2Fimages%2Fmeteor.pngR2i4716R3R20R5R107R6tgoR0y31:assets%2Fimages%2Foutsidebg.pngR2i3631R3R20R5R108R6tgoR0y26:assets%2Fimages%2Fpods.pngR2i271R3R20R5R109R6tgoR0y33:assets%2Fimages%2FSanityBar_0.pngR2i184R3R20R5R110R6tgoR0y33:assets%2Fimages%2FSanityBar_1.pngR2i135R3R20R5R111R6tgoR0y26:assets%2Fimages%2Fship.pngR2i2482R3R20R5R112R6tgoR0y33:assets%2Fimages%2Fstarfield_0.pngR2i22145R3R20R5R113R6tgoR0y33:assets%2Fimages%2Fstarfield_1.pngR2i1255R3R20R5R114R6tgoR2i3051866R3y5:MUSICR5y29:assets%2Fmusic%2FDarkCity.oggy9:pathGroupaR116hR6tgoR2i2021058R3R115R5y30:assets%2Fmusic%2FEmptyCity.oggR117aR118hR6tgoR2i1992686R3y5:SOUNDR5y32:assets%2Fmusic%2Fengineering.wavR117aR120hR6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R121R6tgoR2i10188R3R119R5y30:assets%2Fsounds%2Factivate.wavR117aR122hR6tgoR2i291696R3R119R5y30:assets%2Fsounds%2Fairblade.wavR117aR123hR6tgoR2i33370R3R119R5y27:assets%2Fsounds%2Fboost.wavR117aR124hR6tgoR2i43202R3R119R5y26:assets%2Fsounds%2Fdead.wavR117aR125hR6tgoR2i38594R3R119R5y30:assets%2Fsounds%2Felectric.wavR117aR126hR6tgoR2i76432R3R119R5y29:assets%2Fsounds%2Fexplode.wavR117aR127hR6tgoR2i94206R3R119R5y33:assets%2Fsounds%2Fexplodelong.wavR117aR128hR6tgoR2i19328R3R119R5y25:assets%2Fsounds%2Fhit.wavR117aR129hR6tgoR2i10188R3R119R5y28:assets%2Fsounds%2Fimmune.wavR117aR130hR6tgoR2i15520R3R119R5y26:assets%2Fsounds%2Fjump.wavR117aR131hR6tgoR2i10188R3R119R5y33:assets%2Fsounds%2Fplayer_land.wavR117aR132hR6tgoR2i20460R3R119R5y27:assets%2Fsounds%2Fpound.wavR117aR133hR6tgoR2i34298R3R119R5y31:assets%2Fsounds%2Fshockwave.wavR117aR134hR6tgoR2i13340R3R119R5y26:assets%2Fsounds%2Fshot.wavR117aR135hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R136R6tgoR2i2114R3R115R5y26:flixel%2Fsounds%2Fbeep.mp3R117aR137y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R115R5y28:flixel%2Fsounds%2Fflixel.mp3R117aR139y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R119R5R138R117aR137R138hgoR2i33629R3R119R5R140R117aR139R140hgoR2i15744R3R7R8y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R7R8y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R20R5R145R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R20R5R146R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___backup_equipment_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___backup_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___bridge_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___central_computer_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___computer_room_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___corridor_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___destroyed_area_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___equipment_storage_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___junction_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___lower_deck_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___network_access_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___space_bridge_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___sub_command_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_command___trash_compactor_tmx extends null { }
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
@:keep @:bind #if display private #end class __ASSET__assets_images_consolesmall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
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
@:keep @:bind #if display private #end class __ASSET__assets_music_darkcity_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_emptycity_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_engineering_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_activate_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_airblade_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_boost_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_dead_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_electric_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_explode_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_explodelong_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hit_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_immune_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_jump_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_player_land_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_pound_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_shockwave_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_shot_wav extends null { }
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
@:keep @:file("assets/data/levels/Command - Backup Equipment.tmx") #if display private #end class __ASSET__assets_data_levels_command___backup_equipment_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Backup.tmx") #if display private #end class __ASSET__assets_data_levels_command___backup_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Bridge.tmx") #if display private #end class __ASSET__assets_data_levels_command___bridge_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Central Computer.tmx") #if display private #end class __ASSET__assets_data_levels_command___central_computer_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Computer Room.tmx") #if display private #end class __ASSET__assets_data_levels_command___computer_room_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Corridor.tmx") #if display private #end class __ASSET__assets_data_levels_command___corridor_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Destroyed Area.tmx") #if display private #end class __ASSET__assets_data_levels_command___destroyed_area_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Equipment Storage.tmx") #if display private #end class __ASSET__assets_data_levels_command___equipment_storage_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Junction.tmx") #if display private #end class __ASSET__assets_data_levels_command___junction_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Lower Deck.tmx") #if display private #end class __ASSET__assets_data_levels_command___lower_deck_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Network Access.tmx") #if display private #end class __ASSET__assets_data_levels_command___network_access_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Space Bridge.tmx") #if display private #end class __ASSET__assets_data_levels_command___space_bridge_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Sub Command.tmx") #if display private #end class __ASSET__assets_data_levels_command___sub_command_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/data/levels/Command - Trash Compactor.tmx") #if display private #end class __ASSET__assets_data_levels_command___trash_compactor_tmx extends haxe.io.Bytes {}
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
@:keep @:file("assets/data/levels/Life Support - Command Access.tmx") #if display private #end class __ASSET__assets_data_levels_life_support___command_access_tmx extends haxe.io.Bytes {}
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
@:keep @:image("assets/images/console.png") #if display private #end class __ASSET__assets_images_console_png extends lime.graphics.Image {}
@:keep @:image("assets/images/consolesmall.png") #if display private #end class __ASSET__assets_images_consolesmall_png extends lime.graphics.Image {}
@:keep @:image("assets/images/controlbg.png") #if display private #end class __ASSET__assets_images_controlbg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/forestbg1.png") #if display private #end class __ASSET__assets_images_forestbg1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/forestbg_Layer 0.png") #if display private #end class __ASSET__assets_images_forestbg_layer_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/forestbg_Layer 1.png") #if display private #end class __ASSET__assets_images_forestbg_layer_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/forestbg_Layer 2.png") #if display private #end class __ASSET__assets_images_forestbg_layer_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/forestbg_Layer 3.png") #if display private #end class __ASSET__assets_images_forestbg_layer_3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/guts.png") #if display private #end class __ASSET__assets_images_guts_png extends lime.graphics.Image {}
@:keep @:image("assets/images/logo.png") #if display private #end class __ASSET__assets_images_logo_png extends lime.graphics.Image {}
@:keep @:file("assets/images/main.json") #if display private #end class __ASSET__assets_images_main_json extends haxe.io.Bytes {}
@:keep @:image("assets/images/main.png") #if display private #end class __ASSET__assets_images_main_png extends lime.graphics.Image {}
@:keep @:image("assets/images/mapAreas.png") #if display private #end class __ASSET__assets_images_mapareas_png extends lime.graphics.Image {}
@:keep @:image("assets/images/mapRooms.png") #if display private #end class __ASSET__assets_images_maprooms_png extends lime.graphics.Image {}
@:keep @:image("assets/images/meteor.png") #if display private #end class __ASSET__assets_images_meteor_png extends lime.graphics.Image {}
@:keep @:image("assets/images/outsidebg.png") #if display private #end class __ASSET__assets_images_outsidebg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/pods.png") #if display private #end class __ASSET__assets_images_pods_png extends lime.graphics.Image {}
@:keep @:image("assets/images/SanityBar_0.png") #if display private #end class __ASSET__assets_images_sanitybar_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/SanityBar_1.png") #if display private #end class __ASSET__assets_images_sanitybar_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ship.png") #if display private #end class __ASSET__assets_images_ship_png extends lime.graphics.Image {}
@:keep @:image("assets/images/starfield_0.png") #if display private #end class __ASSET__assets_images_starfield_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/starfield_1.png") #if display private #end class __ASSET__assets_images_starfield_1_png extends lime.graphics.Image {}
@:keep @:file("assets/music/DarkCity.ogg") #if display private #end class __ASSET__assets_music_darkcity_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/EmptyCity.ogg") #if display private #end class __ASSET__assets_music_emptycity_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/engineering.wav") #if display private #end class __ASSET__assets_music_engineering_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/activate.wav") #if display private #end class __ASSET__assets_sounds_activate_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/airblade.wav") #if display private #end class __ASSET__assets_sounds_airblade_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/boost.wav") #if display private #end class __ASSET__assets_sounds_boost_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/dead.wav") #if display private #end class __ASSET__assets_sounds_dead_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/electric.wav") #if display private #end class __ASSET__assets_sounds_electric_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/explode.wav") #if display private #end class __ASSET__assets_sounds_explode_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/explodelong.wav") #if display private #end class __ASSET__assets_sounds_explodelong_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/hit.wav") #if display private #end class __ASSET__assets_sounds_hit_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/immune.wav") #if display private #end class __ASSET__assets_sounds_immune_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/jump.wav") #if display private #end class __ASSET__assets_sounds_jump_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/player_land.wav") #if display private #end class __ASSET__assets_sounds_player_land_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/pound.wav") #if display private #end class __ASSET__assets_sounds_pound_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/shockwave.wav") #if display private #end class __ASSET__assets_sounds_shockwave_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/shot.wav") #if display private #end class __ASSET__assets_sounds_shot_wav extends haxe.io.Bytes {}
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