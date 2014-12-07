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
    public var target:FlxSprite;

    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        state = "ducking";
        Misc.generateSprite(this);

        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);
        this.facing = FlxObject.LEFT;

        animation.add("duck", [0, 1], 6, false);
        animation.add("stand", [1,0], 6, false);
        animation.add("ducking", [1], 6, false);
        animation.add("standing", [0], 6, false);
        animation.add("throw",[2,3,4,5,6,7],40,false);

        drag.x = drag.y = 10;
        setSize(15,32);
        offset.set(10,0);

    }

    override public function update():Void {
        super.update();
    }



    public function attack() {


    }

    public function idle() {

    }
}