package component;

@baseExtends(entity.Entity)
@mixin interface Location {
	public var pos:Position;

	public function moveEntity(end:Position):Void {
		pos.move(this, end);
	}
}
