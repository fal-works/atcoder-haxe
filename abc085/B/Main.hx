import wronganswer.CharIn;
import wronganswer.Vec;
import wronganswer.Util;

class Main {
	static function main() {
		final cin = new CharIn(3);
		final n = cin.int();
		final d = cin.intVec(n);

		Vec.quicksort(d, (a, b) -> a - b);
		final deduplicatedCount = Vec.dedup(d, d);

		Util.println(deduplicatedCount);
	}
}
