package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import flixel.util.FlxRect;
import openfl.Assets;

using flixel.util.FlxSpriteUtil;



/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var map:FlxTilemap;
	private var player:Player;
	private var enemy:Enemy;
	private var cursor:FlxSprite;
	private var target:Target;

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

		player = new Player(0, 100);
		add(player);

		enemy = new Enemy(300,100);
		add(enemy);

		target = new Target(0,0);
		target.visible = false;
		add(target);

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
		if (FlxG.mouse.justPressedRight) {
			switch(player.state) {
				case "standing" | "stand":
					this.target.scale.x = 1;
					this.target.scale.y = 1;
					this.target.visible = true;
					this.target.alpha = .25;
					this.target.tweens.push(FlxTween.tween(this.target.scale,{x: .10,y:.10},1.5,{complete: function(_) {
						this.target.visible = false;
						this.target.scale.x = 1;
						this.target.scale.y = 1;
						}}));
				case "ducking" | "duck":
					for (t in this.target.tweens) {
						t.cancel();
						t.destroy();
					}
					this.target.fadeOut(.15);

					this.target.alpha = .25;
			}
		}

		if (FlxG.mouse.justPressed) {
			switch(player.state) {
				case "throwing":
					var snowBall = new Snowball(this.player.x,this.player.y,
												this.target.x,this.target.y);
					add(snowBall);
					add(snowBall.emitter);
			}
		}
	}	
}