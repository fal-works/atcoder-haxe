import wa.*;

using wa.Printer;

class Main {
	static function main() {
		final cin = new CharIn(6);
		final x = cin.uint();
		final n = cin.uint();
		final p = cin.uintVec(n);

		Debug.log(p.toArray());

		inline function pHas(num: Int) {
			var found = false;
			for (i in 0...n) {
				if (p[i] == num) {
					found = true;
					break;
				}
			}
			return found;
		}

		if (!pHas(x)) {
			x.println();
			return;
		}

		for (d in 1...101) {
			if (!pHas(x - d)) {
				(x - d).println();
				return;
			}
			if (!pHas(x + d)) {
				(x + d).println();
				return;
			}
		}
	}
}
