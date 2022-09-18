class TileLoader {
	static var loader:Null<TileLoader>;

	var tileMap:h2d.Tile;
	var tiles:Array<h2d.Tile>;

	function new() {
		tileMap = hxd.Res.img.tilemap_packed.toTile();
		var tileWidth = 16;
		var tileHeight = 16;
		var width = tileMap.width / tileWidth;
		var height = tileMap.height / tileHeight;

		tiles = [
			for (y in 0...Std.int(height))
				for (x in 0...Std.int(width))
					tileMap.sub(x * tileWidth, y * tileHeight, tileWidth, tileHeight)
		];
	}

	static function GetLoader():TileLoader {
		if (loader == null) {
			loader = new TileLoader();
		}
		return loader;
	}

	public static function TileGroup():h2d.TileGroup {
		return new h2d.TileGroup(GetLoader().tileMap);
	}

	public static function King():h2d.Tile {
		return GetLoader().tiles[23 * 3 + 22];
	}

	public static function Grass():h2d.Tile {
		return GetLoader().tiles[0];
	}

	public static function Guard():h2d.Tile {
		return GetLoader().tiles[23 * 6 + 21];
	}
}
