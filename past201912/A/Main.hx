import wa.CharIn;

using StringTools;
using wa.Printer;
using wa.CharIns;
using wa.Strs;

class Main {
	static function main() {
		final input = new CharIn(64).all().trim();

		for (i in 0...input.length) {
			final charCode = input.charCodeAt(i);
			if (charCode < "0".code || "9".code < charCode) {
				"error".println();
				return;
			}
		}

		final n = input.atoi();
		(2 * n).println();
	}
}
