import Sys.println;
import wa.*;

class Main {
	static function main() {
		final cin = new CharIn(32);

		final a = cin.uint();
		var b = cin.uint();
		var c = cin.uint();
		final k = cin.uint();

		for (i in 0...k) {
			if (a < b) {
				if (b < c) break;
				c <<= 1;
			} else {
				b <<= 1;
			}
		}

		println(if (a < b && b < c) "Yes" else "No");
	}
}
