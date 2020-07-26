import Sys.println;
import wa.*;

using wa.CharIns;
using wa.CharInsInt64;
using wa.VecsSort;

class Main {
	static function main() {
		final cin = new CharIn(6);

		final n = cin.uint();
		final a = cin.int64Vec(n);

		final a2 = new Vec<Int64>(a.dedup(a));
		Vec.blit(a, 0, a2, 0, a2.length);

		var last = a2.length - 1;
		while (0 < last) {
			if (a2[last - 1] < a2[last])
				break;
			--last;
		}

		final a3 = new Vec<Int64>(last + 1);
		Vec.blit(a2, 0, a3, 0, a3.length);

		final d = new Vec<Int64>(a3.length - 1);
		for (i in 0...d.length) {
			d[i] = a[i + 1] - a[i];
		}

		var amount: Int64 = 1000;
		var stocks: Int64 = 0;
		for (i in 0...d.length) {
			if (0 < d[i]) {
				final count = Int64s.div(amount, a3[i]);
				amount -= count * a3[i];
				stocks += count;
			} else {
				amount += stocks * a3[i];
				stocks = 0;
			}
			Debug.log('$i amount: $amount, stock: $stocks');
		}
		amount += stocks * a3[a3.length - 1];

		println(amount);
	}
}
