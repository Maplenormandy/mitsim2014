package;

class Outcome {
    public var flavorText(default, null):String;
    public var effectText(default, null):String;

    public function new(effectText:String, flavorText:String) {
        this.flavorText = flavorText;
        this.effectText = effectText;
    }

    public function effect() {
        for (effect in effectText.split(";")) {
            var r = ~/([+-][0-9]+) student happiness/;
            if (r.match(effect)) {
                var val = Std.parseInt(r.matched(1));
                Reg.studentHappiness += val;
                trace(Reg.studentHappiness);
                continue;
            }

            r = ~/([+-])([0-9]+\.?[0-9]*)(k|mil|bil) endowment/;
            if (r.match(effect)) {
                var val = Std.parseFloat(r.matched(1) + r.matched(2));
                switch (r.matched(3)) {
                case "k":
                    val *= 1000;
                case "mil":
                    val *= 1000000;
                case "bil":
                    val *= 1000000000;
                }
                Reg.endowment += val;
                trace(Reg.endowment);
                continue;
            }

            var r = ~/([+-][0-9]+) wealthy donors/;
            if (r.match(effect)) {
                var val = Std.parseInt(r.matched(1));
                Reg.wealthyDonors += val;
                trace(Reg.wealthyDonors);
                continue;
            }
        }
    }

}

