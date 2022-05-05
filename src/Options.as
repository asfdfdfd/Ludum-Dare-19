package {
	public class Options {
		public static var LEVEL :int = -1;
		public static const HERO_SPEED_DEFAULT :int = 50;
		public static var HERO_SPEED :int = Options.HERO_SPEED_DEFAULT;
		
		public static const WALL_SIZE :int = 16;
		
		public static const LIGHT_AMOUNT_DEFAULT :int = 60;
		public static var LIGHT_AMOUNT :int = LIGHT_AMOUNT_DEFAULT;
		
		public static const LIGHT_AMOUNT_EXIT_DEFAULT_MIN :int = 30;
		public static const LIGHT_AMOUNT_EXIT_DEFAULT :int = 70;
		public static const LIGHT_AMOUNT_EXIT_DEFAULT_MAX :int = 70;
		public static const LIGHT_EXIT_SPEED :Number = 0.5;
		public static var LIGHT_AMOUNT_EXIT :int = LIGHT_AMOUNT_EXIT_DEFAULT;
		
		public static const LIGHT_AMOUNY_LIGHT_DEFAULT :int = 40;
		public static var LIGHT_AMOUNY_LIGHT :int = LIGHT_AMOUNY_LIGHT_DEFAULT;
		
		public static const LIGHT_SPEED_DEFAULT :Number = 0.02;
		public static var LIGHT_SPEED :Number = LIGHT_SPEED_DEFAULT;
		public static const LIGHT_CAPACITY :int = 10;
		
		public static const MAP_ITEM_LIGHT :int = 1;
		public static const MAP_ITEM_WALL :int = 2;
		public static const MAP_ITEM_PLAYER :int = 3;
		public static const MAP_ITEM_DOOR1 :int = 4;
		public static const MAP_ITEM_BUTTON1 :int = -4;
		public static const MAP_ITEM_DOOR2 :int = 5;
		public static const MAP_ITEM_BUTTON2 :int = -5;
		public static const MAP_ITEM_DOOR3 :int = 6;
		public static const MAP_ITEM_BUTTON3 :int = -6;		
		public static const MAP_ITEM_EXIT :int = 7;
	}

}