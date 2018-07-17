package;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author Dave
 */
class LocationTracker 
{
	//Size of the room in pixels
	var roomWidth:Float;
	var roomHeight:Float;
	
	//Size of the room in ship units
	var roomWidthShipUnits:Float;
	var roomHeightShipUnits:Float;
	
	var shipPosition:FlxPoint;
	
	public function new(map:FlxTilemap, shipPosition:FlxPoint) 
	{
		roomWidth = map.width;
		roomHeight = map.height;
		roomWidthShipUnits = map.widthInTiles / C.SHIP_ROOM_WIDTH;
		roomHeightShipUnits = map.heightInTiles / C.SHIP_ROOM_HEIGHT;
		this.shipPosition = shipPosition;
	}
	
	
	
}