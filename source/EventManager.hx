package;

import Condition.RangeCondition;
import Condition.FlagCondition;

class EventManager {
  public var events(default, null):List<Event>;
  public var timeOutcomes(default, null):List<Outcome>;

  public function new(events:List<Event>) {
    this.events = events;
    this.timeOutcomes = new List();
  }


  public function addDemoEvents():Void {
    // MTTH 1000 frames
    var e = new Event("Too Much Money!", "Swimming in it", 250);
    e.addOutcome(new Outcome("-500k endowment", "Okay"));
    // Make it only happen after 1 mil
    e.addCondition(new RangeCondition("endowment", 1e6, 1e10, -1));
    // Make it 1.2x as likely after 2 mil
    e.addCondition(new RangeCondition("endowment", 2e6, 1e10, 1.2));
    // Make it 1.5x as likely after 4 mil (stacks w/ 1.2x)
    e.addCondition(new RangeCondition("endowment", 4e6, 1e10, 1.5));

    this.events.add(e);

    var e = new Event("Talk Like a Pirate", "Blub blub blub", 500);
    e.addOutcome(new Outcome("+100 wealthy donors; -1mil endowment", "Yar"));
    e.addOutcome(new Outcome("-20 wealthy donors; +1mil endowment", "Nah"));
    e.addOutcome(new Outcome("+500k endowment", "Nay"));
    this.events.add(e);


    var e = new Event("Foot Transmitted Disease Outbreak", "All of East Campus in panic!", 1000);
    e.addOutcome(new Outcome("-20 wealthy donors; -8 student approval", "Make shoes mandatory"));
    e.addOutcome(new Outcome("-120mil endowment", "Ignore it (get sued)"));
    this.events.add(e);

    var e = new Event("Hexane Spill in 18", "Almost three whole gallons!", 500);
    e.addOutcome(new Outcome("-5 student approval", "Personally alert everyone on campus"));
    e.addOutcome(new Outcome("-200k endowment", "Clean it up"));
    e.addOutcome(new Outcome("-300mil endowment", "Ignore it (get sued)"));
    this.events.add(e);

    var e = new Event("Opportunity", "Give $100 in BTC to every student?", 500);
    e.addOutcome(new Outcome("+10 student approval; +15 wealthy donors; -1mil endowment", "Yes"));
    e.addOutcome(new Outcome("-2 student approval", "No"));
    this.events.add(e);

    var e = new Event("Opportunity", "Hold a cupcake study break?", 800);
    e.addOutcome(new Outcome("+4 student approval; -1k endowment", "Yes"));
    e.addOutcome(new Outcome("-1 student approval", "No"));
    this.events.add(e);

    var e = new Event("Student falls through fraternity window", "Oops", 700);
    e.addOutcome(new Outcome("-700k endowment", "Let it slide (get sued)"));
    e.addOutcome(new Outcome("-10 student approval; +50k endowment", "Ban all frat parties"));
    e.addOutcome(new Outcome("-2 student approval; -15 wealthy donors", "Revoke charter"));
    this.events.add(e);

    var e = new Event("Parents actually see Bexley", "Oops", 1000);
    e.addCondition(new FlagCondition("bexley closed", true, -1));
    e.addOutcome(new Outcome("-7 student approval; -30 wealthy donors; bexley closed", "Close it down"));
    e.addOutcome(new Outcome("-12 student approval; -200k endowment", "Paint the walls white"));
    this.events.add(e);

    var e = new Event("Donors clamor for Bexley", "They want it reopened", 1000);
    e.addCondition(new FlagCondition("bexley closed", false, -1));
    // Note that you can't currently unset flags
    e.addOutcome(new Outcome("-5 wealthy donors", "Can't do anything"));
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

