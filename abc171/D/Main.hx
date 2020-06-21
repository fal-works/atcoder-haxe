import wa.*;

using wa.CharOuts;

class Main {
	static function main() {
		final cin = new CharIn(32);
		final cout = new CharOut();

		final n = cin.uint();
		final a = cin.uintVec(n);
		final q = cin.uint();

		final table = new Vec<Int64>(100001);
		var sum:Int64 = 0;
		for (i in 0...a.length) {
			final cur = a[i];
			++table[cur];
			sum += cur;
		}

		for (i in 0...q) {
			final b = cin.uint();
			final c = cin.uint();
			final count = table[b];
			table[b] = 0;
			table[c] += count;
			sum -= Int64.ofInt(b) * count;
			sum += Int64.ofInt(c) * count;
			cout.int64(sum);
			cout.lf();
		}

		cout.println();
	}
}
