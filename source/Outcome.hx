package;

class Outcome {
  // Flavor text appears in the button for the choice
  public var flavorText(default, null):String;
  // Effect text appears at the bottom of the event popup
  public var effectText(default, null):String;

  // Time effect text is the equivalent of effect text for timed events.
  // This is populated by effect(), so don't edit it.
  public var timeEffectText(default, null):String;
  
  // Maps score => amount that score changes every frame,
  // i.e. "endowment" => 1 means increase endowment by 1 every frame
  public var timeScoreValues:Map<String, Float>;
  // List of flags that are active only for the timed amount.
  // For example, "bexley closed for 4 months" adds "bexley closed"
  // to this list so it can be unset at the end of 4 months
  public var timeFlags:List<String>;

  // This is how many frames are left for this time. Remember, 60 frames = 1 month
  // Also there can be only one time for each outcome.
  public var timeLeft:Int;

  // These are Regexes used by the effect() function. Don't worry about them
  static var matchers:Map<String, EReg>;
  static var timeMatcherScore:EReg;
  static var timeMatcherFlags:EReg;
  static var stripMatcher:EReg;

  // This initializes the Regexes above. Note that the list of scores, i.e.
  // endowment, student approval, etc... is here, and if you want to add a new one,
  // you have to do it here
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
    this.timeEffectText = "";
    this.timeFlags = new List();
    this.timeScoreValues = new Map();
  }

  // Helper function for parsing values, i.e. 4k or 5.6mil
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

  // Effects the outcome, then returns whether or not the effect is a
  // timed outcome.
  public function effect():Bool {
    var timed = false;

    for (effect in effectText.split(";")) {
      var matched:Bool = false;

      var time:Int = -1;

      // Match possible time effect. If no time effect, time stays at -1
      if (Outcome.timeMatcherScore.match(effect)) {
        time = Std.parseInt(Outcome.timeMatcherScore.matched(1));
      } else if (Outcome.timeMatcherFlags.match(effect)) {
        time = Std.parseInt(Outcome.timeMatcherFlags.matched(1));
      }

      // Match score effects
      for (v in Outcome.matchers.keys()) {
        var r = Outcome.matchers[v];
        if (r.match(effect)) {
          if (time < 0) {
            Reg.score[v] += this.getNumber(r);
          } else {
            timed = true;

            // Update the time effect text
            if (this.timeEffectText == "") {
              this.timeEffectText = effect;
            } else {
              this.timeEffectText += "; " + effect;
            }

            // Update the score 
            this.timeLeft = time * Reg.framesPerMonth;
            this.timeScoreValues[v] = this.getNumber(r) / this.timeLeft;
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
      
      if (time < 0) {
        Reg.flags[flag] = true;
      } else {
        timed = true;

        Reg.flags[flag] = true;
        
        // Update the time effect text
        if (this.timeEffectText == "") {
          this.timeEffectText = effect;
        } else {
          this.timeEffectText += "; " + effect;
        }

        this.timeFlags.add(flag);
        this.timeLeft = time * Reg.framesPerMonth;
      }
    }

    return timed;
  }

}

