import h2d.Tile;

class Spawn extends GameView {
	function GetTile():Tile {
		return TileLoader.Spawn();
	}
}
