import openfl.Assets;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

using Lambda;
using StringTools;

enum SnowballType {Slow;Fast;}

class Misc {
    public static var outfitPool:Array<FlxSprite> = new Array();
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

    public static function randomSpriteWithName(s,faceLeft) {
        var sprite = new FlxSprite();
        sprite.loadGraphic(Misc.randomAssetWithName(s),true,32,32,false);
        sprite.setFacingFlip(FlxObject.LEFT, true, false);
        sprite.setFacingFlip(FlxObject.RIGHT, false, false);
        sprite.facing = faceLeft ? FlxObject.LEFT : FlxObject.RIGHT;
        return sprite;
    }

    public static function replaceColor(sprite:FlxSprite,oldColor,newColor) {
        for(cx in 0...sprite.pixels.width) {
            for (cy in 0...sprite.pixels.height) {
                if(sprite.pixels.getPixel(cx,cy) == oldColor) {
                    sprite.pixels.setPixel(cx,cy,newColor);
                }
            }
        }
    }

    public static function randomFrom<T>(l:Array<T>) {
        return l[Std.random(l.length)];
    }

    public static function generateSprite(sprite:FlxSprite,faceLeft) {    
        var getRandSprite = Misc.randomSpriteWithName.bind(_,faceLeft);    
        var hatSprite = getRandSprite("hat");

        var clothing = new FlxSprite();
        clothing.loadGraphic(AssetPaths.outfit_red__png,true,32,32,true);
        clothing.setFacingFlip(FlxObject.LEFT, true, false);
        clothing.setFacingFlip(FlxObject.RIGHT, false, false);
        clothing.facing = faceLeft ? FlxObject.LEFT : FlxObject.RIGHT;

        var clothingShades = [0x110000, 0x410000, 0xaa0000, 0xff0000];
        var outfits = [
            [0x110000,0x440000,0x770000,0xaa0000],
            [0x410000,0x770000,0xcc0000,0xff0000],
            [0x770000,0xaa0000,0xdd0000,0xff0000],
            [0x001100,0x004400,0x007700,0x00aa00],
            [0x004100,0x007700,0x00cc00,0x00ff00],
            [0x007700,0x00aa00,0x00dd00,0x00ff00],
            [0x000011,0x000044,0x000077,0x0000aa],
            [0x000041,0x000077,0x0000cc,0x0000ff],
            [0x000077,0x0000aa,0x0000dd,0x0000ff]
            ];
        var outfit = randomFrom(outfits);
        var hat = randomFrom(outfits);
        for (i in 0...4) {
            Misc.replaceColor(hatSprite,clothingShades[i],hat[i]);
            Misc.replaceColor(clothing,clothingShades[i],outfit[i]);
        }       

        sprite.loadGraphic(AssetPaths.kid_base__png,true,32,32,true);
        var skinColors = [0xdbab9c,0xc2978a,0x946f56,0x7d5d48,0x523928,0x2e2016];
        Misc.replaceColor(sprite,0xffc7b6,randomFrom(skinColors));
        sprite.setFacingFlip(FlxObject.LEFT, true, false);
        sprite.setFacingFlip(FlxObject.RIGHT, false, false);
        sprite.facing = faceLeft ? FlxObject.LEFT : FlxObject.RIGHT;
        
        sprite.pixels.copyPixels(clothing.pixels,
            new flash.geom.Rectangle(0,0,sprite.pixels.width,sprite.pixels.height),
            new flash.geom.Point(0,0),null,null,true);

        sprite.pixels.copyPixels(hatSprite.pixels,
            new flash.geom.Rectangle(0,0,sprite.pixels.width,sprite.pixels.height),
            new flash.geom.Point(0,0),null,null,true);       
               
     }
}