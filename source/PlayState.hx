package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.addons.ui.FlxUIState;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxUIState {
  private var _campusMap:CampusMap;

  // Temporary variable
  private var _showed:Bool;

  /**
   * Function that is called up when to state is created to set it up. 
   */
  override public function create():Void {
    Reg.studentHappiness = 0;
    Reg.endowment = 0.0;

    _showed = false;

    super.create();

    _campusMap = new CampusMap(20, 20);
    add(_campusMap);
  }

  /**
   * Function that is called when this state is destroyed - you might want to
   * consider setting all objects this state uses to null to help garbage collection.
   */
  override public function destroy():Void {
    super.destroy();
  }

  /**
   * Lose for a specified reason
   */
  private function lose(reason:String):Void {
    var state : EndState = new EndState();
    state.reason = reason;
    FlxG.switchState(state);
  }


  /**
   * Function that is called once every frame.
   */
  override public function update():Void {
    if (Std.random(100) == 0 && !_showed) {
      var event = new Event("Test Event", "Ayyoooo");
      event.addOutcome(new Outcome("+1 student happiness; -4k endowment", "aye"));
      openSubState(new EventPopup(event));
      _showed = true;
    }

    if (Reg.studentHappiness < 0) {
      lose("MIT burns to the ground in the largest student protest since the 70's");
    } else if (Reg.endowment < 0) {
      lose("Out of money and wealthy alumni, you are forced to sell MIT to CalTech to make ends meet");
    }


    super.update();
  }
}

