import Sys.println;
import wa.*;

using wa.VecsSort;
using wa.VecsInt;

class Main {
	static function main() {
		final cin = new CharIn(32);

		final n = cin.uint();
		final k = cin.uint();
		final p = cin.uintVec(n);

		p.quicksort((a, b) -> a - b, n);

		println(p.sumIn(0, k));
	}
}
