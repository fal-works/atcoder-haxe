import wa.CharIn;

using wa.Vecs;
using wa.Printer;

class Main {
	static function main() {
		final cin = new CharIn(3);
		final n = cin.int();
		final d = cin.intVec(n);

		d.quicksort((a, b) -> a - b);
		final dedupCount = d.dedup(d);

		dedupCount.println();
	}
}
