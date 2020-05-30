import wa.CharIn;
import wa.Ints;

using wa.Printer;

class Main {
	static function main() {
		final cin = new CharIn(6);
		final h1 = cin.uint();
		final m1 = cin.uint();
		final h2 = cin.uint();
		final m2 = cin.uint();
		final k = cin.uint();

		final dh = h2 - h1;
		final dm = dh * 60 + m2 - m1;

		(dm - k).println();
	}
}
