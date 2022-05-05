package {
	import GameStates.GameOver;
	import GameStates.MainMenu;
	import GameStates.Success;
	import org.flixel.*;

	public class Main extends FlxGame {
		public function Main() :void {
			super(320, 240, MainMenu, 2);
			//super(320, 240, GameOver, 2);
			//super(320, 240, Success, 2);
		}	
	}
}