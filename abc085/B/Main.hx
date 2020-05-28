import wronganswer.CharIn;
import wronganswer.Util;
using wronganswer.Vec;

class Main {
	static function main() {
		final cin = new CharIn(3);
		final n = cin.int();
		final d = cin.intVec(n);

		d.quicksort((a, b) -> a - b);
		final deduplicatedCount = d.dedup(d);

		Util.println(deduplicatedCount);
	}
}
