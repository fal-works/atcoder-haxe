class Main {
	static function main() {
		final n:Int = Std.parseInt(Sys.stdin().readLine());
		final s = switch (n % 10) {
			case 2 | 4 | 5 | 7 | 9: "hon";
			case 0 | 1 | 6 | 8: "pon";
			case 3: "bon";
			default: throw "err";
		}
		Sys.println(s);
	}
}
