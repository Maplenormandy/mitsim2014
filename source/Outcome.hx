package;

class Outcome {
  public var flavorText(default, null):String;
  public var effectText(default, null):String;

  static var matchers:Map<String, EReg>;
  static var timeMatcherScore:EReg;
  static var timeMatcherFlags:EReg;
  static var stripMatcher:EReg;

  static function __init__() {
    var variables = ["student approval", "endowment", "wealthy donors"];
    Outcome.matchers = new Map();
    Outcome.timeMatcherScore = new EReg(" over ([0-9]+) months", "i");
    Outcome.timeMatcherFlags = new EReg(" for ([0-9]+) months", "i");
    Outcome.stripMatcher = new EReg("^ ", "i");

    for (v in variables) {
      var numMatcher = "([+-][0-9]+\\.?[0-9]*)(k|mil|bil)?";
      Outcome.matchers[v] = new EReg(numMatcher+" "+v, "i");
    }
  }

  public function new(effectText:String, flavorText:String) {
    this.flavorText = flavorText;
    this.effectText = effectText;
  }

  public function getNumber(r:EReg):Float {
    var val = Std.parseFloat(r.matched(1));
    switch(r.matched(2)) {
      case "k":
        val *= 1e3;
      case "mil":
        val *= 1e6;
      case "bil":
        val *= 1e9;
      default:
        //
    }
    return val;
  }

  public function effect() {
    for (effect in effectText.split(";")) {
      var matched:Bool = false;

      var time:Int = -1;

      // Match possible time effect
      if (Outcome.timeMatcherScore.match(effect)) {
        time = Std.parseInt(Outcome.timeMatcherScore.matched(1));
      } else if (Outcome.timeMatcherFlags.match(effect)) {
        time = Std.parseInt(Outcome.timeMatcherFlags.matched(1));
      }

      // Match score effects
      for (v in Outcome.matchers.keys()) {
        var r = Outcome.matchers[v];
        if (r.match(effect)) {
          trace("score: " + v);
          if (time < 0) {
            Reg.score[v] += this.getNumber(r);
          } else {
            trace(time);
            // Do stuff
          }

          matched = true;
          break;
        }
      }
     
      if (matched) {
        continue;
      }

      // Match flag effects
      var flag:String = Outcome.timeMatcherFlags.replace(effect, "");
      flag = Outcome.stripMatcher.replace(flag, "");
      trace("flag: " + flag);
      
      if (time < 0) {
        Reg.flags[flag] = true;
      } else {
        trace(time);
        // Do stuff
      }
    }

  }

}

