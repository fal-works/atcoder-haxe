import wa.naive.CharIn;
using wa.Printer;

class Main {
	static function main() {
		final cin = new CharIn();
		final a = cin.int();
		final b = cin.int();
		(if ((a * b) % 2 == 0) "Even" else "Odd").println();
	}
}
