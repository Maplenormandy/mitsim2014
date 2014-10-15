package;

import Condition.RangeCondition;
import Condition.FlagCondition;

class EventManager {
  public var events(default, null):List<Event>;
  // A list of all the time outcomes there are
  public var timeOutcomes(default, null):List<Outcome>;

  public function new(events:List<Event>) {
    this.events = events;
    this.timeOutcomes = new List();
  }


  public function addDemoEvents():Void {
    // MTTH of 12 months, i.e. 12 seconds
    var e = new Event("Hexane Spill in 18", "Almost three whole gallons!", 16);
    e.addOutcome(new Outcome("-5 student approval", "Alert everyone on campus"));
    e.addOutcome(new Outcome("-200k endowment", "Clean it up"));
    e.addOutcome(new Outcome("-300mil endowment", "Ignore it (get sued)"));
    this.events.add(e);

    var e = new Event("Opportunity", "Hold a cupcake study break?", 10);
    e.addOutcome(new Outcome("+4 student approval; -1k endowment", "Yes"));
    e.addOutcome(new Outcome("-1 student approval", "No"));
    this.events.add(e);

    var e = new Event("Student falls through fraternity window", "Oops", 12);
    e.addOutcome(new Outcome("-700k endowment", "Let it slide (get sued)"));
    e.addOutcome(new Outcome("-30 student approval over 12 months", "Ban all frat parties"));
    e.addOutcome(new Outcome("-5 student approval; -15 wealthy donors", "Revoke charter"));
    this.events.add(e);

    var e = new Event("Dining is losing money", "$14 a meal is too cheap.", 16);
    e.addOutcome(new Outcome("-30 student approval over 12 months; +10 wealthy donors", "Make dining mandatory for everyone"));
    e.addOutcome(new Outcome("+500k endowment; -10 student approval", "Increase price"));
    this.events.add(e);

    var e = new Event("Decision Point!", "Do you buy CalTech?", 24);
    e.addOutcome(new Outcome("-2bil endowment", "Yes"));
    e.addOutcome(new Outcome("-3 wealthy donors", "No"));
    this.events.add(e);

    var e = new Event("Frat drops pledge through skylight", "Big Oops.", 16);
    e.addOutcome(new Outcome("-800k endowment; -5 wealthy donors", "Leave it (get sued)"));
    e.addOutcome(new Outcome("-5 student approval", "Revoke frat charter for hazing"));
    this.events.add(e);

    var e = new Event("FSILG office requests permission to regulate all student fun",
                      "Give Kraft some boxing gloves?", 16);
    e.addOutcome(new Outcome("-10 student approval over 12 months", "Approve"));
    e.addOutcome(new Outcome("-7 wealthy donors", "No"));
    this.events.add(e);

    var e = new Event("Alarming number of parents call about X", "What did they call about?", 14);
    e.addOutcome(new Outcome("-200k endowment", "Food poisoning at Masseeh"));
    e.addOutcome(new Outcome("-8 wealthy donors", "Ebola."));
    this.events.add(e);

    var e = new Event("Not the best", "MIT gets 2nd place in U. S. News ranking", 15);
    e.addOutcome(new Outcome("-1mil endowment", "Invest more in research"));
    e.addOutcome(new Outcome("-5bil endowment", "Buy the first place school, Harvard"));
    e.addOutcome(new Outcome("-5 wealthy donors", "Lame email about new STEM initiative"));
    this.events.add(e);

    var e = new Event("Bad weather", "Harvard closes for hurricane", 18);
    e.addOutcome(new Outcome("-800k endowment", "Close MIT too"));
    e.addOutcome(new Outcome("-5 wealthy donors; -8 student approval", "Make everyone suffer."));
    this.events.add(e);

    var e = new Event("Good weather", "Really? In Boston?", 10);
    e.addOutcome(new Outcome("+3 student approval", "Great!"));
    this.events.add(e);

    var e = new Event("Alumni Event", "Host an alumni event?", 14);
    e.addOutcome(new Outcome("-300k endowment; +5 wealthy donors", "Yes"));
    e.addOutcome(new Outcome("-3 wealthy donors", "No"));
    this.events.add(e);

    var e = new Event("No Sleep", "Students tired after CPW", 18);
    e.addOutcome(new Outcome("-5 wealthy donors; -5 student approval", "Only \"approve\" MIT sanctioned events"));
    e.addOutcome(new Outcome("-8 student approval", "Only allow events before 1 AM"));
    this.events.add(e);

    var e = new Event("Asbestos", "Discovered in East Campus", 18);
    e.addOutcome(new Outcome("-600k endowment", "Leave it (get sued)"));
    e.addOutcome(new Outcome("+5 student approval; -700k endowment", "Fix it"));
    this.events.add(e);

    var e = new Event("Asbestos", "Discovered in Masseeh Dining", 21);
    e.addOutcome(new Outcome("-900k endowment", "Leave it (get sued)"));
    e.addOutcome(new Outcome("+8 student approval; -1mil endowment", "Fix it"));
    this.events.add(e);

    var e = new Event("Asbestos", "Discovered in literally everything", 24);
    e.addOutcome(new Outcome("-1mil endowment", "Leave it (get sued)"));
    e.addOutcome(new Outcome("+8 wealthy donors; -700k endowment", "Fix it"));
    this.events.add(e);

    var e = new Event("Hack!", "Someone impersonates Reif's Email", 20);
    e.addOutcome(new Outcome("+5 student approval; -4 wealthy donors", "Call it a good hack"));
    e.addOutcome(new Outcome("-6 student approval; +4 wealthy donors", "Make the perpetrator publicly apologize"));
    this.events.add(e);

    var e = new Event("Shadowy MIT Corporation declares new policy direction", "The stars aligned just the right way last night", 20);
    e.addOutcome(new Outcome("+500k endowment", "Accept it"));
    e.addOutcome(new Outcome("+500k endowment", "Accept it"));
    this.events.add(e);

    // This event and the next one shows how to use flags to control which events
    // fire or not.
    var e = new Event("Parents actually see Bexley", "Banging Unicorns on the walls!", 24);
    e.addCondition(new FlagCondition("bexley closed", true, -1));
    e.addOutcome(new Outcome("-7 student approval; -30 wealthy donors; bexley closed", "Close it down"));
    e.addOutcome(new Outcome("-12 student approval; -200k endowment", "Paint the walls white"));
    this.events.add(e);

    var e = new Event("Donors clamor for Bexley", "They want it reopened", 16);
    e.addCondition(new FlagCondition("bexley closed", false, -1));
    // Note that you can't currently unset flags
    e.addOutcome(new Outcome("-4 wealthy donors", "Can't do anything"));
    this.events.add(e);


    // This event shows how to use timed flags to prevent it from occuring
    // too often.
    var e = new Event("Opportunity", "Give $100 in BTC to every student?", 12);
    // If "bitcoin palooza" is true, then don't fire this event
    e.addCondition(new FlagCondition("bitcoin palooza", true, -1));
    e.addOutcome(new Outcome("+10 student approval; +15 wealthy donors; -1mil endowment; bitcoin palooza for 6 months", "Yes"));
    e.addOutcome(new Outcome("-2 student approval", "No"));
    this.events.add(e);


    // This event chain shows how timed flags can be used to make interesting
    // choices, i.e. between taking immediate action vs. not.
    var e = new Event("Foot Transmitted Disease Outbreak", "All of East Campus in panic!", 12);
    e.addCondition(new FlagCondition("FTDs rampant", true, -1));
    e.addOutcome(new Outcome("-8 wealthy donors; -8 student approval", "Make shoes mandatory"));
    e.addOutcome(new Outcome("FTDs rampant for 6 months", "Ignore it"));
    this.events.add(e);

    var e = new Event("Parent Sues over Foot Transmitted Disease", "It's all over the New York Times", 12);
    e.addCondition(new FlagCondition("FTDs rampant", false, -1));
    e.addOutcome(new Outcome("-2mil endowment; -10 wealthy donors", "Settle out of court"));
    e.addOutcome(new Outcome("-4mil endowment over 24 months; -20 wealthy donors", "Fight it in courts"));
    this.events.add(e);
  }

  // Should be called every frame. Runs timed outcomes and returns which event
  // should be played this frame, if any.
  public function poll():Null<Event> {

    // First, run time effects

    // Make a list to keep track of timed outcomes that haven't finished yet
    var newTimeOutcomes:List<Outcome> = new List();
    for (o in timeOutcomes) {
      // Change scores by the (precalculated) value the outcome specifies
      for (v in o.timeScoreValues.keys()) {
        Reg.score[v] += o.timeScoreValues[v];
      }

      // Check whether or not the timed outcome has finished
      o.timeLeft -= 1;
      if (o.timeLeft > 0) {
        newTimeOutcomes.add(o);
      } else {
        trace(o.timeEffectText);
        // If the timed outcome is finished, remove all the flags it had
        for (flag in o.timeFlags) {
          Reg.flags[flag] = false;
        }
      }
    }
    timeOutcomes = newTimeOutcomes;

    // Next, check which event is next up and return it
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

