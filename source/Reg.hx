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
  //public static var endowment:Float;
  //public static var wealthyDonors:Int;
  //public static var studentHappiness:Int;

  // Flags are booleans that can be used for preconditions.
  // An unset flag is assumed to be false.
  public static var flags:Map<String, Bool>;
  // Scores include endowment, student approval, wealthy donors
  public static var score:Map<String, Float>;

  public static var framesPerMonth = 108; // 60 * 1.8

  /**
   * Generic bucket for storing different FlxSaves.
   * Especially useful for setting up multiple save slots.
   */
  public static var saves:Array<FlxSave> = [];
}

