import lime.Assets;
#if !macro


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	private static var app:lime.app.Application;
	
	
	public static function create ():Void {
		
		app = new openfl.display.Application ();
		app.create (config);
		
		var display = new flixel.system.FlxPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if js
		var urls = [];
		var types = [];
		
		
		urls.push ("assets/data/data-goes-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/data/Map1.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/images/accessories/anarcho.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/accessories/flagpole.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/accessories/flag_american.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/accessories/flag_anarchist.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/accessories/flag_communist.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/accessories/flag_isis..png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/accessories/flag_isis.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/bases/kid_base.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/block.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/hats/hats1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/hats/hats2.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/images-go-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/images/outfits/outfit_red.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/snowball.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles0.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles00.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles01.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles02.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles03.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles04.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles05.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles06.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles07.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles08.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles09.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles10.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles11.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles12.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles13.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles14.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles3.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles4.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles5.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles6.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles7.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles8.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles_old.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tile_snow.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/music/music-goes-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/sounds/block.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/lasthit.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/punch.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/snowHit.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/snowmiss.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/sounds-go-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/sounds/throw.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/throwhigh.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/beep.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/flixel.mp3");
		types.push (AssetType.MUSIC);
		
		
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if sys
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (_) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (0),
			borderless: false,
			depthBuffer: false,
			fps: Std.int (60),
			fullscreen: false,
			height: Std.int (480),
			orientation: "portrait",
			resizable: true,
			stencilBuffer: false,
			title: "LD31",
			vsync: true,
			width: Std.int (640),
			
		}
		
		#if js
		#if munit
		flash.Lib.embed (null, 640, 480, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		openfl.Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		openfl.Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields (Main)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		if (hasMain) {
			
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


#if flash @:build(DocumentClass.buildFlash())
#else @:build(DocumentClass.build()) #end
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					this.stage = flash.Lib.current.stage;
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
	macro public static function buildFlash ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				var method = macro {
					return flash.Lib.current.stage;
				}
				
				fields.push ({ name: "get_stage", access: [ APrivate ], meta: [ { name: ":getter", params: [ macro stage ], pos: Context.currentPos() } ], kind: FFun({ args: [], expr: method, params: [], ret: macro :flash.display.Stage }), pos: Context.currentPos() });
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end