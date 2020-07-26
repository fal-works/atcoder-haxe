import Sys.println;
import wa.*;

class Main {
	static function main() {
		final cin = new CharIn(6);
		final x = cin.uint();

		final rank = 8 - Ints.div(x - 400, 200);

		println(rank);
	}
}
