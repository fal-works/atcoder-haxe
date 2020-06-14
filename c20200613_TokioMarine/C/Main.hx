import wa.*;

using wa.Printer;

class Main {
	static function main() {
		final cin = new CharIn(6);
		final n = cin.uint();
		final k = cin.uint();
		final a = cin.uintVec(n);

		final events = new Vec<Int>(2 * n + 1);

		for (_ in 0...k) {
			for (i in 0...n)
				events[i] = 0;

			var curD = 0;
			for (m in 0...n) {
				final d = a[m];
				final start = m - d;
				final end = m + d + 1;
				if (start < 0)
					++curD
				else
					++events[start];
				--events[end];
			}
			var allN = true;
			for (i in 0...n) {
				curD += events[i];
				a[i] = curD;
				if (curD != n)
					allN = false;
			}
			if (allN)
				break;
		}

		final cout = new CharOut();
		cout.intVec(a, " ".code);
		cout.println();
	}
}
