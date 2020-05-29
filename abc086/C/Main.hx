import wa.CharIn;

using wa.Printer;
using wa.Calc;

class Main {
	static function main() {
		final cin = new CharIn(6);
		final n = cin.uint();

		var t1 = 0, x1 = 0, y1 = 0;
		var t2 = 0, x2 = 0, y2 = 0;

		inline function sameParity(a:Int, b:Int)
			return a & 1 == b & 1;

		inline function nextPointIsReachable() {
			t1 = t2;
			x1 = x2;
			y1 = y2;
			t2 = cin.uint();
			x2 = cin.uint();
			y2 = cin.uint();

			final deltaTime = t2 - t1;
			final distance = (x2 - x1).iabs() + (y2 - y1).iabs();

			return distance <= deltaTime && sameParity(distance, deltaTime);
		}

		for (i in 0...n) {
			if (!nextPointIsReachable()) {
				"No".println();
				return;
			}
		}

		"Yes".println();
	}
}
