package;

class EventManager {
  public var events(default, null):List<Event>;
  public var discard(default, null):List<Event>;

  public function new(events:List<Event>) {
    this.events = events;
  }

  public function poll():Event {
    return null;
  }
}
