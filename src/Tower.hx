import h2d.Tile;

class Tower extends GameView {
	function GetTile():Tile {
		return TileLoader.Guard();
	}
}
