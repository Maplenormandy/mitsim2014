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

    for (var evt : EventJsonObject in jsonObject.events) {
      events.add(new Event(
            evt.title,
            evt.flavor,
            new Outcome(evt.outcome.effect, evt.outcome.flavor)
      ))
    }

    return events;
  }
