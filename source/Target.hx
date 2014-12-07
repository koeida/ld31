package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
using flixel.util.FlxSpriteUtil;

class Target extends FlxSprite {
	public var tweens:Array<FlxTween>;
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        tweens = new Array<FlxTween>();
        makeGraphic(200, 200, FlxColor.TRANSPARENT);
		drawCircle(-1,-1,-1,FlxColor.RED);
		this.alpha = 0.25;
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
		this.x = FlxG.mouse.x - Std.int(this.width / 2);
		this.y = FlxG.mouse.y - Std.int(this.height / 2);
		super.update();
	}	
}