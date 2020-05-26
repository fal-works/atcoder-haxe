import wronganswer.naive.Lib;

class Main {
	static inline final aUnitAmount = 500;
	static inline final bUnitAmount = 100;
	static inline final cUnitAmount = 50;

	static function main() {
		final cin = new CharIn();
		final a = cin.int(LF);
		final b = cin.int(LF);
		final c = cin.int(LF);
		final x = cin.int(LF);

		final aMaxAmount = a * aUnitAmount;
		final bMaxAmount = b * bUnitAmount;
		final cMaxAmount = c * cUnitAmount;

		var validCount = 0;

		var aAmount = 0;
		while (aAmount <= aMaxAmount) {
			var abAmount = aAmount;
			final abMaxAmount = abAmount + bMaxAmount;
			while (abAmount <= abMaxAmount) {
				if (abAmount <= x && x <= abAmount + cMaxAmount)
					++validCount;

				abAmount += bUnitAmount;
			}

			aAmount += aUnitAmount;
		}

		Sys.println(validCount);
	}
}
