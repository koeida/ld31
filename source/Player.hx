package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public var speed = 200.0;
	private var state = "normal";
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        loadGraphic(AssetPaths.kid_base__png,false,32,32);
        setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		//animation.add("lr", [3, 4, 3, 5], 6, false);
		//animation.add("u", [6, 7, 6, 8], 6, false);
		//animation.add("d", [0, 1, 0, 2], 6, false);
        drag.x = drag.y = 1600;
        setSize(8,14);
        offset.set(4,2);
    }
    private function movement():Void {
    	//var _up:Bool = false;
		//var _down:Bool = false;
		//var _left:Bool = false;
		//var _right:Bool = false;
		var up    = FlxG.keys.anyPressed(["UP",    "W"]);
		var down  = FlxG.keys.anyPressed(["DOWN",  "S"]);
		var left  = FlxG.keys.anyPressed(["LEFT",  "A"]);
		var right = FlxG.keys.anyPressed(["RIGHT", "D"]);

		if (up && down)
	    	up = down = false;
		if (left && right)
	    	left = right = false;

	    var vVel = up ? -speed : speed;
	    var hVel = left ? -speed : speed;

	    if (up) {
	    	facing = FlxObject.UP;
	    } else if (down) {
	    	facing = FlxObject.DOWN;
	    } else if (left) {
	    	facing = FlxObject.LEFT;
	    } else if (right) {
	    	facing = FlxObject.RIGHT;
	    }

	    if ( up || down)
		{
			velocity.y = vVel;
		}

		if (left || right) {
			velocity.x = hVel;
		}

		switch(facing)
    	{
	        case FlxObject.LEFT, FlxObject.RIGHT:
	            animation.play("lr");
	        case FlxObject.UP:
	            animation.play("u");
	        case FlxObject.DOWN:
	            animation.play("d");
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
		if(this.state == "normal") {
			this.movement();
		}
		super.update();
	}	
}