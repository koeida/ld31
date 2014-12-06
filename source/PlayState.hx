package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import flixel.util.FlxRect;
import flixel.tweens.FlxTween;
import openfl.Assets;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var map:FlxTilemap;
	private var player:Player;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		map = new FlxTilemap();
		map.loadMap(Assets.getText("assets/data/Map1.txt"),AssetPaths.tiles__png,32,32);
		map.setTileProperties(1,FlxObject.NONE);
		map.setTileProperties(2,FlxObject.ANY);

		FlxG.worldBounds.x = 0;
		FlxG.worldBounds.y = 0;
		FlxG.worldBounds.width = map.width;
		FlxG.worldBounds.height = map.height;

		add(map);

		player = new Player(100, 100);
		add(player);
		
		super.create();
	}

	
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		FlxG.collide(player,map);
	}	
}