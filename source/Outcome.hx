package;

class Outcome {
  public var flavorText(default, null):String;
  public var effectText(default, null):String;

  static var matchers:Map<String, EReg>;
  static var matchersT:Map<String, EReg>;

  static function __init__() {
    var variables = ["student approval", "endowment", "wealthy donors"];
    Outcome.matchers = new Map();
    Outcome.matchersT = new Map();
    for (v in variables) {
      var numMatcher = "([+-][0-9]+\\.?[0-9]*)(k|mil|bil)?";
      var timeMatcher = "over ([0-9]+) months";
      Outcome.matchers[v] = new EReg(numMatcher + " " + v, "i");
      Outcome.matchersT[v] = new EReg(numMatcher + " " + v + " " + timeMatcher, "i");
    }
  }

  public function new(effectText:String, flavorText:String) {
    this.flavorText = flavorText;
    this.effectText = effectText;
  }

  public function effect() {
    for (effect in effectText.split(";")) {
      for (v in Outcome.matchers.keys()) {
        var r = Outcome.matchers[v];
        if (r.match(effect)) {
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
          Reg.score[v] += val;
          break;
        }
      }
    }
  }

}

