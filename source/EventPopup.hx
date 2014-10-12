package;

import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUICursor;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIPopup;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.interfaces.IFlxUIWidget;

class EventPopup extends FlxUIPopup {
  public var event(default, null):Event;
  private var effectText(default, null):FlxUIText;
  public var eventManager(default, null):EventManager;

  public function new(event:Event, eventManager:EventManager) {
    this.event = event;
    this.eventManager = eventManager;

    super();
  }
  
  public override function create():Void {
    _xml_id = "popup_event";

    super.create();

    _ui.setMode("choice_" + this.event.outcomes.length);

    var titleText:FlxUIText = cast _ui.getAsset("title");
    titleText.text = this.event.titleText;
    var flavorText:FlxUIText = cast _ui.getAsset("flavor");
    flavorText.text = this.event.flavorText;

    this.effectText = cast _ui.getAsset("effect_text");

    for (i in 0 ... this.event.outcomes.length) {
      var j:Int = this.event.outcomes.length - i - 1;
      var button:FlxUIButton = cast _ui.getAsset("btn" + j);
      button.label.text = this.event.outcomes[i].flavorText;
    }
  }

  public override function getEvent(id:String, target:Dynamic, data:Array<Dynamic>, ?params:Array<Dynamic>) {
    if (params != null && params.length > 0) {
      if (target != null && Std.is(target, FlxUIButton)) {
        if (id == "click_button") {
          var i:Int = cast params[0];
          var j:Int = this.event.outcomes.length - i - 1;
          // If effect() returns true, then it's a timed effect.
          if (this.event.outcomes[j].effect()) {
            this.eventManager.timeOutcomes.add(this.event.outcomes[j]);
          }
          close();
        } else if (id == "over_button") {
          var i:Int = cast params[0];
          var j:Int = this.event.outcomes.length - i - 1;
          this.effectText.text = this.event.outcomes[j].effectText;
        } else if (id == "out_button") {
          this.effectText.text = "";
        }
      }
    }
  }
}
