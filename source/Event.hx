package;

class Event {
  public var titleText(default, null):String;
  public var flavorText(default, null):String;
  public var conditions(default, null):Array<Condition>;
  public var outcomes(default, null):Array<Outcome>;
  // Mean Time To Happen in frames
  private var _mtth:Float;

  public function getMtth():Float {
    var mtth = this._mtth;
    for (cond in this.conditions) {
      var mod = cond.getMtthMod();
      if (mod < 0) {
        return -1.0;
      } else {
        mtth /= mod;
      }
    }

    return mtth;
  }

  // baseMtth in months
  public function new(titleText:String, flavorText:String, baseMtth:Float) {
    this.flavorText = flavorText;
    this.titleText = titleText;
    this.outcomes = new Array<Outcome>();
    this.conditions = new Array<Condition>();
    this._mtth = baseMtth * Reg.framesPerMonth;
  }

  public function addOutcome(outcome:Outcome):Void {
    outcomes.push(outcome);
  }

  public function addCondition(condition:Condition):Void {
    conditions.push(condition);
  }
}

