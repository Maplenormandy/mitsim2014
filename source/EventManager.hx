package;

import Condition.EndowmentRange;

class EventManager {
  public var events(default, null):List<Event>;

  public function new(events:List<Event>) {
    this.events = events;
  }


  public function addDemoEvents():Void {
    // MTTH 500 frames
    var e = new Event("Too Much Money!", "Swimming in it", 500);
    e.addOutcome(new Outcome("-500k endowment", "Okay"));
    // Make it only happen after 1 mil
    e.addCondition(new EndowmentRange(1e6, 1e10, -1));
    // Make it twice as likely after 2 mil
    e.addCondition(new EndowmentRange(2e6, 1e10, 2));
    // Make it thrice as likely after 4 mil (stacks w/ 2x)
    e.addCondition(new EndowmentRange(4e6, 1e10, 3));

    this.events.add(e);

    var e = new Event("Talk Like a Pirate", "Blub blub blub", 500);
    e.addOutcome(new Outcome("+100 wealthy donors; -1mil endowment", "Yar"));
    e.addOutcome(new Outcome("-10 wealthy donors; +1mil endowment", "Nah"));
    e.addOutcome(new Outcome("+500k endowment", "Nay"));

    this.events.add(e);

  }

  public function poll():Event {
    for (e in events) {
      var mtth = e.getMtth();
      if (mtth < 0) {
        continue;
      }
      if (Math.random()*mtth < 1) {
        return e;
      }
    }
    return null;
  }
}

