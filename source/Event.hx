package;

class Event {
  public var titleText(default, null):String;
  public var flavorText(default, null):String;
  public var outcomes(default, null):List<Outcome>;

  public function new(titleText:String, flavorText:String) {
    this.flavorText = flavorText;
    this.titleText = titleText;
    this.outcomes = new List<Outcome>();
  }

  public function addOutcome(outcome:Outcome):Void {
    outcomes.add(outcome);
  }
}
