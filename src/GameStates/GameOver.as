package GameStates {
	import org.flixel.*;

	public class GameOver extends FlxState {
		public function GameOver() {
			super.create();
			var text :FlxText = new FlxText(210, 60, 100, "GAME OVER");
			text.scale = new FlxPoint(5, 5);
			add(text);
			var text2 :FlxText = new FlxText(60, 120, 200, "PRESS SPACE KEY TO RESTART LEVEL");
			add(text2);
		}
		
		override public function update() :void {
			super.update();
			
			if (FlxG.keys.justPressed("SPACE")) {
				Options.LEVEL--;
				FlxG.state = new Level();
			}
		}		
	}
}