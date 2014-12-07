package;

import flixel.effects.particles.FlxEmitter; 
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import flixel.util.FlxRect;
import flixel.util.FlxTimer;
import openfl.Assets;

using flixel.util.FlxSpriteUtil;
using Misc;



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
	public var enemies:FlxTypedGroup<Enemy>;
	public var snowballs:FlxTypedGroup<Snowball>;
	public var emitters:FlxTypedGroup<FlxEmitter>;
	public var canThrow:Bool;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		map = new FlxTilemap();
		map.loadMap(Assets.getText("assets/data/Map1.txt"),AssetPaths.tiles__png,32,32);


		FlxG.worldBounds.x = 0;
		FlxG.worldBounds.y = 0;
		FlxG.worldBounds.width = map.width;
		FlxG.worldBounds.height = map.height;

		add(map);

		player = new Player(25, 100);
		add(player);
		canThrow = true;

		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

		snowballs = new FlxTypedGroup<Snowball>();
		add(snowballs);

		emitters = new FlxTypedGroup<FlxEmitter>();
		add(emitters);

		for (x in 1...6) {
			enemy = new Enemy(235 + Std.random(15),x * 40);
			enemies.add(enemy);			
		}

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

	public function animFallBack(sprite:FlxSprite,callback = null) {
		var bounceDistance = Std.random(32);
		FlxTween.tween(sprite,{x:sprite.x + bounceDistance},.05);
		FlxTween.angle(sprite,0,90,.05,{ease:FlxEase.bounceOut,complete:callback});
	}

	public function animBounce(sprite:FlxSprite,callback = null) {
		FlxG.sound.play(AssetPaths.snowHit__mp3);
		var bounceHeight = Std.random(15);
		FlxTween.tween(sprite,{y:sprite.y - bounceHeight},
			.05,{complete: function(_) {
					FlxTween.tween(sprite,{y:sprite.y + bounceHeight},
					.05,{complete:callback});
			}});
	}

	public function animWobbleForward(sprite:FlxSprite,callback = null) {
		var bounceDistance = Std.random(32);
		FlxTween.angle(sprite,0,-90,.5,{ease:FlxEase.elasticIn});
	}

	public function enemyHit(enemy:Enemy,snowball:Snowball) {
		FlxG.sound.play(AssetPaths.snowHit__mp3);
		snowball.destroy();	
		if (enemy.state == "alive") {
			var deathChoices = [animFallBack,animWobbleForward];
			var deathChoice = deathChoices[Std.random(deathChoices.length)];
			var dieFunc = function(_) { enemy.state = "dead";}
			deathChoice(enemy,dieFunc);					
		} else {
			animBounce(enemy);
		}
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		FlxG.overlap(this.enemies, this.snowballs, enemyHit);
		if (FlxG.mouse.justPressedRight) {
			switch(player.state) {
				case "standing" | "stand":
					this.target.scale.x = 1;
					this.target.scale.y = 1;
					this.target.visible = true;
					this.target.alpha = .25;
					this.target.tweens.push(FlxTween.tween(this.target.scale,{x: .01,y:.01},1,{complete: function(_) {
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
				case "throwing" if (this.canThrow):
					this.canThrow = false;
					new FlxTimer(1,function(_) { this.canThrow = true;});
					var snowballType = this.target.scale.x <= .4 ? Fast : Slow;
					var accuracyMod = Std.int(50 * this.target.scale.x);
					var snowBall = new Snowball(this.player.x,this.player.y,
												this.target.x,this.target.y,
												snowballType,accuracyMod);
					snowballs.add(snowBall);
					emitters.add(snowBall.emitter);					
			}
		}
	}	
}