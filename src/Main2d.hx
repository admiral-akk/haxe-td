class Main2d extends hxd.App {
	// var king:King;
	var target:h2d.Bitmap;
	var time:Float;

	var systems:Array<system.System>;
	var entities:Map<Int, entity.Entity>;
	var manager:SystemManager;

	override private function init():Void {
		super.init();
		time = 2;
		s2d.scaleMode = h2d.Scene.ScaleMode.LetterBox(512, 512);
		systems = new Array();
		entities = new Map();

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
				interaction.onClick = function(event:hxd.Event) {
					var tower = new Tower(x, y, map);
					map.PlaceTower(tower);
				}
				// tileGroup.add(x * tileWidth, y * tileHeight, ground);
			}
		// king = new King(20, 6, map);
		// map.addChild(king);

		manager = new SystemManager(map);

		manager.addSystem(new system.AttackTown(manager));
		manager.addSystem(new system.Animate(manager));
		manager.addSystem(new system.Movement(manager));
		manager.addEntity(new entity.King(0, 20, 6, map));
		for (x in 26...30)
			for (y in 6...10)
				manager.addEntity(new entity.Town(0, x, y, map));
	}

	override function update(dt:Float) {
		manager.updateView(dt);
		time -= dt;
		if (time < 0) {
			manager.updateModel();
			time += 2;
		}
	}

	static function main() {
		hxd.Res.initEmbed();
		new Main2d();
	}
}
