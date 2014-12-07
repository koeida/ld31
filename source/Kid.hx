import openfl.Assets;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.group.FlxTypedGroup;

using Lambda;
using Misc;
using StringTools;

class Kid extends FlxSprite
{
    public var speed:Float = 140;
    public var state:String;
    public var brain:Void->Void;
    public var enemies:FlxTypedGroup<Kid>;
    public var snowballs:FlxTypedGroup<Snowball>;
    public var canThrow:Bool;
    public var randomThrowDelay = true;

    public function new(X:Float=0, Y:Float=0,faceLeft = false,enemies,snowballs,throwDelay = true) 
    {
        super(X, Y);
        
        Misc.generateSprite(this,faceLeft);

        animation.add("duck", [0, 1], 6, false);
        animation.add("stand", [1,0], 6, false);
        animation.add("running", [8,0], 15, true);
        animation.add("ducking", [1], 6, false);
        animation.add("standing", [0], 6, false);
        animation.add("throw",[2,3,4,5,6,7],40,false);
        animation.play("ducking");
        this.state = "ducking";

        drag.x = drag.y = 10;
        setSize(15,32);
        offset.set(10,0);
        this.enemies = enemies;
        this.snowballs = snowballs;
        this.brain = null;
        this.randomThrowDelay = throwDelay;
        this.canThrow = !randomThrowDelay;
        if(randomThrowDelay) {
            var throwDelay = this.randomThrowDelay ? 1 + Std.random(3) : 1;
            new FlxTimer(throwDelay,function(_) { this.canThrow = true;});
        }
    }

    public function throwSnowball(target:FlxSprite,accuracy) {
        this.canThrow = false;
        var throwDelay = this.randomThrowDelay ? 1 + Std.random(3) : 1;
        new FlxTimer(throwDelay,function(_) { this.canThrow = true;});
        var snowballType = accuracy <= .4 ? Fast : Slow;
        var accuracyMod = Std.int(50 * target.scale.x);
        var snowBall = new Snowball(this.x,this.y,
                                    target.x,target.y,
                                    snowballType,accuracyMod,16);
        this.snowballs.add(snowBall);
    }

    override public function update():Void {
        super.update();
        if(this.brain != null && this.state != "dead") {
            this.brain();
        }
    }    

    public function attack() {        
        if(this.canThrow) {
            var targets = this.enemies.members.filter(function(e) {return e.state != "dead";});
            
            if(targets.length > 0) {
                var target = targets[Std.random(targets.length)];
                if(this.state != "throwing") {
                    new FlxTimer(Std.random(2),function(_) {
                        if(this.state == "dead") { return;}
                        animation.play("throw");
                        throwSnowball(target,.2);});
                    new FlxTimer(2,function(_) {
                        if(this.state == "dead") { return;}
                        this.state = "ducking";
                        animation.play("duck");});
                    this.state = "throwing";
                }
                
            }
        }
    }

    public function idle() {

    }
}