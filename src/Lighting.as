package {
	import flash.text.engine.JustificationStyle;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	
	public class Lighting extends FlxGroup {
		private var _scale_factor :Number = 0;
		private var _darkness :FlxSprite = null;
		
		private var _real_width :uint = 0;
		private var _real_height :uint = 0;
		
		private var _scaled_width :uint = 0;
		private var _scaled_height :uint = 0;
		
		private var _lighting_sprite :FlxSprite = null;
		
		private var _lights :Array = null;
		
		public function Lighting(width :uint, height :uint, quality :Number, lighting_sprite :FlxSprite) {
			_lighting_sprite = lighting_sprite;
			_scale_factor = quality;
			
			_lights = new Array();
			
			_real_width = width;
			_real_height = height;
			
			_scaled_width = _real_width / _scale_factor;
			_scaled_height = _real_height / _scale_factor;
			
			var start_x :uint = _real_width / 2.0 - _scaled_width / 2.0;
			var start_y :uint = _real_height / 2.0 - _scaled_height / 2.0;
			
			_darkness = new FlxSprite(start_x, start_y);
			_darkness.scrollFactor = new FlxPoint();
			_darkness.blend = "multiply";
			_darkness.createGraphic(_scaled_width, _scaled_height, 0xff000000);
			
			_lighting_sprite.blend = "screen";
			_lighting_sprite.origin = new FlxPoint(0, 0);
		}
		
		public function createLight(x :uint, y :uint, radius :uint) :Light {
			var light :Light = new Light(x, y, radius);
			_lights.push(light);
			return light;
		}
		
		override public function render() :void {
			_darkness.scale = new FlxPoint(1, 1);
			_darkness.fill(0xff000000);
			
			for each (var light :Light in _lights) {
				if (!light.dead) {
					_lighting_sprite.scale = new FlxPoint(1, 1);
					
					var x :Number = light.getScreenXY().x / _scale_factor;
					var y :Number = light.getScreenXY().y / _scale_factor;
					var width :Number = light.width / _scale_factor;
					var height :Number = light.height / _scale_factor;
					
					var light_scale_x :Number = width / _lighting_sprite.width;
					var light_scale_y :Number = height / _lighting_sprite.height;
					
					_lighting_sprite.scale = new FlxPoint(light_scale_x, light_scale_y);
					
					_darkness.draw(_lighting_sprite, x - width / 2, y - height / 2);
				}
			}
			
			_darkness.scale = new FlxPoint(_scale_factor, _scale_factor);
			_darkness.render();
			
			super.render();
		}
		
		override public function update() :void {
			super.update();
		}
	}
}