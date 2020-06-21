import Sys.println;
import wa.*;

using wa.CharInsInt64;

class Main {
	static function main() {
		final cin = new CharIn(6);
		var N = cin.int64();
		var s = "";

		while (0 != N) {
			N -= 1;
			var mod = Int64.toInt(N % 26);
			final char = String.fromCharCode(mod + "a".code);
			Debug.log('$mod : $char');
			s = char + s;
			N = Int64s.div(N, 26);
		}

		println(s);
	}
}
