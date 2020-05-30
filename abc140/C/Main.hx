import wa.CharIn;
import wa.Ints;

using wa.Printer;

class Main {
	static function main() {
		final cin = new CharIn(6);
		final n = cin.uint();

		var previousB = cin.uint();
		var sum = previousB;
		for (i in 1...n - 1) {
			final currentB = cin.uint();
			sum += Ints.min(previousB, currentB);
			previousB = currentB;
		}
		sum += previousB;

		sum.println();
	}
}
