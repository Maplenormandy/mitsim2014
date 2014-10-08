package;

import haxe.Json;

typedef OutcomeJsonObject = {
  var effect: String;
  var flavor: String;
}

typedef EventJsonObject = {
  var title: String;
  var flavor: String;
  var outcomes: List<OutcomeJsonObject>;
}

typedef EventsJsonObject = {
  var events: List<EventJsonObject>;
}

class EventParser {
  public function parse(text: String): List<Event> {
    var jsonObject : EventsJsonObject = Json.parse(text);
    var events : List<Event>;

    for (event : EventJsonObject in jsonObject.events) {
      var outcomes : List<Outcome>;
      var event : Event = new Event(event.title, event.flavor);

      for (outcome : OutcomeJsonObject in event.outcomes) {
        event.addOutcome(new Outcome(
              outcome.effect,
              outcome.flavor
        ));
      }
      events.add(event);
    }

    return events;
  }
