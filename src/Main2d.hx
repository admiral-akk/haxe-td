import creep.King;

class Main2d extends hxd.App {
	var king:King;
	var target:h2d.Bitmap;
	var time:Float;

	override private function init():Void {
		super.init();
		s2d.scaleMode = h2d.Scene.ScaleMode.LetterBox(512, 512);

		var top_ui = new h2d.Object(s2d);
		var font:h2d.Font = hxd.res.DefaultFont.get();
		var tf = new h2d.Text(font);
		tf.text = "Lives: 10";
		tf.textAlign = Left;
		top_ui.addChild(tf);
		var tf2 = new h2d.Text(font);
		tf2.text = "Gold: 10";
		tf2.setPosition(512, 0);
		tf2.textAlign = Right;
		top_ui.addChild(tf2);

		var game = new h2d.Object(s2d);
		game.setPosition(0, 128);
		var bottom_ui = new h2d.Object(s2d);

		bottom_ui.setPosition(0, 512 - 128);

		var tileWidth = 16;
		var tileHeight = 16;

		var map = new GameMap();
		game.addChild(map);
		target = new h2d.Bitmap(TileLoader.Guard(), map);

		// add to any parent, in this case we append to root
		for (y in 0...16)
			for (x in 0...32) {
				var selectObject = new h2d.Object(map);
				selectObject.setPosition(x * tileWidth, y * tileHeight);
				var interaction = new h2d.Interactive(16, 16, selectObject);
				interaction.onOver = function(event:hxd.Event) {
					trace("Over " + x + " " + y);
					target.alpha = 0.6;
					target.setPosition(x * 16, y * 16);
				}

				interaction.onOut = function(event:hxd.Event) {
					trace("out " + x + " " + y);
					target.alpha = 0.;
				}
				// tileGroup.add(x * tileWidth, y * tileHeight, ground);
			}
		king = new King(0, 0);
		map.addChild(king);
	}

	override function update(dt:Float) {
		king.viewUpdate(dt);
		time -= dt;
		if (time < 0) {
			king.gameUpdate();
			time += 2;
		}
	}

	static function main() {
		hxd.Res.initEmbed();
		new Main2d();
	}
}
