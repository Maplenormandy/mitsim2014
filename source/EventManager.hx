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


    var e = new Event("Foot Transmitted Disease Outbreak", "All of East Campus in panic!", 1000);
    e.addOutcome(new Outcome("-10 wealthy donors; -8 student happiness", "Make shoes mandatory"));
    e.addOutcome(new Outcome("-120mil endowment", "Ignore it (get sued)")); 
    this.events.add(e);

    var e = new Event("Hexane Spill in 18", "Almost three whole gallons!", 500);
    e.addOutcome(new Outcome("-5 student happiness", "Personally alert everyone on campus"));
    e.addOutcome(new Outcome("-200k endowment", "Clean it up"));
    e.addOutcome(new Outcome("-300mil endowment", "Ignore it (get sued)")); 
    this.events.add(e);

    var e = new Event("Opportunity", "Give $100 in BTC to every student?", 500);
    e.addOutcome(new Outcome("+10 student happiness; +5 wealthy donors; -1mil endowment", "Yes"));
    e.addOutcome(new Outcome("-2 student happiness", "No"));
    this.events.add(e);

    var e = new Event("Opportunity", "Hold a cupcake study break?", 800);
    e.addOutcome(new Outcome("+4 student happiness; -1k endowment", "Yes"));
    e.addOutcome(new Outcome("-1 student happiness", "No"));
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

