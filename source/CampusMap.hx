package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAngle;

class CampusMap extends FlxSprite
{
    public var speed:Float = 400;

    public function new(X:Float=0, Y:Float=0)
    {
        super(X, Y);
        makeGraphic(16, 16, FlxColor.BLUE);

        drag.x = drag.y = 1000;

        this.loadGraphic(AssetPaths.campusmap__png);
    }

    private function movement():Void
    {
      var _up:Bool = false;
      var _down:Bool = false;
      var _left:Bool = false;
      var _right:Bool = false;
      _up = FlxG.keys.anyPressed(["UP", "W"]);
      _down = FlxG.keys.anyPressed(["DOWN", "S"]);
      _left = FlxG.keys.anyPressed(["LEFT", "A"]);
      _right = FlxG.keys.anyPressed(["RIGHT", "D"]);

      if (_up && _down)
        _up = _down = false;
      if (_left && _right)
        _left = _right = false;

      if ( _up || _down || _left || _right) {
        velocity.x = this.speed;
        velocity.y = this.speed;

        var mA:Float = 0;
        if (_down)
        {
            mA = -90;
            if (_left)
                mA += 45;
            else if (_right)
                mA -= 45;
        }
        else if (_up)
        {
            mA = 90;
            if (_left)
                mA -= 45;
            else if (_right)
                mA += 45;
        }
        else if (_left)
            mA = 0;
        else if (_right)
            mA = 180;
        FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity);

      }
    }

    override public function update():Void {
      movement();
      super.update();
    }
}