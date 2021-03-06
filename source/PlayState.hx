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
  public var moneyText:FlxUIText;
  public var donorsText:FlxUIText;
  public var studentHappinessText:FlxUIText;
  public var calendarText:FlxUIText;

  // Temporary variable
  private var _showed:Bool;

  public var eventManager:EventManager;

  public var oldEndowment:Float;
  public var oldStudentApproval:Float;
  public var oldWealthyDonors:Float;

  private var _frameCount : Int = 0;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void {

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
    this.calendarText = cast _ui.getAsset("calendar", true);

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

  private function getCalendarText(monthsElapsed : Float) : String {
    var seasons = ["Fall", "Winter", "Spring", "Summer"];
    var yearStart = 2012.0;
    var seasonsElapsed = Math.floor(monthsElapsed / 3);

    return seasons[seasonsElapsed % 4] + " " + Math.floor(yearStart + monthsElapsed / 12);
  }


  /**
   * Function that is called once every frame.
   */
  override public function update():Void {
    _frameCount += 1;

    var e = this.eventManager.poll();

    if (e != null) {
      openSubState(new EventPopup(e, this.eventManager));
    }


    this.moneyText.text = "$" + Std.int(Reg.score["endowment"]);
    this.donorsText.text = "Wealthy Donors: " + Std.int(Reg.score["wealthy donors"]);
    this.studentHappinessText.text = "Student Approval: " + Std.int(Reg.score["student approval"]) + "%";
    this.calendarText.text = getCalendarText(_frameCount / Reg.framesPerMonth);

    var deltaEndowment = (Reg.score["endowment"] - this.oldEndowment) * Reg.framesPerMonth;
    deltaEndowment = Std.int(deltaEndowment);
    var deltaStudentApproval = (Reg.score["student approval"] - this.oldStudentApproval) * Reg.framesPerMonth;
    deltaStudentApproval = Std.int(deltaStudentApproval * 10) / 10;

    if (deltaEndowment > 0) {
      this.moneyText.text += " (+" + deltaEndowment + ")";
    } else {
      this.moneyText.text += " (" + deltaEndowment + ")";
    }

    if (deltaStudentApproval > 0) {
      this.studentHappinessText.text += " (+" + deltaStudentApproval + ")";
    } else if (deltaStudentApproval < 0) {
      this.studentHappinessText.text += " (" + deltaStudentApproval + ")";
    }

    this.oldEndowment = Reg.score["endowment"];
    this.oldStudentApproval = Reg.score["student approval"];
    this.oldWealthyDonors = Reg.score["wealthy donors"];

    if (Reg.score["student approval"] <= 0) {
      lose("MIT burns to the ground in the largest student protest since the 70's");
    } else if (Reg.score["endowment"] < 0) {
      lose("Out of money, you are forced to sell MIT to CalTech to make ends meet");
    }

    Reg.score["endowment"] += Reg.score["wealthy donors"] * 10;

    super.update();
  }
}

