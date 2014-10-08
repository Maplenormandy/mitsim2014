package;

class Condition {
  public function getMtthMod():Float {
    return 1;
  }

  public static function parseCondition(string:String):Condition {
    return null;
  }
}

class RangeCondition extends Condition {
  private var lowerBound:Float;
  private var upperBound:Float;
  private var mtthMod:Float;
  public function new(lowerBound:Float, upperBound:Float, mtthMod:Float) {
    this.mtthMod = mtthMod;
    if (this.mtthMod < 0) {
      this.lowerBound = upperBound;
      this.upperBound = lowerBound;
    } else {
      this.lowerBound = lowerBound;
      this.upperBound = upperBound;
    }
  }

  public function value():Float {
    return null;
  }

  public override function getMtthMod():Float {
    if (this.lowerBound < this.upperBound) {
      if (this.value() >= this.lowerBound && this.value() < this.upperBound) {
        return this.mtthMod;
      } else {
        return 1;
      }
    } else {
      if (this.value() >= this.lowerBound || this.value() < this.upperBound) {
        return this.mtthMod;
      } else {
        return 1;
      }
    }
  }
}

class EndowmentRange extends RangeCondition {
  public function new(lowerBound:Float, upperBound:Float, mtthMod:Float) {
    super(lowerBound, upperBound, mtthMod);
  }
  public override function value():Float {
    return Reg.endowment;
  }
}
class StudentHappinessRange extends RangeCondition {
  public function new(lowerBound:Int, upperBound:Int, mtthMod:Float) {
    super(lowerBound, upperBound, mtthMod);
  }
  public override function value():Float {
    return Reg.studentHappiness;
  }
}
class DonorRange extends RangeCondition {
  public function new(lowerBound:Float, upperBound:Float, mtthMod:Float) {
    super(lowerBound, upperBound, mtthMod);
  }
  public override function value():Float {
    return Reg.wealthyDonors;
  }
}

