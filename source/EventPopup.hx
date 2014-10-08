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

  public function new(event:Event) {
    this.event = event;

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
      var button:FlxUIButton = cast _ui.getAsset("btn" + i);
      button.label.text = this.event.outcomes[i].flavorText;
    }
  }

  public override function getEvent(id:String, target:Dynamic, data:Array<Dynamic>, ?params:Array<Dynamic>) {
    if (params != null && params.length > 0) {
      if (target != null && Std.is(target, FlxUIButton)) {
        if (id == "click_button") {
          var i:Int = cast params[0];
          this.event.outcomes[i].effect();
          close();
        } else if (id == "over_button") {
          var i:Int = cast params[0];
          this.effectText.text = this.event.outcomes[i].effectText;
        } else if (id == "out_button") {
          this.effectText.text = "";
        }
      }
    }
  }
}
