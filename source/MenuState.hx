package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;
import flixel.addons.ui.FlxUIState;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxUIState {
  private var _btnPlay:FlxButton;

  /**
   * Function that is called up when to state is created to set it up. 
   */
  override public function create():Void {
    // _xml_id = "state_menu";

    _btnPlay = new FlxButton(0, 0, "Play", clickPlay);
    _btnPlay.screenCenter();
    add(_btnPlay);

    super.create();
    FlxG.switchState(new PlayState());
  }

  private function clickPlay():Void {
    FlxG.switchState(new PlayState());
  }

  /**
   * Function that is called when this state is destroyed - you might want to 
   * consider setting all objects this state uses to null to help garbage collection.
   */
  override public function destroy():Void {
    _btnPlay = FlxDestroyUtil.destroy(_btnPlay);

    super.destroy();
  }

  /**
   * Function that is called once every frame.
   */
  override public function update():Void {
    super.update();
  }	
}
