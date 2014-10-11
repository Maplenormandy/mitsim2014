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
  private var value:Bool;
  private var mtthMod:Float;
  
  // Literally, if flag == value, then return mtthMod
  public function new(flag:String, value:Bool, mtthMod:Float) {
    this.flag = flag;
    this.value = value;
    this.mtthMod = mtthMod;
  }

  public override function getMtthMod():Float {
    if (Reg.flags.get(this.flag) == true) {
      if (this.value) {
        return this.mtthMod;
      } else {
        return 1;
      }
    } else {
      if (this.value) {
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

