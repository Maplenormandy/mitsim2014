package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Rectangle {
  public var x:Float;
  public var y:Float;
  public var width:Int;
  public var height:Int;

  public function new(x:Float, y:Float, width:Int, height:Int)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
}

