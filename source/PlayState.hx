package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIText;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxUIState {
  private var _campusMap:CampusMap;

  public var moneyText:FlxUIText;
  public var donorsText:FlxUIText;

  // Temporary variable
  private var _showed:Bool;

  /**
   * Function that is called up when to state is created to set it up. 
   */
  override public function create():Void {
    Reg.flags = new Map();

    Reg.endowment = 1e9;
    Reg.studentHappiness = 10;
    Reg.wealthyDonors = 100;

    _showed = false;
    _xml_id = "state_play";

    super.create();

    _campusMap = new CampusMap(20, 50);

    add(_campusMap);
    
    this.moneyText = cast _ui.getAsset("money", true);
    this.donorsText = cast _ui.getAsset("donors", true);

    FlxG.sound.playMusic("mit-theme", 1);
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
    if (!_showed) {
      var event = new Event("Test Event", "Ayyoooo", 100);
      event.addOutcome(new Outcome("+1 student happiness; -4k endowment", "aye"));
      event.addOutcome(new Outcome("-1 student happiness; +4k endowment", "nay"));
      openSubState(new EventPopup(event));
      _showed = true;
    }

    this.moneyText.text = "$" + Reg.endowment;
    this.donorsText.text = "Donors: " + Reg.wealthyDonors;

    if (Reg.studentHappiness < 0) {
      lose("MIT burns to the ground in the largest student protest since the 70's");
    } else if (Reg.endowment < 0) {
      lose("Out of money, you are forced to sell MIT to CalTech to make ends meet");
    }

    Reg.endowment += Reg.wealthyDonors * 100;

    super.update();
  }
}

