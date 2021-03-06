import openfl.Assets;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import flixel.util.FlxVelocity;
import flixel.util.FlxMath;
import flixel.addons.effects.FlxWaveSprite;

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
    public var movementTarget:Kid;

    public var startY:Float;
    public var startX:Float;
    public var blockMode:Bool;
    public var ableToRecover:Bool = false;
    public var isFlagKid:Bool = false;
    public var flagName:String;
    public var flags:FlxSprite;
    public var flag:FlxWaveSprite;
    public var flagpole:FlxSprite;

    public function new(X:Float=0, Y:Float=0,faceLeft = false,enemies,snowballs,throwDelay = true) 
    {
        super(X, Y);
        this.blockMode = false;
        Misc.generateSprite(this,faceLeft);

        animation.add("duck", [0, 1], 6, false);
        animation.add("stand", [1,0], 6, false);
        animation.add("running", [8,0], 6, true);
        animation.add("ducking", [1], 6, false);
        animation.add("standing", [0], 6, false);
        animation.add("throw",[2,3,4,5,6,7],40,false);
        animation.add("flag",[9,8],6,true);
        animation.play("ducking");
        this.state = "ducking";

        this.startY = Y;
        this.startX = X;
        drag.x = drag.y = 10;
        setSize(20,28);
        offset.set(6,4);
        this.enemies = enemies;
        this.snowballs = snowballs;
        this.brain = null;
        this.randomThrowDelay = throwDelay;
        this.canThrow = !randomThrowDelay;
        if(randomThrowDelay) {
            var throwDelay = this.randomThrowDelay ? 1 + Std.random(2) : 1;
            new FlxTimer(throwDelay,function(_) { this.canThrow = true;});
        }

        if(this.isFlagKid) {
            flag.center = Std.int(FlxMath.bound(flag.center, 0, flag.height));
            flag.strength = Std.int(FlxMath.bound(flag.strength, 0, 500));
            flag.speed = FlxMath.bound(flag.speed, 0, 80);
            flag.mode = TOP;
        }
    }

     public function throwSnowball(target:FlxSprite,accuracy) {
        this.canThrow = false;
        var throwDelay = this.randomThrowDelay ? 1 + Std.random(2) : 1;
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
        if(this.isFlagKid) {
            this.flagpole.x = this.x - 5;
            this.flagpole.y = this.y - 40;
            this.flag.x = this.flagpole.x - 24;
            this.flag.y = this.flagpole.y;
        }
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

    public function charge() {
        var chargeAnim = this.isFlagKid ? "flag" : "running";
        if(this.canThrow) {
            var targets = this.enemies.members.filter(function(e) {return e.state != "dead";});
            
            if(targets.length > 0) {
                var target = targets[Std.random(targets.length)];
                if(this.state != "throwing") {
                    new FlxTimer(Std.random(2),function(_) {
                        if(this.state == "dead") { return;}
                        animation.play("throw");
                        throwSnowball(target,.5);});
                    new FlxTimer(2,function(_) {
                        if(this.state == "dead") { return;}
                        this.state = "running";
                        animation.play(chargeAnim);});
                    this.state = "throwing";
                }
                
            }
        } else {
            this.state = "running";
            animation.play(chargeAnim);
            if(movementTarget == null || movementTarget.state == "dead") {
                var targets = this.enemies.members.filter(function(e) {return e.state != "dead";});            
                this.movementTarget = Misc.randomFrom(targets);            
            }    
            FlxVelocity.moveTowardsObject(this,this.movementTarget,60);    
        }
    }

    public function spawn() {
        if(this.x < this.startX - 48) {
            this.state = "standing";
            animation.play("standing");
            this.velocity.x = 0;
            this.velocity.y = 0;
            this.brain = attack;
        } else {
            this.state = "running";
            animation.play("running");
            if(movementTarget == null || movementTarget.state == "dead") {
                var targets = this.enemies.members.filter(function(e) {return e.state != "dead";});            
                this.movementTarget = Misc.randomFrom(targets);            
            }    
            FlxVelocity.moveTowardsPoint(this,FlxPoint.weak(this.startX - 50,this.startY),80);   
        }
    }

    public function idle() {

    }
}