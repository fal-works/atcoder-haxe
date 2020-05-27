import wronganswer.Lib;
import wronganswer.Vec;

class Main {
	static function main() {
		final cin = new CharIn(3);
		final n = cin.int();
		final a = cin.intVec(n);

		Vec.quicksort(a, (a, b) -> b - a); // Descending

		var alice = 0;
		var bob = 0;
		var topInning = true;

		for (i in 0...a.length) {
			if (topInning) {
				alice += a[i];
				topInning = false;
			} else {
				bob += a[i];
				topInning = true;
			}
		}

		Ut.println(alice - bob);
	}
}
