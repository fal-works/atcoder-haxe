import wronganswer.naive.Lib;

class Main {
	static inline function digitSum(n:Int, radix:Int) {
		var sum = 0;
		while (0 < n) {
			sum += n % radix;
			n = Std.int(n / radix);
		}
		return sum;
	}

	static function main() {
		final cin = new CharIn();
		final n = cin.int(SP);
		final a = cin.int(SP);
		final b = cin.int(LF);

		inline function rangeIncludes(n:Int)
			return a <= n && n <= b;

		var total = 0;
		for (i in 1...n + 1) {
			if (rangeIncludes(digitSum(i, 10)))
				total += i;
		}

		Sys.println(total);
	}
}
