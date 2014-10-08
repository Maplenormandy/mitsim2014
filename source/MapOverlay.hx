package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAngle;

class MapOverlay extends FlxSprite
{
  public var speed:Float = 500;

  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);

    makeGraphic(100, 100, FlxColor.YELLOW);
    this.alpha = 0.3;
  }

  public function setAlpha(newAlpha:Float) {
    this.alpha = newAlpha;
  }

  override public function update():Void {
    super.update();
  }
}
