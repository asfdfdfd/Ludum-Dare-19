package GameStates {
	import org.flixel.*;

	public class Success extends FlxState {
		public function Success() {
			super.create();
			var text :FlxText = new FlxText(250, 60, 100, "YOU WIN");
			text.scale = new FlxPoint(5, 5);
			add(text);
			var text2 :FlxText = new FlxText(70, 120, 200, "PRESS SPACE KEY TO RESTART GAME");
			add(text2);			
		}
		
		override public function update() :void {
			super.update();
			
			if (FlxG.keys.justPressed("SPACE")) {
				Options.LEVEL = -1;
				FlxG.state = new Level();
			}
		}		
	}
}