import Sys.println;
import wa.*;

class Main {
	static function main() {
		final cin = new CharIn(32);

		final a = cin.str();
		if (a.toLowerCase() == a)
			println("a");
		else
			println("A");
	}
}
