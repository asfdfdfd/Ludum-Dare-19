package GameStates {
	import org.flixel.*;
	
	public class Level extends FlxState {
		[Embed(source = '../../assets/hero.png')] private var img_hero :Class;
		[Embed(source = '../../assets/light.png')] private var img_light :Class;
		[Embed(source = '../../assets/wall.png')] private var img_wall :Class;
		[Embed(source = '../../assets/floor.png')] private var img_floor :Class;
		[Embed(source = '../../assets/door_01.png')] private var img_door_01 :Class;
		[Embed(source = '../../assets/door_02.png')] private var img_door_02 :Class;
		[Embed(source = '../../assets/door_03.png')] private var img_door_03 :Class;
		[Embed(source = '../../assets/button_01.png')] private var img_button_01 :Class;
		[Embed(source = '../../assets/button_02.png')] private var img_button_02 :Class;
		[Embed(source = '../../assets/button_03.png')] private var img_button_03 :Class;		
		[Embed(source = '../../assets/button_d.png')] private var img_button_d :Class;
		[Embed(source = '../../assets/exit.png')] private var img_exit :Class;
		[Embed(source = '../../assets/glow-light.png')] private var img_lighting :Class;
		
		[Embed(source = '../../assets/door.mp3')] private var snd_door :Class;
		[Embed(source = '../../assets/exit.mp3')] private var snd_exit :Class;
		[Embed(source = '../../assets/light.mp3')] private var snd_light :Class;
		[Embed(source = '../../assets/ambient_02.mp3')] private var snd_ambient_02 :Class;
		
		private var _sound_door :FlxSound = new FlxSound();
		private var _sound_exit :FlxSound = new FlxSound();
		private var _sound_light :FlxSound = new FlxSound();
		private var _sound_ambient :FlxSound = new FlxSound();
		
		private var _sprite_hero :FlxSprite = null;
		private var _light_hero :Light = null;
		private var _sprite_hero_prev_pos :FlxPoint = null;
		
		private var _sprite_exit :FlxSprite = null;
		private var _light_exit :Light = null;
		
		private var _sprite_door_01 :FlxSprite = null;
		private var _sprite_door_02 :FlxSprite = null;
		private var _sprite_door_03 :FlxSprite = null;
		
		private var _sprite_button_01 :FlxSprite = null;
		private var _sprite_button_02 :FlxSprite = null;
		private var _sprite_button_03 :FlxSprite = null;
		
		private var _group_lights :FlxGroup = null;
		private var _group_walls :FlxGroup = null;
		private var _group_doors :FlxGroup = null;
		private var _group_buttons :FlxGroup = null;
		private var _group_all :FlxGroup = null;
		
		private var _lights :Object = null;

		private var _key_down :String = "DOWN";	
		private var _key_up :String = "UP";
		private var _key_left :String = "LEFT";
		private var _key_right :String = "RIGHT";
		
		private var _lighting :Lighting = null;
		
		private var _map_01 :Array = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);
											   
		private var _map_02 :Array = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
											   2, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 2,
											   2, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 2,
											   2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0, 2,
											   2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0, 2,
											   2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0, 2,
											   2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0, 2,
											   2, 3, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 7, 2,
											   2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0, 2,
											   2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0, 2,
											   2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0, 2,
											   2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 2, 0, 0, 0, 2, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);	
											   
		private var _map_03 :Array = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
											   2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 2, 0, 0, 2, 7, 2,
											   2, 0, 2, 0, 0, 0, 0, 0, 2, 2, 2, 0, 2, 0, 2, 0, 0, 2, 4, 2,
											   2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 2, 0, 2,
											   2, 0, 2, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 2, 0, 2,
											   2, 0, 2, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 2, 0, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 0, 2, 0, 2, 0, 0, 2, 0, 2,
											   2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 2, 0, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 0, 2, 0, 2, 2, 2, 2, 0, 2,
											   2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 2, 2, 2, 0, 2,
											   2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 0, 2, 0, 0, 2, 0, 2,
											   2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 1, 2, 0, 2,
											   2, 1, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 2, 0, 2, 0, 0, 2,-4, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);			
											
		private var _map_04 :Array = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
											   2,-5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 2, 0, 2,
											   2, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 2, 0, 2, 0, 2,
											   2, 0, 0, 2, 0, 0, 5, 0, 0, 0, 0, 0, 2, 0, 2, 2, 0, 2, 0, 2,
											   2, 1, 0, 2, 0, 2, 2, 2, 2, 2, 2, 0, 2, 0, 0, 2, 0, 2, 0, 2,
											   2, 0, 0, 2, 0, 2, 0, 0, 0, 0, 2, 0, 2, 0, 0, 2, 0, 2, 0, 2,
											   2, 2, 0, 2, 0, 2, 4, 2, 2, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 2, 0, 2, 0, 7, 2, 0, 2, 0, 2, 0, 2, 2, 2, 2, 2, 2,
											   2, 2, 0, 2, 0, 2, 0, 0, 2, 0, 2, 0, 2, 0, 0, 0, 2, 0, 0, 2,
											   2, 0, 0, 2, 0, 2, 2, 2, 2, 0, 2, 0, 2, 0, 0, 0, 2, 0, 0, 2,
											   2, 2, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 2,
											   2, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 0, 0, 2, 2, 2, 2, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2,
											   2, 3, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 1, 0,-4, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);		
										   							   
		private var _map_05 :Array = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
											   2,-4, 0, 2, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,-5, 2,
											   2, 0, 0, 2, 0, 0, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 0, 2, 0, 2,
											   2, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 2, 0, 2, 0, 2,
											   2, 1, 0, 0, 0, 2, 0, 0, 2, 2, 0, 2, 2, 2, 0, 0, 0, 2, 0, 2,
											   2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 1, 2, 0, 2,
											   2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 4, 2, 2, 2, 2, 2, 2, 2, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 2, 0, 0, 0, 0, 2, 0, 2,
											   2, 0, 2, 2, 2, 2, 2, 0, 2, 2, 0, 0, 2, 0, 2, 0, 0, 2, 0, 2,
											   2, 0, 0, 0, 2, 0, 0, 0, 2, 2, 0, 0, 2, 0, 2, 0, 0, 2, 0, 2,
											   2, 0, 0, 0, 2, 0, 2, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 2, 0, 2,
											   2, 2, 2, 0, 2, 0, 2, 0, 2, 2, 0, 2, 0, 0, 2, 0, 0, 2, 0, 2,
											   2, 0, 0, 0, 2, 0, 2, 5, 2, 2, 0, 2, 1, 2, 2, 0, 0, 2, 6, 2,
											   2, 0, 1, 0, 0, 0, 2,-6, 2, 2, 0, 2, 0, 0, 2, 0, 0, 2, 7, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);		
											   
		private var _map_06 :Array = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2,
											   2, 2, 2, 2, 2, 4, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 3, 2, 2,
											   2, 1, 0, 0, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 2,
											   2, 0, 0, 0, 2, 5, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 2,-5, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 2, 6, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 2, 0, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 2, 7, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 2, 2, 2, 0, 0, 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2,
											   2,-6, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-4, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);	
											   
		private var _map_07 :Array = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
											   2,-4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 1, 2, 2,
											   2, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 2,
											   2, 0, 0, 0, 2, 7, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 2, 2,
											   2, 0, 0, 0, 2, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 2,
											   2, 0, 0, 2, 0, 0, 0,-6, 2, 2, 2, 2, 2, 0, 0, 0, 2, 0, 2, 2,
											   2, 0, 0, 2, 0, 2, 2, 2, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 2,
											   2, 2, 2, 2, 2, 2, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 2, 5, 2, 2,
											   2, 0, 0, 0, 0, 2, 0, 2, 2, 2, 0, 0, 2, 0, 0, 2, 0, 0, 0, 2,
											   2, 0, 0, 2, 6, 2, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 3, 2,
											   2,-5, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);	
											   
		private var _map_08 :Array = new Array( 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
												2, 1, 2, 2, 2, 2,-5, 2, 2, 2, 2, 2, 2, 0, 2, 0, 2, 0,-4, 2,
												2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 2, 2,
												2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 5, 2, 2, 2, 2,
												2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 0, 0, 2, 2,
												2, 0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2,
												2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 2, 2, 0, 2, 2, 2, 6, 2, 2,
												2, 2, 2, 0, 2, 2, 2, 2, 2, 0, 2, 2, 0, 0, 2, 0, 0, 0, 2, 2,
												2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 2,
												2, 2, 0, 2, 2, 0, 2, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2,
												2, 0, 0, 2, 2, 0, 2, 0, 2, 0, 0, 0, 2, 0, 2, 0, 2, 2, 2, 2,
												2, 2, 0, 0, 2, 2, 2, 0, 2, 7, 2, 4, 2, 0, 2, 0, 0, 0, 2, 2,
												2, 2, 0, 2, 2, 0, 1, 0, 2, 2, 2, 0, 2, 0, 0, 0, 2, 2, 2, 2,
												2, 2, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 2,-6, 0, 0, 0, 0, 0, 2,
												2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);											   
											   
		private var _map_t  :Array = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
											   2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);												   
											   
		private var _maps :Array = null;
		
		public function Level() {	
			_maps = new Array();
			_maps.push(_map_01);
			_maps.push(_map_02);
			_maps.push(_map_03);
			_maps.push(_map_04);
			_maps.push(_map_05);
			_maps.push(_map_06);
			_maps.push(_map_07);
			_maps.push(_map_08);
			
			_sound_door.loadEmbedded(snd_door);
			_sound_exit.loadEmbedded(snd_exit);
			_sound_light.loadEmbedded(snd_light);
			
			_sound_ambient.loadEmbedded(snd_ambient_02, true);
			_sound_ambient.play();			
			
			nextLevel();
		}
		
		private function nextLevel() :void {
			Options.LEVEL++;
			//Options.LEVEL = 7;
			if (Options.LEVEL >= _maps.length) {
				Options.LEVEL = -1;
				_group_all.kill();
				FlxG.state = new Success();
				return;
			}
			var _map :Array = _maps[Options.LEVEL];
						
			trace("[I] Next level.");
						
			if (_group_all != null) {
				_group_all.kill();
			}
			_group_all = new FlxGroup();
			add(_group_all);
						
			_lights = new Object();
			
			var lighting_sprite :FlxSprite = new FlxSprite(0, 0, img_lighting);
			_group_all.add(lighting_sprite);
			
			_lighting = new Lighting(FlxG.width, FlxG.height, LightingQuality.HI, lighting_sprite);			
			
			Options.HERO_SPEED = Options.HERO_SPEED_DEFAULT;
			Options.LIGHT_AMOUNT = Options.LIGHT_AMOUNT_DEFAULT;
			Options.LIGHT_SPEED = Options.LIGHT_SPEED_DEFAULT;
			
			_group_lights = new FlxGroup();
			add(_group_lights);
			
			_group_walls = new FlxGroup();
			add(_group_walls);			
			
			_group_doors = new FlxGroup();
			add(_group_doors);
			
			_group_buttons = new FlxGroup();
			add(_group_buttons);
			
			_group_all.add(_group_buttons);
			_group_all.add(_group_doors);
			_group_all.add(_group_lights);
			_group_all.add(_group_walls);
			
			var MAP_WIDTH :int = 20;
			var MAP_HEIGHT :int = 15;
			
			var row_index :int = 0;
			var col_index :int = 0;
			for (var i :int = 0; i < _map.length; i++) {
				_group_all.add(new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_floor));
				
				if (_map[i] == Options.MAP_ITEM_LIGHT) {
					var sprite_light :FlxSprite = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE);
					sprite_light.loadGraphic(img_light, true, false, 16, 16);
					sprite_light.addAnimation("pulse", [0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1], Math.random() * 4 + 1);
					sprite_light.play("pulse");
					_group_lights.add(sprite_light);
					_lights[sprite_light.x.toString() + sprite_light.y.toString()] = _lighting.createLight(col_index * Options.WALL_SIZE + Options.WALL_SIZE / 2, row_index * Options.WALL_SIZE + Options.WALL_SIZE / 2, Options.LIGHT_AMOUNY_LIGHT);
				}
				
				if (_map[i] == Options.MAP_ITEM_WALL) {
					var sprite_wall :FlxSprite = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_wall);
					_group_walls.add(sprite_wall);
				}		
				
				if (_map[i] == Options.MAP_ITEM_PLAYER) {
					_sprite_hero = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_hero);
					_light_hero = _lighting.createLight(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, Options.LIGHT_AMOUNT);
					add(_sprite_hero);
					
					_sprite_hero_prev_pos = new FlxPoint(_sprite_hero.x, _sprite_hero.y);					
				}
				if (_map[i] == Options.MAP_ITEM_DOOR1) {
					_sprite_door_01 = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_door_01);
					_group_doors.add(_sprite_door_01);
				}			
				
				if (_map[i] == Options.MAP_ITEM_DOOR2) {
					_sprite_door_02 = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_door_02);
					_group_doors.add(_sprite_door_02);
				}						
				
				if (_map[i] == Options.MAP_ITEM_DOOR3) {
					_sprite_door_03 = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_door_03);
					_group_doors.add(_sprite_door_03);
				}			
				
				if (_map[i] == Options.MAP_ITEM_BUTTON1) {
					_sprite_button_01 = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_button_01);
					_group_buttons.add(_sprite_button_01);
				}			
				
				if (_map[i] == Options.MAP_ITEM_BUTTON2) {
					_sprite_button_02 = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_button_02);
					_group_buttons.add(_sprite_button_02);
				}						
				
				if (_map[i] == Options.MAP_ITEM_BUTTON3) {
					_sprite_button_03 = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_button_03);
					_group_buttons.add(_sprite_button_03);
				}		
				
				if (_map[i] == Options.MAP_ITEM_EXIT) {
					_sprite_exit = new FlxSprite(col_index * Options.WALL_SIZE, row_index * Options.WALL_SIZE, img_exit);
					add(_sprite_exit);
					_light_exit = _lighting.createLight(col_index * Options.WALL_SIZE + Options.WALL_SIZE / 2, row_index * Options.WALL_SIZE + Options.WALL_SIZE / 2, Options.LIGHT_AMOUNT_EXIT);
					_light_exit.health = 100;
					_group_all.add(_light_exit);
				}					
				
				col_index++;
				if (col_index >= MAP_WIDTH) {
					col_index = 0;
					row_index++;
				}
			}	

			add(_lighting);
			
			_group_all.add(_lighting);
			_group_all.add(_light_hero);
			_group_all.add(_sprite_hero);
			_group_all.add(_sprite_exit);
		}
		
		override public function update() :void {
			super.update();
			
			_light_hero.x = _sprite_hero.x + Options.WALL_SIZE / 2 / 2;
			_light_hero.y = _sprite_hero.y + Options.WALL_SIZE / 2 / 2;			
			
			if (FlxG.keys.pressed(_key_up)) {
				_sprite_hero.y -= FlxG.elapsed * Options.HERO_SPEED;
			}			
						
			if (FlxG.keys.pressed(_key_down)) {
				_sprite_hero.y += FlxG.elapsed * Options.HERO_SPEED;
			}
			
			FlxU.overlap(_sprite_hero, _group_walls, overlapHandlerHeroWalls);
			FlxU.overlap(_sprite_hero, _group_doors, overlapHandlerHeroDoors);
			
			_sprite_hero_prev_pos.x = _sprite_hero.x
			_sprite_hero_prev_pos.y = _sprite_hero.y;			
			
			if (FlxG.keys.pressed(_key_left)) {
				_sprite_hero.x -= FlxG.elapsed * Options.HERO_SPEED;
			}			
			
			if (FlxG.keys.pressed(_key_right)) {
				_sprite_hero.x += FlxG.elapsed * Options.HERO_SPEED;
			}	
			
			FlxU.overlap(_sprite_hero, _group_walls, overlapHandlerHeroWalls);
			FlxU.overlap(_sprite_hero, _group_doors, overlapHandlerHeroDoors);
			
			_sprite_hero_prev_pos.x = _sprite_hero.x
			_sprite_hero_prev_pos.y = _sprite_hero.y;			
			
			FlxU.overlap(_sprite_hero, _sprite_exit, overlapHandlerHeroExit);
			FlxU.overlap(_sprite_hero, _group_lights, overlapHandlerHeroLights);
			FlxU.overlap(_sprite_hero, _sprite_button_01, overlapHandlerHeroButton01);
			FlxU.overlap(_sprite_hero, _sprite_button_02, overlapHandlerHeroButton02);
			FlxU.overlap(_sprite_hero, _sprite_button_03, overlapHandlerHeroButton03);
			
			if (_light_exit.health == 100) {
				_light_exit.radius -= Options.LIGHT_EXIT_SPEED;
			}
			
			if (_light_exit.radius <= Options.LIGHT_AMOUNT_EXIT_DEFAULT_MIN) {
				_light_exit.health = 50;
			}
			
			if (_light_exit.health == 50) {
				_light_exit.radius += Options.LIGHT_EXIT_SPEED;
			}

			if (_light_exit.radius >= Options.LIGHT_AMOUNT_EXIT_DEFAULT_MAX) {
				_light_exit.health = 100;
			}
			
			_light_hero.radius -= Options.LIGHT_SPEED;
			if (_light_hero.radius <= 25) {
				Options.LIGHT_SPEED = 0.5;
			}
			
			if (_light_hero.radius <= 0) {
				_group_all.kill();
				FlxG.state = new GameOver();
			}			
		}
		
		private function overlapHandlerHeroWalls(hero :FlxSprite, wall :FlxSprite) :void {						
			_sprite_hero.x = _sprite_hero_prev_pos.x;
			_sprite_hero.y = _sprite_hero_prev_pos.y;
			
			_light_hero.x = _sprite_hero.x + Options.WALL_SIZE / 2 / 2;
			_light_hero.y = _sprite_hero.y + Options.WALL_SIZE / 2 / 2;			
		}
		
		private function overlapHandlerHeroDoors(hero :FlxSprite,door :FlxSprite) :void {
			//_sprite_hero.x = _sprite_hero_prev_pos.x;
			_sprite_hero.y = _sprite_hero_prev_pos.y;	
			
			_light_hero.x = _sprite_hero.x + Options.WALL_SIZE / 2 / 2;
			_light_hero.y = _sprite_hero.y + Options.WALL_SIZE / 2 / 2;			
		}		
		
		private function overlapHandlerHeroLights(hero :FlxSprite, light :FlxSprite) :void {
			_lights[light.x.toString() + light.y.toString()].kill();
			light.kill();
			_sound_light.play();
			_light_hero.radius += Options.LIGHT_CAPACITY;
			if (_light_hero.radius > Options.LIGHT_AMOUNT_DEFAULT) {
				_light_hero.radius = Options.LIGHT_AMOUNT_DEFAULT;
			}
			
			Options.LIGHT_AMOUNT += Options.LIGHT_CAPACITY;
			if (Options.LIGHT_AMOUNT > Options.LIGHT_AMOUNT_DEFAULT) {
				Options.LIGHT_AMOUNT = Options.LIGHT_AMOUNT_DEFAULT;
			}
		}	
		
		private function overlapHandlerHeroExit(hero :FlxSprite, exit :FlxSprite) :void {			
			_sound_exit.play();
			nextLevel();
		}		
		
		private function overlapHandlerHeroButton01(hero :FlxSprite, button :FlxSprite) :void {			
			if (_sprite_door_01.dead == false) {
				_sound_door.play();
			}
			_sprite_door_01.kill();
			button.loadGraphic(img_button_d);
		}
		
		private function overlapHandlerHeroButton02(hero :FlxSprite, button :FlxSprite) :void {			
			if (_sprite_door_02.dead == false) {
				_sound_door.play();
			}			
			_sprite_door_02.kill();
			button.loadGraphic(img_button_d);
		}
		
		private function overlapHandlerHeroButton03(hero :FlxSprite, button :FlxSprite) :void {			
			if (_sprite_door_03.dead == false) {
				_sound_door.play();
			}			
			_sprite_door_03.kill();
			button.loadGraphic(img_button_d);
		}		
	}
}