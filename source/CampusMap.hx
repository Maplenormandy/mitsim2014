package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxAngle;

class CampusMap extends FlxSprite
{
    public var speed:Float = 500;
    private var overlays:Array<MapOverlay>;

    private var originalX:Float;
    private var originalY:Float;

    public function new(X:Float=0, Y:Float=0, overlays:Array<MapOverlay>,
                                              positions:Array<FlxPoint>)
    {
        super(X, Y);

        drag.x = drag.y = 1400;
        this.overlays = overlays;

        this.originalX = X;
        this.originalY = Y;

        this.loadGraphic(AssetPaths.campusmap__png);

        for (i in 0...this.overlays.length) {
          this.overlays[i].setAlpha(0.0);
          this.stamp(this.overlays[i], 1030, 700 + (110 * i));
        }
    }

    // KILLS PERFORMANCE. KILLS IT.
    private function zoom():Void
    {
      var _in:Bool = false;
      var _out:Bool = false;
      _in = FlxG.keys.anyPressed([">", "E"]);
      _out = FlxG.keys.anyPressed(["<", "Q"]);

      var prev_scale = this.scale;

      if (_in && _out) {
        _in = _out = false;
      } else if (_in) {
        this.scale = this.scale.add(0.01, 0.01);
      } else if (_out) {
        this.scale = this.scale.add(-0.01, -0.01);
      }
    }

    private function highlightControl():Void
    {
      var hi:Bool = false;
      hi = FlxG.keys.anyPressed(["Y"]);
      if (hi) {
        this.buildingHighlight(0);
      }
      hi = FlxG.keys.anyPressed(["U"]);
      if (hi) {
        this.buildingHighlight(1);
      }
      hi = FlxG.keys.anyPressed(["I"]);
      if (hi) {
        this.buildingHighlight(2);
      }
      hi = FlxG.keys.anyPressed(["O"]);
      if (hi) {
        this.buildingHighlight(3);
      }
      hi = FlxG.keys.anyPressed(["P"]);
      if (hi) {
        this.buildingHighlight(4);
      }

    }


    private function buildingHighlight(i:Int, on:Bool=true):Void
    {
      if (on) {
        this.overlays[i].setAlpha(0.3);
      } else {
        this.overlays[i].setAlpha(0.0);
      }
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
      //zoom();
      highlightControl();
      super.update();
    }
}
