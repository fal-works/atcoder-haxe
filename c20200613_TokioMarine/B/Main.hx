import wa.*;

using wa.Printer;
using wa.CharInsInt64;

class Main {
	static function main() {
		final cin = new CharIn(16);
		var a = cin.int64();
		var v = cin.uint64();
		var b = cin.int64();
		var w = cin.uint64();
		final t = cin.uint64();

		if (v <= w) {
			"NO".println();
			return;
		}

		if (a < b) {
			a += t * v;
			b += t * w;
			(if (b <= a) "YES" else "NO").println();
		} else {
			a -= t * v;
			b -= t * w;
			(if (a <= b) "YES" else "NO").println();
		}
	}
}
