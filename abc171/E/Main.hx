import wa.*;

using wa.CharOuts;

class Main {
	static function main() {
		final cin = new CharIn(32);
		final cout = new CharOut();

		final n = cin.uint();
		final a = cin.uintVec(n);

		var allXor = a[0];
		for (i in 1...a.length)
			allXor = allXor ^ a[i];

		for (i in 0...a.length) {
			cout.int(allXor ^ a[i]);
			cout.space();
		}

		cout.println();
	}
}
