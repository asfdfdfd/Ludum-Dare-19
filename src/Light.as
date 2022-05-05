package {
	import org.flixel.FlxObject;
	
	public class Light extends FlxObject {
		private var _radius :Number = 0;
		
		public function Light(x :uint, y :uint, radius :Number) {
			super(x, y, radius * 2, radius * 2);
			
			_radius = radius;
		}
		
		public function get radius() :Number {
			return _radius;
		}
		
		public function set radius(new_radius :Number) :void {
			_radius = new_radius;
			
			this.width = _radius * 2;
			this.height = _radius * 2;
		}
	}
}