package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIText;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxUIState {
  private var _campusMap:CampusMap;

  public var moneyText:FlxUIText;
  public var donorsText:FlxUIText;
  public var studentHappinessText:FlxUIText;

  // Temporary variable
  private var _showed:Bool;

  public var eventManager:EventManager;

  public var oldEndowment:Float;
  public var oldStudentApproval:Float;
  public var oldWealthyDonors:Float;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void {
    // Overlays
    var overlay1 = new MapOverlay(100, 100);
    var overlay1pt = new FlxPoint(1030, 700);
    var overlay2 = new MapOverlay(100, 100);
    var overlay2pt = new FlxPoint(600, 700);
    var overlay3 = new MapOverlay(100, 100);
    var overlay3pt = new FlxPoint(1030, 850);
    var overlay4 = new MapOverlay(100, 100);
    var overlay4pt = new FlxPoint(700, 300);
    var overlay5 = new MapOverlay(100, 100);
    var overlay5pt = new FlxPoint(500, 670);
    var overlay6 = new MapOverlay(100, 100);
    var overlay6pt = new FlxPoint(400, 990);

    var _campusMap = new CampusMap(300, 200,
        [overlay1,
         overlay2,
         overlay3,
         overlay4,
         overlay5,
         overlay6],
          [overlay1pt,
           overlay2pt,
           overlay3pt,
           overlay4pt,
           overlay5pt,
           overlay6pt]);
    add(_campusMap);


    Reg.flags = new Map();
    Reg.score = new Map();

    this.eventManager = new EventManager(new List<Event>());
    this.eventManager.addDemoEvents();

    Reg.score["endowment"] = 2e6;
    this.oldEndowment = 2e6;
    Reg.score["student approval"] = 25;
    this.oldStudentApproval = 25;
    Reg.score["wealthy donors"] = 100;
    // Pun not intended
    this.oldWealthyDonors = 100;

    _showed = false;
    _xml_id = "state_play";

    super.create();

    var nameText : FlxUIText = cast _ui.getAsset("name", true);
    nameText.text = "Christopher Colombus";

    this.moneyText = cast _ui.getAsset("money", true);
    this.donorsText = cast _ui.getAsset("donors", true);
    this.studentHappinessText = cast _ui.getAsset("student-happiness", true);

    // Sound
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
    var e = this.eventManager.poll();

    if (e != null) {
      openSubState(new EventPopup(e));
    }

    var deltaEndowment = (Reg.score["endowment"] - this.oldEndowment) * 30;
    var deltaStudentApproval = (Reg.score["student approval"] - this.oldStudentApproval) * 30;

    this.moneyText.text = "$" + Reg.score["endowment"];
    this.donorsText.text = "Donors: " + Reg.score["wealthy donors"];
    this.studentHappinessText.text = "Student Approval: " + Reg.score["student approval"] + "%";

    this.oldEndowment = Reg.score["endowment"];
    this.oldStudentApproval = Reg.score["student approval"];
    this.oldWealthyDonors = Reg.score["wealthy donors"];

    if (Reg.score["student approval"] < 0) {
      lose("MIT burns to the ground in the largest student protest since the 70's");
    } else if (Reg.score["endowment"] < 0) {
      lose("Out of money, you are forced to sell MIT to CalTech to make ends meet");
    }

    Reg.score["endowment"] += Reg.score["wealthy donors"] * 10;

    super.update();
  }
}

