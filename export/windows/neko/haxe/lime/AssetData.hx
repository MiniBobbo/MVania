package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/levels/1.tmx", "assets/data/levels/1.tmx");
			type.set ("assets/data/levels/1.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/levels/32blocks.png", "assets/data/levels/32blocks.png");
			type.set ("assets/data/levels/32blocks.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/data/levels/CombinedTiles.png", "assets/data/levels/CombinedTiles.png");
			type.set ("assets/data/levels/CombinedTiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/data/temple2.tmx", "assets/data/temple2.tmx");
			type.set ("assets/data/temple2.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/templemgsheet.png", "assets/data/templemgsheet.png");
			type.set ("assets/data/templemgsheet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/checkpoint.png", "assets/images/checkpoint.png");
			type.set ("assets/images/checkpoint.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fire_0.png", "assets/images/fire_0.png");
			type.set ("assets/images/fire_0.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/main.json", "assets/images/main.json");
			type.set ("assets/images/main.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/main.png", "assets/images/main.png");
			type.set ("assets/images/main.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/images/logo/default.png", "flixel/images/logo/default.png");
			type.set ("flixel/images/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
