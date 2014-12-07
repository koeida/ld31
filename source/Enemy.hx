import openfl.Assets;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

using Lambda;
using StringTools;

class Enemy extends FlxSprite
{
    public var speed:Float = 140;
    public var state:String;

    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        state = "alive";
        Misc.generateSprite(this);

        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);
        this.facing = FlxObject.LEFT;

        drag.x = drag.y = 10;
        width = 8;
        height = 14;
        offset.x = 4;
        offset.y = 2;
    }
}