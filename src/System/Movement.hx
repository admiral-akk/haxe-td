package system;

import entity.Entity;
import animation.MoveAnimation;

class Movement extends System {
	function applyModel(entity:entity.Entity) {
		var location = cast(entity, component.Location);
		var creep = cast(entity, component.Creep);
		var sprite = cast(entity, component.Sprite);
		var next = creep.pathfinder.Move(location.pos);
		sprite.animation = new MoveAnimation(sprite.image, location.pos, next, 1.);
		location.moveEntity(next);
	}

	function applyView(entity:entity.Entity, dt:Float) {}

	public function relevant(entity:Entity):Bool {
		return Std.isOfType(entity, component.Sprite) && Std.isOfType(entity, component.Creep) && Std.isOfType(entity, component.Location);
	}
}
