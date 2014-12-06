package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public var speed = 200.0;
	private var state = "ducking";
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        var hat = AssetPaths.hats2__png;
        var base = AssetPaths.kid_base__png;
        var hatSprite = new FlxSprite();
        //var baseSprite = new Sprite();
        hatSprite.loadGraphic(hat);
        //baseSprite.loadGraphic(base);
        //this.pixels.copyPixels(hatSprite.pixels,Rectangle(0,0,baseSprite.pixels.width,baseSprite.pixels.height));


        loadGraphic(AssetPaths.kid_base__png,true,32,32);
        this.pixels.copyPixels(hatSprite.pixels,
        	new flash.geom.Rectangle(0,0,this.pixels.width,this.pixels.height),new flash.geom.Point(0,0),null,null,true);

		animation.add("duck", [0, 1], 6, false);
		animation.add("stand", [1,0], 6, false);
		animation.add("ducking", [1], 6, false);
		animation.add("standing", [0], 6, false);
		//animation.add("u", [6, 7, 6, 8], 6, false);
		//animation.add("d", [0, 1, 0, 2], 6, false);
        drag.x = drag.y = 1600;
        setSize(8,14);
        offset.set(4,2);
    }
    private function movement():Void {

		var up    = FlxG.keys.anyPressed(["UP",    "W"]);
		var down  = FlxG.keys.anyPressed(["DOWN",  "S"]);

		if(FlxG.mouse.justPressedRight) {
			switch(this.state) {
				case "standing":
					this.state = "ducking";
					animation.play("duck");
				case "ducking":
					this.state = "standing";
					animation.play("stand");
			}
			FlxG.mouse.reset();
		}

		if (up && down)
	    	up = down = false;

	    var vVel = up ? -speed : speed;

	    if (up) {
	    	facing = FlxObject.UP;
	    } else if (down) {
	    	facing = FlxObject.DOWN;
	    } 

	    if ( up || down)
		{
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