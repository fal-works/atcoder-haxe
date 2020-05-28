import wa.naive.CharIn;
import wa.Debug;

using wa.Printer;

class Main {
	static inline final aUnitAmount = 10000;
	static inline final bUnitAmount = 5000;
	static inline final cUnitAmount = 1000;

	static function main() {
		final cin = new CharIn();
		final n = cin.int();
		final y = cin.int();

		var aValidCount = -1;
		var bValidCount = -1;
		var cValidCount = -1;
		var found = false;

		inline function saveValidCount(a:Int, b:Int, c:Int) {
			aValidCount = a;
			bValidCount = b;
			cValidCount = c;
			found = true;
		}

		var aAmount = 0;
		for (aCount in 0...n + 1) {
			Debug.log('a: $aCount');
			var abAmount = aAmount;
			final bMaxCount = n - aCount;
			if (aAmount + bMaxCount * bUnitAmount < y) {
				aAmount += aUnitAmount;
				continue;
			}
			if (y < aAmount)
				break;

			for (bCount in 0...bMaxCount + 1) {
				final cCount = bMaxCount - bCount;
				Debug.log('  b: $bCount, c: $cCount');
				final abcAmount = abAmount + cCount * cUnitAmount;
				if (abcAmount == y) {
					saveValidCount(aCount, bCount, cCount);
					break;
				}

				abAmount += bUnitAmount;
			}

			if (found)
				break;

			aAmount += aUnitAmount;
		}

		'$aValidCount $bValidCount $cValidCount'.println();
	}
}
