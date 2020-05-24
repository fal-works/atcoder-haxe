class Main {
	static function main():Void {
		final stdin = Sys.stdin();
		final k:Int = Std.parseInt(stdin.readLine());
		final s = stdin.readLine();

		final out = if (s.length <= k) s else s.substr(0, k) + "...";
		Sys.println(out);
	}
}
