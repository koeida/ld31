package ;

import flixel.effects.particles.FlxEmitter; 
import flixel.effects.particles.FlxParticle; 
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class Snowball extends FlxSprite {
	public var speed = 200.0;
	public var emitter:FlxEmitter;
	private var whitePixel:FlxParticle;

    public function new(X:Float=0, Y:Float=0,targetX:Float,targetY:Float) {
        super(X, Y);

        //LAUNCH SNOWBALL
        this.loadRotatedGraphic(AssetPaths.snowball__png,16);
        this.scale.x = .5;
        this.scale.y = .5;
        this.animation.add("spin", [for (x in 0...16) x], 128, true);
        FlxTween.quadMotion(this,X,Y,
        					Std.int((X + targetX - 100) / 2), targetY - 200,
        					targetX + 50, targetY + 50,
        					1,true,{complete: function(_) {this.destroy();this.emitter.destroy();}});
        //INIT PARTICLE EMITTER
        emitter = new FlxEmitter(this.x,this.y, 100);
		emitter.setXSpeed(20,50);
		emitter.setYSpeed(100,200);
		emitter.bounce = 0;
		
		for (i in 0...(Std.int(emitter.maxSize / 2)))
		{
			whitePixel = new FlxParticle();
			whitePixel.makeGraphic(2, 2, 0xffb6c7ff);
			whitePixel.visible = false;
			whitePixel.lifespan = .2;

			emitter.add(whitePixel);

			whitePixel = new FlxParticle();
			whitePixel.makeGraphic(1, 1, 0xffb6c7ff);
			whitePixel.visible = false;
			whitePixel.lifespan = .2;
			emitter.add(whitePixel);
		}
		emitter.start(false, 2, .01);
    }

    override public function destroy():Void {
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