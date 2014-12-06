import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class Backdrop extends FlxSprite {
	public var map:FlxTilemap;
	public function new() {
		var xTiles = Std.int(FlxG.width / Reg.tile_resolution);
		var yTiles = Std.int(FlxG.height / Reg.tile_resolution);
		var mapData = [for (y in (0...xTiles)) [for (x in 0...yTiles) 0]];
		map = new FlxTilemap();
		map.loadMap(mapData,AssetPaths.tile_snow__png,64,64);
        super(0,0);
    }
}