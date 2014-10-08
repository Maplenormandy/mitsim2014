package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class EndState extends FlxUIState {
  private var _btnRestart:FlxButton;
  private var _txtRestart:FlxText;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void {
    _btnRestart = new FlxButton(0, 0, "Start Over", clickRestart);
    _btnRestart.screenCenter();
    _btnRestart.y = FlxG.height * 2 / 3;

    _txtReason = new FlxText(FlxG.width / 2, FlxG.height / 3, 0, "Guess you're terrible", 12A
    _txtReason.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1););
    _txtReason.alignment = "center";

    add(_btnRestart);
    add(_txtReason);

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
