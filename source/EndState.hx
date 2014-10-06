package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class EndState extends FlxState {
  private var _btnRestart:FlxButton;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void {
    _btnRestart = new FlxButton(0, 0, "Start Over", clickRestart);
    _btnRestart.screenCenter();
    add(_btnRestart);

		super.create();
	}

  private function clickRestart():Void {
    FlxG.switchState(new RestartState());
  }

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void {
    _btnRestart = FlxDestroyUtil.destroy(_btnRestart);

		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		super.update();
	}
}
