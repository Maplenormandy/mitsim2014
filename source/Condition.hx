package;

class Condition {
  public function getMtthMod():Float {
    return 1;
  }

  public static function parseCondition(string:String):Condition {
    return null;
  }
}

class FlagCondition extends Condition {
  private var flag:String;
  private var mtthMod:Float;

  public function new(flag:String, mtthMod:Float) {
    this.flag = flag;
    this.mtthMod = mtthMod;
  }

  public override function getMtthMod():Float {
    if (Reg.flags.exists(this.flag) || Reg.flags.get(this.flag) == false) {
      if (this.mtthMod < 0) {
        return this.mtthMod;
      } else {
        return 1;
      }
    } else {
      if (this.mtthMod < 0) {
        return 1;
      } else {
        return this.mtthMod;
      }
    }
  }
}

class RangeCondition extends Condition {
  private var lowerBound:Float;
  private var upperBound:Float;
  private var mtthMod:Float;
  private var value:String;
  public function new(value:String, lowerBound:Float, upperBound:Float, mtthMod:Float) {
    this.value = value;
    this.mtthMod = mtthMod;
    if (this.mtthMod < 0) {
      this.lowerBound = upperBound;
      this.upperBound = lowerBound;
    } else {
      this.lowerBound = lowerBound;
      this.upperBound = upperBound;
    }
  }

  public override function getMtthMod():Float {
    var v = Reg.score[this.value];
    if (this.lowerBound < this.upperBound) {
      if (v >= this.lowerBound && v < this.upperBound) {
        return this.mtthMod;
      } else {
        return 1;
      }
    } else {
      if (v >= this.lowerBound || v < this.upperBound) {
        return this.mtthMod;
      } else {
        return 1;
      }
    }
  }
}

