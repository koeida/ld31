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

typedef Wave = {numEnemies: Int, setup: Kid->Void, numWaves:Int,waveDelay:Int}

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var map:FlxTilemap;
	private var player:Player;
	private var enemy:Kid;
	private var friendly:Kid;
	private var cursor:FlxSprite;
	private var target:Target;
	public var enemies:FlxTypedGroup<Kid>;
	public var friendlies:FlxTypedGroup<Kid>;
	public var snowballs:FlxTypedGroup<Snowball>;
	public var enemySnowballs:FlxTypedGroup<Snowball>;
	public var emitters:FlxTypedGroup<FlxEmitter>;
	public var canThrow:Bool;
	public var enemyPool:FlxTypedGroup<Kid>;

	public var currentWave:Int;
	public var remainingWaves:Int;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		currentWave = 0;
		remainingWaves = -1;
		map = new FlxTilemap();
		map.loadMap(Assets.getText("assets/data/Map1.txt"),AssetPaths.tiles__png,32,32);

		FlxG.worldBounds.x = 0;
		FlxG.worldBounds.y = 0;
		FlxG.worldBounds.width = map.width;
		FlxG.worldBounds.height = map.height;

		add(map);		

		enemies = new FlxTypedGroup<Kid>();
		add(enemies);

		friendlies = new FlxTypedGroup<Kid>();
		add(friendlies);

		snowballs = new FlxTypedGroup<Snowball>();
		add(snowballs);

		enemySnowballs = new FlxTypedGroup<Snowball>();
		add(enemySnowballs);

		emitters = new FlxTypedGroup<FlxEmitter>();
		add(emitters);

		makeWaveHappen();

		for (x in 1...5) {
			friendly = new Kid(15 + Std.random(15),x * 40,false,enemies,snowballs);			
			friendly.brain = friendly.attack;
			friendly.randomThrowDelay = true;
			friendlies.add(friendly);
		}

		player = new Player(15,200,enemies,snowballs);
		player.brain = null;
		friendlies.add(player);
		canThrow = true;

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

	public function makeWaveHappen() {
		var waves:Array<Wave> = 
			[{numEnemies:5,setup:function(k:Kid) {k.brain = k.spawn;},numWaves:3,waveDelay:8},
			 {numEnemies:5,setup:function(k:Kid) {k.brain = k.charge;},numWaves:3,waveDelay:14}];
		var wave = waves[this.currentWave];
		
		switch(this.remainingWaves) {
			case -1: this.remainingWaves = wave.numWaves;
			case 0: 
				this.currentWave += 1;
				this.remainingWaves = -1;
				makeWaveHappen();
				return;
		}

		for (i in 0...wave.numEnemies) {
			enemy = new Kid(255 + Std.random(15),i * 40,true,friendlies,enemySnowballs);
			wave.setup(enemy);
			enemy.randomThrowDelay = true;
			enemies.add(enemy);
		}

		this.remainingWaves -= 1;
		new FlxTimer(wave.waveDelay,function(_) { this.makeWaveHappen();});
	}

	public function animFallBack(sprite:FlxSprite,callback = null) {
		var xMod = (sprite.facing == FlxObject.RIGHT) ? -1 : 1;
		var bounceDistance = Std.random(32) * xMod;
		FlxTween.tween(sprite,{x:sprite.x + bounceDistance},.05);
		FlxTween.angle(sprite,0,90 * xMod,.07,{ease:FlxEase.bounceOut,complete:callback});
	}

	public function animBounce(sprite:FlxSprite,callback = null) {
		var xMod = (sprite.facing == FlxObject.RIGHT) ? -1 : 1;
		var bounceHeight = Std.random(15) * xMod;
		FlxTween.tween(sprite,{x:sprite.x + bounceHeight,y:sprite.y - bounceHeight},
			.05,{complete: function(_) {
					FlxTween.tween(sprite,{y:sprite.y + bounceHeight},
					.05,{complete:callback});
			}});
	}

	public function animWobbleForward(sprite:FlxSprite,callback = null) {
		var xMod = (sprite.facing == FlxObject.RIGHT) ? -1 : 1;
		var bounceDistance = Std.random(32) * xMod;
		FlxTween.angle(sprite,0,-90 * xMod,.5,{ease:FlxEase.elasticIn,complete:callback});
	}

	public function enemyHit(enemy:Kid,snowball:Snowball) {		
		
		if(enemy.state == "duck" || enemy.state == "ducking" || enemy.state == "dead") {
			return;
		} 
		snowball.destroy();
		FlxG.sound.play(AssetPaths.snowHit__mp3);
		if (enemy.state != "dead") {
			var deathChoices = [animFallBack];
			var deathChoice = deathChoices[Std.random(deathChoices.length)];
			var dieFunc = function(_) { enemy.state = "dead";enemy.animation.play("standing");enemy.velocity.x = 0; enemy.velocity.y = 0;}
			enemy.animation.play("standing");
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
		FlxG.overlap(this.friendlies, this.enemySnowballs, enemyHit);

		if (FlxG.mouse.justPressedRight) {
			switch(player.state) {				
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
				case "aiming" if (this.canThrow):
					player.animation.play("throw");
					this.canThrow = false;
					new FlxTimer(1,function(_) { this.canThrow = true;});
					var snowballType = this.target.scale.x <= .4 ? Fast : Slow;
					var accuracyMod = Std.int(50 * this.target.scale.x);
					var snowBall = new Snowball(this.player.x,this.player.y,
												this.target.x,this.target.y,
												snowballType,accuracyMod,100);
					snowballs.add(snowBall);
					emitters.add(snowBall.emitter);	
				case "aimstart":
					player.state = "aiming";
					this.target.scale.x = 1;
					this.target.scale.y = 1;
					this.target.visible = true;
					this.target.alpha = .25;
					this.target.tweens.push(FlxTween.tween(this.target.scale,{x: .01,y:.01},1,{complete: function(_) {
						this.target.visible = false;
						this.target.scale.x = 1;
						this.target.scale.y = 1;
						}}));

			}
		}
	}	
}