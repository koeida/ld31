import openfl.Assets;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

using Lambda;
using StringTools;

class Misc {
	public static function assetsWithName(n) {
        return Assets
            .list(IMAGE)
            .filter(function (s) {return s.indexOf(n) != -1;});
    }

    public static function randomAssetWithName(s) {
        var assets = Misc.assetsWithName(s);
        var asset = assets[Std.random(assets.length)];
        return asset;
    }

    public static function randomSpriteWithName(s) {
        var sprite = new FlxSprite();
        sprite.loadGraphic(Misc.randomAssetWithName(s),true,32,32,true);
        return sprite;
    }

    public static function generateSprite(sprite:FlxSprite) {        
        var clothingOptions = ["hat","outfit"].map(Misc.randomSpriteWithName);
        sprite.loadGraphic(Misc.randomAssetWithName("base"),true,32,32,true);
        for(o in clothingOptions) {
            sprite.pixels.copyPixels(o.pixels,
                new flash.geom.Rectangle(0,0,sprite.pixels.width,sprite.pixels.height),
                new flash.geom.Point(0,0),null,null,true);        
        }       
     }
}