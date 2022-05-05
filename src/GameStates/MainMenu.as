package GameStates {
	import org.flixel.*;
	
	public class MainMenu extends FlxState {		
		override public function create():void {
			super.create();
			var text :FlxText = new FlxText(270, 60, 100, "PLIXEL");
			text.scale = new FlxPoint(5, 5);
			add(text);
			var text2 :FlxText = new FlxText(90, 120, 200, "PRESS SPACE KEY TO START");
			add(text2);
			var text3 :FlxText = new FlxText(0, 220, 200, "(c) 2010 asfdfdfd");
			add(text3);			
			var text4 :FlxText = new FlxText(290, 220, 200, "v 0.1");
			add(text4);	
			Options.LEVEL = -1;
		}
		
		override public function update() :void {
			super.update();
			
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.state = new Level();
			}
		}
	}
}