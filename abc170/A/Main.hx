import wa.*;

using wa.Printer;

class Main {
	static function main() {
		final cin = new CharIn(32);

		for (i in 1...6) {
			if (cin.uint() == 0) {
				(i).println();
				return;
			}
		}
	}
}
