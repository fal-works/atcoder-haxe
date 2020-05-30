import wa.*;

using wa.Printer;
using wa.CharInsInt64;

class Main {
	static function main() {
		final cin = new CharIn(9);
		final n = cin.uint();
		final levelCount = n + 1;

		var remainingLeaves:Int64 = 0;
		final a = new Vec<Int64>(levelCount);
		for (i in 0...levelCount)
			remainingLeaves += (a[i] = cin.uint64());
		Debug.log("a: " + a.toArray());

		var currentLevelNodes:Int64 = 1; // at level 0
		var totalNodes:Int64 = 0;

		for (level in 0...levelCount) {
			final currentLevelLeaves:Int64 = a[level];
			final currentLevelNonLeaves:Int64 = currentLevelNodes - currentLevelLeaves;
			totalNodes += currentLevelNodes;

			remainingLeaves -= currentLevelLeaves;
			currentLevelNodes = Int64s.min(2 * currentLevelNonLeaves, remainingLeaves);
			if (currentLevelNodes < 0) {
				(-1).println();
				return;
			}
		}

		totalNodes.println();
	}
}
