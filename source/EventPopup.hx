package;

import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUICursor;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIPopup;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.interfaces.IFlxUIWidget;

class EventPopup extends FlxUIPopup {
    public override function create():Void {
        _xml_id = "popup_event";

        super.create();
    }

    public override function getEvent(id:String, target:Dynamic, data:Array<Dynamic>, ?params:Array<Dynamic>) {
        if (params != null && params.length > 0) {
            if (id == "click_button") {
                var i:Int = cast params[0];
                trace(i);
                close();
            }
        }
    }
}
