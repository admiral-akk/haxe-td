import h2d.Tile;

class Building extends GameView {
	function GetTile():Tile {
		return TileLoader.Town();
	}
}
