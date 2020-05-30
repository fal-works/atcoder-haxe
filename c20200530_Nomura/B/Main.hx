import wa.CharIn;

using wa.Printer;
using StringTools;

class Main {
	static function main() {
		final cin = new CharIn(200001);
		final s = cin.str();

		s.replace("?", "D").println();
	}
}
