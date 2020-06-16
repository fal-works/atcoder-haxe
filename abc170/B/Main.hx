import wa.*;

using wa.Printer;
using wa.Ints;

class Main {
	static function main() {
		final cin = new CharIn(32);

		final x = cin.uint();
		final y = cin.uint();

		final cranes2 = (4 * x - y);
		if (cranes2 % 2 == 1) {
			"No".println();
			return;
		}
		final cranes = cranes2.div(2);
		Debug.log(cranes);
		if (0 <= cranes && cranes <= x) "Yes".println() else "No".println();
	}
}
