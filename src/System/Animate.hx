package system;

import entity.Entity;

class Animate extends System {
	function applyModel(entity:entity.Entity) {}

	function applyView(entity:entity.Entity, dt:Float) {
		var sprite = cast(entity, component.Sprite);
		if (sprite.animation != null) {
			sprite.animation.update(dt);
		}
	}

	public function relevant(entity:Entity):Bool {
		return Std.isOfType(entity, component.Sprite);
	}
}
