abstract class GameView extends h2d.Object {
	public var pos:Position;

	var image:h2d.Bitmap;

	abstract function GetTile():h2d.Tile;

	public function new(x:Int, y:Int, map:GameMap) {
		super();
		pos = new Position(x, y, map);
		map.addChild(this);
		image = new h2d.Bitmap(GetTile(), this);
		setPosition(x * image.getSize().width, y * image.getSize().height);
	}
}
