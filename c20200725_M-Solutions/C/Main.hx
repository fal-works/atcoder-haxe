import wa.*;

class Main {
	static function main() {
		final cin = new CharIn(6);
		final cout = new CharOut();

		var n = cin.uint();
		var k = cin.uint();
		var a = cin.uintVec(n);

		for (i in k...n) {
			Debug.log('${a[i - k]} < ${a[i]}');

			cout.str(if (a[i - k] < a[i]) "Yes\n" else "No\n");
		}

		cout.print();
	}
}
