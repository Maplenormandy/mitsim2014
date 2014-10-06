package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState {
	private var _map:CampusMap;

  /**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void {
    Reg.studentHappiness = 0;
    Reg.endowment = 0.0;

    var a1 = new Outcome("+1 student happiness; +$4k endowment", "");
    a1.effect();

    super.create();

    _map = new CampusMap(20, 20);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void {
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		super.update();
	}
}
