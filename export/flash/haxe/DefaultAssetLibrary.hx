package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Font;
import lime.graphics.Image;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if (sys || nodejs)
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/data/Map1.txt", __ASSET__assets_data_map1_txt);
		type.set ("assets/data/Map1.txt", AssetType.TEXT);
		className.set ("assets/images/accessories/anarcho.png", __ASSET__assets_images_accessories_anarcho_png);
		type.set ("assets/images/accessories/anarcho.png", AssetType.IMAGE);
		className.set ("assets/images/bases/kid_base.png", __ASSET__assets_images_bases_kid_base_png);
		type.set ("assets/images/bases/kid_base.png", AssetType.IMAGE);
		className.set ("assets/images/bases/kid_base1.png", __ASSET__assets_images_bases_kid_base1_png);
		type.set ("assets/images/bases/kid_base1.png", AssetType.IMAGE);
		className.set ("assets/images/bases/kid_base2.png", __ASSET__assets_images_bases_kid_base2_png);
		type.set ("assets/images/bases/kid_base2.png", AssetType.IMAGE);
		className.set ("assets/images/bases/kid_base3.png", __ASSET__assets_images_bases_kid_base3_png);
		type.set ("assets/images/bases/kid_base3.png", AssetType.IMAGE);
		className.set ("assets/images/bases/kid_base4.png", __ASSET__assets_images_bases_kid_base4_png);
		type.set ("assets/images/bases/kid_base4.png", AssetType.IMAGE);
		className.set ("assets/images/hats/hats1.png", __ASSET__assets_images_hats_hats1_png);
		type.set ("assets/images/hats/hats1.png", AssetType.IMAGE);
		className.set ("assets/images/hats/hats2.png", __ASSET__assets_images_hats_hats2_png);
		type.set ("assets/images/hats/hats2.png", AssetType.IMAGE);
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		className.set ("assets/images/outfits/outfit_blue.png", __ASSET__assets_images_outfits_outfit_blue_png);
		type.set ("assets/images/outfits/outfit_blue.png", AssetType.IMAGE);
		className.set ("assets/images/outfits/outfit_grey.png", __ASSET__assets_images_outfits_outfit_grey_png);
		type.set ("assets/images/outfits/outfit_grey.png", AssetType.IMAGE);
		className.set ("assets/images/outfits/outfit_pink.png", __ASSET__assets_images_outfits_outfit_pink_png);
		type.set ("assets/images/outfits/outfit_pink.png", AssetType.IMAGE);
		className.set ("assets/images/outfits/outfit_purple.png", __ASSET__assets_images_outfits_outfit_purple_png);
		type.set ("assets/images/outfits/outfit_purple.png", AssetType.IMAGE);
		className.set ("assets/images/outfits/outfit_red.png", __ASSET__assets_images_outfits_outfit_red_png);
		type.set ("assets/images/outfits/outfit_red.png", AssetType.IMAGE);
		className.set ("assets/images/snowball.png", __ASSET__assets_images_snowball_png);
		type.set ("assets/images/snowball.png", AssetType.IMAGE);
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", AssetType.IMAGE);
		className.set ("assets/images/tiles0.png", __ASSET__assets_images_tiles0_png);
		type.set ("assets/images/tiles0.png", AssetType.IMAGE);
		className.set ("assets/images/tiles00.png", __ASSET__assets_images_tiles00_png);
		type.set ("assets/images/tiles00.png", AssetType.IMAGE);
		className.set ("assets/images/tiles01.png", __ASSET__assets_images_tiles01_png);
		type.set ("assets/images/tiles01.png", AssetType.IMAGE);
		className.set ("assets/images/tiles02.png", __ASSET__assets_images_tiles02_png);
		type.set ("assets/images/tiles02.png", AssetType.IMAGE);
		className.set ("assets/images/tiles03.png", __ASSET__assets_images_tiles03_png);
		type.set ("assets/images/tiles03.png", AssetType.IMAGE);
		className.set ("assets/images/tiles04.png", __ASSET__assets_images_tiles04_png);
		type.set ("assets/images/tiles04.png", AssetType.IMAGE);
		className.set ("assets/images/tiles05.png", __ASSET__assets_images_tiles05_png);
		type.set ("assets/images/tiles05.png", AssetType.IMAGE);
		className.set ("assets/images/tiles06.png", __ASSET__assets_images_tiles06_png);
		type.set ("assets/images/tiles06.png", AssetType.IMAGE);
		className.set ("assets/images/tiles07.png", __ASSET__assets_images_tiles07_png);
		type.set ("assets/images/tiles07.png", AssetType.IMAGE);
		className.set ("assets/images/tiles08.png", __ASSET__assets_images_tiles08_png);
		type.set ("assets/images/tiles08.png", AssetType.IMAGE);
		className.set ("assets/images/tiles09.png", __ASSET__assets_images_tiles09_png);
		type.set ("assets/images/tiles09.png", AssetType.IMAGE);
		className.set ("assets/images/tiles1.png", __ASSET__assets_images_tiles1_png);
		type.set ("assets/images/tiles1.png", AssetType.IMAGE);
		className.set ("assets/images/tiles10.png", __ASSET__assets_images_tiles10_png);
		type.set ("assets/images/tiles10.png", AssetType.IMAGE);
		className.set ("assets/images/tiles11.png", __ASSET__assets_images_tiles11_png);
		type.set ("assets/images/tiles11.png", AssetType.IMAGE);
		className.set ("assets/images/tiles2.png", __ASSET__assets_images_tiles2_png);
		type.set ("assets/images/tiles2.png", AssetType.IMAGE);
		className.set ("assets/images/tiles3.png", __ASSET__assets_images_tiles3_png);
		type.set ("assets/images/tiles3.png", AssetType.IMAGE);
		className.set ("assets/images/tiles4.png", __ASSET__assets_images_tiles4_png);
		type.set ("assets/images/tiles4.png", AssetType.IMAGE);
		className.set ("assets/images/tiles5.png", __ASSET__assets_images_tiles5_png);
		type.set ("assets/images/tiles5.png", AssetType.IMAGE);
		className.set ("assets/images/tiles6.png", __ASSET__assets_images_tiles6_png);
		type.set ("assets/images/tiles6.png", AssetType.IMAGE);
		className.set ("assets/images/tiles7.png", __ASSET__assets_images_tiles7_png);
		type.set ("assets/images/tiles7.png", AssetType.IMAGE);
		className.set ("assets/images/tiles8.png", __ASSET__assets_images_tiles8_png);
		type.set ("assets/images/tiles8.png", AssetType.IMAGE);
		className.set ("assets/images/tile_snow.png", __ASSET__assets_images_tile_snow_png);
		type.set ("assets/images/tile_snow.png", AssetType.IMAGE);
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/lasthit.mp3", __ASSET__assets_sounds_lasthit_mp3);
		type.set ("assets/sounds/lasthit.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/snowHit.mp3", __ASSET__assets_sounds_snowhit_mp3);
		type.set ("assets/sounds/snowHit.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/throw.mp3", __ASSET__assets_sounds_throw_mp3);
		type.set ("assets/sounds/throw.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Map1.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/accessories/anarcho.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bases/kid_base.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bases/kid_base1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bases/kid_base2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bases/kid_base3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bases/kid_base4.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/hats/hats1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/hats/hats2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/images-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/outfits/outfit_blue.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/outfits/outfit_grey.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/outfits/outfit_pink.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/outfits/outfit_purple.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/outfits/outfit_red.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/snowball.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles00.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles01.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles02.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles03.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles04.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles05.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles06.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles07.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles08.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles09.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles10.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles11.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles4.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles5.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles6.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles7.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles8.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tile_snow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/lasthit.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/snowHit.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/throw.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		/*var useManifest = false;
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/data/Map1.txt", __ASSET__assets_data_map1_txt);
		type.set ("assets/data/Map1.txt", AssetType.TEXT);
		
		className.set ("assets/images/accessories/anarcho.png", __ASSET__assets_images_accessories_anarcho_png);
		type.set ("assets/images/accessories/anarcho.png", AssetType.IMAGE);
		
		className.set ("assets/images/bases/kid_base.png", __ASSET__assets_images_bases_kid_base_png);
		type.set ("assets/images/bases/kid_base.png", AssetType.IMAGE);
		
		className.set ("assets/images/bases/kid_base1.png", __ASSET__assets_images_bases_kid_base1_png);
		type.set ("assets/images/bases/kid_base1.png", AssetType.IMAGE);
		
		className.set ("assets/images/bases/kid_base2.png", __ASSET__assets_images_bases_kid_base2_png);
		type.set ("assets/images/bases/kid_base2.png", AssetType.IMAGE);
		
		className.set ("assets/images/bases/kid_base3.png", __ASSET__assets_images_bases_kid_base3_png);
		type.set ("assets/images/bases/kid_base3.png", AssetType.IMAGE);
		
		className.set ("assets/images/bases/kid_base4.png", __ASSET__assets_images_bases_kid_base4_png);
		type.set ("assets/images/bases/kid_base4.png", AssetType.IMAGE);
		
		className.set ("assets/images/hats/hats1.png", __ASSET__assets_images_hats_hats1_png);
		type.set ("assets/images/hats/hats1.png", AssetType.IMAGE);
		
		className.set ("assets/images/hats/hats2.png", __ASSET__assets_images_hats_hats2_png);
		type.set ("assets/images/hats/hats2.png", AssetType.IMAGE);
		
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/images/outfits/outfit_blue.png", __ASSET__assets_images_outfits_outfit_blue_png);
		type.set ("assets/images/outfits/outfit_blue.png", AssetType.IMAGE);
		
		className.set ("assets/images/outfits/outfit_grey.png", __ASSET__assets_images_outfits_outfit_grey_png);
		type.set ("assets/images/outfits/outfit_grey.png", AssetType.IMAGE);
		
		className.set ("assets/images/outfits/outfit_pink.png", __ASSET__assets_images_outfits_outfit_pink_png);
		type.set ("assets/images/outfits/outfit_pink.png", AssetType.IMAGE);
		
		className.set ("assets/images/outfits/outfit_purple.png", __ASSET__assets_images_outfits_outfit_purple_png);
		type.set ("assets/images/outfits/outfit_purple.png", AssetType.IMAGE);
		
		className.set ("assets/images/outfits/outfit_red.png", __ASSET__assets_images_outfits_outfit_red_png);
		type.set ("assets/images/outfits/outfit_red.png", AssetType.IMAGE);
		
		className.set ("assets/images/snowball.png", __ASSET__assets_images_snowball_png);
		type.set ("assets/images/snowball.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles0.png", __ASSET__assets_images_tiles0_png);
		type.set ("assets/images/tiles0.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles00.png", __ASSET__assets_images_tiles00_png);
		type.set ("assets/images/tiles00.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles01.png", __ASSET__assets_images_tiles01_png);
		type.set ("assets/images/tiles01.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles02.png", __ASSET__assets_images_tiles02_png);
		type.set ("assets/images/tiles02.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles03.png", __ASSET__assets_images_tiles03_png);
		type.set ("assets/images/tiles03.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles04.png", __ASSET__assets_images_tiles04_png);
		type.set ("assets/images/tiles04.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles05.png", __ASSET__assets_images_tiles05_png);
		type.set ("assets/images/tiles05.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles06.png", __ASSET__assets_images_tiles06_png);
		type.set ("assets/images/tiles06.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles07.png", __ASSET__assets_images_tiles07_png);
		type.set ("assets/images/tiles07.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles08.png", __ASSET__assets_images_tiles08_png);
		type.set ("assets/images/tiles08.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles09.png", __ASSET__assets_images_tiles09_png);
		type.set ("assets/images/tiles09.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles1.png", __ASSET__assets_images_tiles1_png);
		type.set ("assets/images/tiles1.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles10.png", __ASSET__assets_images_tiles10_png);
		type.set ("assets/images/tiles10.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles11.png", __ASSET__assets_images_tiles11_png);
		type.set ("assets/images/tiles11.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles2.png", __ASSET__assets_images_tiles2_png);
		type.set ("assets/images/tiles2.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles3.png", __ASSET__assets_images_tiles3_png);
		type.set ("assets/images/tiles3.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles4.png", __ASSET__assets_images_tiles4_png);
		type.set ("assets/images/tiles4.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles5.png", __ASSET__assets_images_tiles5_png);
		type.set ("assets/images/tiles5.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles6.png", __ASSET__assets_images_tiles6_png);
		type.set ("assets/images/tiles6.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles7.png", __ASSET__assets_images_tiles7_png);
		type.set ("assets/images/tiles7.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles8.png", __ASSET__assets_images_tiles8_png);
		type.set ("assets/images/tiles8.png", AssetType.IMAGE);
		
		className.set ("assets/images/tile_snow.png", __ASSET__assets_images_tile_snow_png);
		type.set ("assets/images/tile_snow.png", AssetType.IMAGE);
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/lasthit.mp3", __ASSET__assets_sounds_lasthit_mp3);
		type.set ("assets/sounds/lasthit.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/snowHit.mp3", __ASSET__assets_sounds_snowhit_mp3);
		type.set ("assets/sounds/snowHit.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/throw.mp3", __ASSET__assets_sounds_throw_mp3);
		type.set ("assets/sounds/throw.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		*/
		var useManifest = true;
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && requestedType == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return AudioBuffer.fromFile (path.get (id));
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		//return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		//else 
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Dynamic /*Font*/ {
		
		// TODO: Complete Lime Font API
		
		#if openfl
		#if (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), openfl.text.Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			openfl.text.Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), openfl.text.Font);
			
		} else {
			
			return new openfl.text.Font (path.get (id));
			
		}
		
		#end
		#end
		
		return null;
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		return Image.fromFile (path.get (id));
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getAudioBuffer (id));
			
		//}
		
		#else
		
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_map1_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_accessories_anarcho_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bases_kid_base_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bases_kid_base1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bases_kid_base2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bases_kid_base3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bases_kid_base4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hats_hats1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hats_hats2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_images_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_outfits_outfit_blue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_outfits_outfit_grey_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_outfits_outfit_pink_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_outfits_outfit_purple_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_outfits_outfit_red_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_snowball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles00_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles01_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles02_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles03_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles04_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles05_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles06_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles07_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles08_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles09_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles10_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles11_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles8_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tile_snow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_lasthit_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_snowhit_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_throw_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }


#elseif html5

#if openfl
















































#end

#else

#if openfl

#end

#if (windows || mac || linux)

//
//@:file("assets/data/data-goes-here.txt") class __ASSET__assets_data_data_goes_here_txt extends lime.utils.ByteArray {}
//@:file("assets/data/Map1.txt") class __ASSET__assets_data_map1_txt extends lime.utils.ByteArray {}
//@:bitmap("assets/images/accessories/anarcho.png") class __ASSET__assets_images_accessories_anarcho_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/bases/kid_base.png") class __ASSET__assets_images_bases_kid_base_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/bases/kid_base1.png") class __ASSET__assets_images_bases_kid_base1_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/bases/kid_base2.png") class __ASSET__assets_images_bases_kid_base2_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/bases/kid_base3.png") class __ASSET__assets_images_bases_kid_base3_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/bases/kid_base4.png") class __ASSET__assets_images_bases_kid_base4_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/hats/hats1.png") class __ASSET__assets_images_hats_hats1_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/hats/hats2.png") class __ASSET__assets_images_hats_hats2_png extends openfl.display.BitmapData {}
//@:file("assets/images/images-go-here.txt") class __ASSET__assets_images_images_go_here_txt extends lime.utils.ByteArray {}
//@:bitmap("assets/images/outfits/outfit_blue.png") class __ASSET__assets_images_outfits_outfit_blue_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/outfits/outfit_grey.png") class __ASSET__assets_images_outfits_outfit_grey_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/outfits/outfit_pink.png") class __ASSET__assets_images_outfits_outfit_pink_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/outfits/outfit_purple.png") class __ASSET__assets_images_outfits_outfit_purple_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/outfits/outfit_red.png") class __ASSET__assets_images_outfits_outfit_red_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/snowball.png") class __ASSET__assets_images_snowball_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles.png") class __ASSET__assets_images_tiles_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles0.png") class __ASSET__assets_images_tiles0_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles00.png") class __ASSET__assets_images_tiles00_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles01.png") class __ASSET__assets_images_tiles01_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles02.png") class __ASSET__assets_images_tiles02_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles03.png") class __ASSET__assets_images_tiles03_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles04.png") class __ASSET__assets_images_tiles04_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles05.png") class __ASSET__assets_images_tiles05_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles06.png") class __ASSET__assets_images_tiles06_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles07.png") class __ASSET__assets_images_tiles07_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles08.png") class __ASSET__assets_images_tiles08_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles09.png") class __ASSET__assets_images_tiles09_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles1.png") class __ASSET__assets_images_tiles1_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles10.png") class __ASSET__assets_images_tiles10_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles11.png") class __ASSET__assets_images_tiles11_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles2.png") class __ASSET__assets_images_tiles2_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles3.png") class __ASSET__assets_images_tiles3_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles4.png") class __ASSET__assets_images_tiles4_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles5.png") class __ASSET__assets_images_tiles5_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles6.png") class __ASSET__assets_images_tiles6_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles7.png") class __ASSET__assets_images_tiles7_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tiles8.png") class __ASSET__assets_images_tiles8_png extends openfl.display.BitmapData {}
//@:bitmap("assets/images/tile_snow.png") class __ASSET__assets_images_tile_snow_png extends openfl.display.BitmapData {}
//@:file("assets/music/music-goes-here.txt") class __ASSET__assets_music_music_goes_here_txt extends lime.utils.ByteArray {}
//@:sound("assets/sounds/lasthit.mp3") class __ASSET__assets_sounds_lasthit_mp3 extends openfl.media.Sound {}
//@:sound("assets/sounds/snowHit.mp3") class __ASSET__assets_sounds_snowhit_mp3 extends openfl.media.Sound {}
//@:file("assets/sounds/sounds-go-here.txt") class __ASSET__assets_sounds_sounds_go_here_txt extends lime.utils.ByteArray {}
//@:sound("assets/sounds/throw.mp3") class __ASSET__assets_sounds_throw_mp3 extends openfl.media.Sound {}
//@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,5/assets/sounds/beep.mp3") class __ASSET__assets_sounds_beep_mp3 extends openfl.media.Sound {}
//@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,5/assets/sounds/flixel.mp3") class __ASSET__assets_sounds_flixel_mp3 extends openfl.media.Sound {}
//
//

#end

#end
#end

