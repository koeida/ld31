package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;

class Player extends Kid
{
	public var blockSprite:FlxSprite;
    public function new(X:Float=0, Y:Float=0,enemies,snowballs) 
    {
        super(X, Y,false,enemies,snowballs,false);
        blockMode = false;
        blockSprite = new FlxSprite();
        blockSprite.loadGraphic(AssetPaths.block__png,true,32,32,false);
        blockSprite.visible = false;

    }
    private function movement():Void {

		var up    = FlxG.keys.anyPressed(["UP",    "W"]);
		var down  = FlxG.keys.anyPressed(["DOWN",  "S"]);
		var block = FlxG.keys.anyPressed(["SPACE"]);

		if(block && this.blockMode == false) {
			blockMode = true;		

			this.blockSprite.x = this.x;
			this.blockSprite.y = this.y;
			this.blockSprite.visible = true;
			FlxTween.tween(this.blockSprite.scale,{x:5,y:5},.45);
			this.blockSprite.fadeOut(.45);			
			new FlxTimer(.45,function(_) { 
				trace("blockmode ready");
				this.blockMode = false;
				this.blockSprite.visible = false;
				this.blockSprite.alpha = 1;
				this.blockSprite.scale.x = 1;
				this.blockSprite.scale.y = 1;
			});
		}

		if(this.state == "throwing" && animation.finished) {
			this.state = "standing";
		}

		if(FlxG.mouse.justPressedRight) {
			switch(this.state) {
				case "standing" | "aiming" | "stand":
					this.state = "ducking";
					animation.play("duck");
				case "ducking" | "duck":
					this.state = "standing";
					animation.play("stand");
			}
		}

		if(FlxG.mouse.justPressed) {
			switch(this.state) {
				case "standing":
					this.state = "aimstart";			
			}
		}

		if (up && down)
	    	up = down = false;

	    var vVel = up ? -speed : speed;

	    if (up) {
	    	facing = FlxObject.UP;
	    } else if (down) {
	    	facing = FlxObject.DOWN;
	    } 

	    if ((up || down) && this.state == "ducking") {
			velocity.y = vVel;
		}		

		switch(state) {
			case "duck":
				animation.play("duck");
			case "ducking":			
				animation.play("ducking");
			case "standing":
				animation.play("standing");
		}

	}
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		
		this.movement();
		
		super.update();
	}	
}