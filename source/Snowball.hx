package ;

import flixel.effects.particles.FlxEmitter; 
import flixel.effects.particles.FlxParticle; 
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
using flixel.util.FlxSpriteUtil;

using Misc;

class Snowball extends FlxSprite {
	public var speed = 200.0;
	public var emitter:FlxEmitter;
	private var whitePixel:FlxParticle;

    public function new(X:Float=0, Y:Float=0,targetX:Float,targetY:Float,snowballType:SnowballType,missRadius) {
        super(X, Y);

        //LAUNCH SNOWBALL
        this.loadRotatedGraphic(AssetPaths.snowball__png,5);
        this.scale.x = .5;
        this.scale.y = .5;
        this.animation.add("spin", [for (x in 0...5) x], 30, true);

        var missAmountX = FlxRandom.intRanged(-missRadius,missRadius);
        var missAmountY = (snowballType == Fast) ? FlxRandom.intRanged(-missRadius,missRadius) : 0;
    	var targX = targetX + 100 + missAmountX;
    	var targY = targetY + 100 + missAmountY;

        switch(snowballType) {
        	case Slow:
        		FlxG.sound.play(AssetPaths.throwhigh__mp3);
        		FlxTween.quadMotion(this,X,Y,
					Std.int((X + targetX - 100) / 2), targetY - 200,
					targX, targY,
					1,true,{complete: function(_) {this.destroy();}});
        	case Fast:
        		FlxG.sound.play(AssetPaths.throw__mp3);
        		FlxTween.tween(this, {x:targX,y:targY},.25,
        			{complete: function(_) {this.destroy();}});
        }
        
        //INIT PARTICLE EMITTER
        emitter = new FlxEmitter(this.x,this.y, 20);
		emitter.setXSpeed(20,50);
		emitter.setYSpeed(100,200);
		emitter.bounce = 0;
		
		for (i in 0...(Std.int(emitter.maxSize / 2)))
		{
			whitePixel = new FlxParticle();
			whitePixel.makeGraphic(2, 2, 0xffb6c7ff);
			whitePixel.visible = false;
			whitePixel.lifespan = .1;

			emitter.add(whitePixel);

			whitePixel = new FlxParticle();
			whitePixel.makeGraphic(1, 1, 0xffb6c7ff);
			whitePixel.visible = false;
			whitePixel.lifespan = .1;
			emitter.add(whitePixel);
		}
		emitter.start(false, 2, .05);
    }

    override public function destroy():Void {
    	this.emitter.destroy();
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		animation.play("spin");
		emitter.x = this.x;
		emitter.y = this.y;
		super.update();
	}	
}