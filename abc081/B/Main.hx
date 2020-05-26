import wronganswer.Lib;
import wronganswer.extra.Bits;

class Main {
	static function main() {
		final cin = new CharIn(10);
		final n = cin.int();
		final a = cin.intVec(n);

		var min = 31;
		for (v in a) {
			final count = (v:Bits).trailingZeros();
			Ut.debug('$v: $count');
			if (count < min) min = count;
		}

		Sys.println(min);
	}
}
