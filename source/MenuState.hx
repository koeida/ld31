package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxMath;
using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var _btnPlay:FlxButton;
	private var _btnInfo:FlxButton;
	private var _sprBack:FlxSprite;
	private var _btnOk:FlxButton;
	private var _txtInstructions:FlxText;
	public var background:FlxSprite;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */

	private function clickPlay():Void
	{
		FlxG.sound.pause();
	    FlxG.switchState(new PlayState());
	}

	private function clickInfo() {
		_sprBack.visible = true;
		_txtInstructions.visible = true;
		_btnOk.visible = true;
	}
	override public function create():Void
	{
		FlxG.sound.playMusic(AssetPaths.ingame__mp3,1,true);
		background = new FlxSprite();
		background.loadGraphic(AssetPaths.title__png,false,320,256,false);
		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnPlay.screenCenter();		
		_btnPlay.x -= 10;
		_btnPlay.y -= 20;

		_btnOk = new FlxButton(0, 0, "OK", clickPlay);	
		_btnOk.x = 75;
		_btnOk.y = FlxG.height - _btnOk.height - 9;
		_btnOk.visible = false;

		_btnInfo = new FlxButton(0, 0, "Help", clickInfo);
		_btnInfo.screenCenter();
		_btnInfo.x -= 10;
		
		_btnInfo.scale.x = .75;
		_btnInfo.scale.y = .75;
		add(background);
		add(_btnPlay);
		
		add(_btnInfo);

		_sprBack = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		_sprBack.drawRect(0, 0, FlxG.width, FlxG.height, FlxColor.BLACK);
		_sprBack.visible = false;
		var instructions = "YOU ARE THE KID ON THE LEFT SIDE OF THE SCREEN AT THE BOTTOM.  LEFT CLICK TO BEGIN AIMING.  A RED CIRCLE WILL APPEAR.  THIS INDICATES THE RANGE IN WHICH YOUR SNOWBALL MIGHT FALL.  WITH A HALF SIZE CIRCLE OR LARGER, THE SNOWBALL WILL BE LOBBED UPWARD.  AT BELOW HALF SIZE, THE SNOWBALL WILL BE PEGGED AT THE ENEMY.  LEFT CLICK AGAIN TO THROW.  ONE HIT KILLS. IF YOU ARE QUICK, YOU CAN TAP SPACEBAR JUST BEFORE A SNOWBALL HITS YOU TO BRUSH IT OFF.  YOU WILL HEAR A CHIME.  YOUR GOAL IS TO DEFEAT THE NEIGHBORHOOD CHILDREN BEARING THE VERY SERIOUS FLAGS FOR AS LONG AS POSSIBLE.";
		_txtInstructions = new FlxText(1, 1, FlxG.width, instructions, 10);
		_txtInstructions.setFormat(null,12,0xffdb7312);
		

        _txtInstructions.setBorderStyle(FlxText.BORDER_SHADOW, 0xff380404, 1, 1);
        _txtInstructions.visible = false;
        add(_sprBack);
        add(_txtInstructions);
        add(_btnOk);
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		_btnPlay = FlxDestroyUtil.destroy(_btnPlay);
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}