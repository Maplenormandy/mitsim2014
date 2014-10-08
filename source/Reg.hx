package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg {
  /**
   * Scores go here
   */
  public static var endowment:Float;
  public static var wealthyDonors:Int;
  public static var studentHappiness:Int;

  public static var flags:Map<String, Bool>;

  /**
   * Generic bucket for storing different FlxSaves.
   * Especially useful for setting up multiple save slots.
   */
  public static var saves:Array<FlxSave> = [];
}

