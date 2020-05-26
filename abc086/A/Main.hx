class Main {
	static function main() {
		final cin = new CharIn();
		final a = cin.int(SP);
		final b = cin.int(LF);
		Sys.println(if ((a * b) % 2 == 0) "Even" else "Odd");
	}
}

/**
	wronganswer (naive) / CC0
	https://github.com/fal-works/wronganswer
**/

abstract CharIn(haxe.io.Input) {
	public extern inline function new()
		this = Sys.stdin();

	public inline function byte()
		return this.readByte();

	public inline function str(delimiter:Int) {
		final buffer = new haxe.io.BytesBuffer();
		try {
			var byte:Int;
			while ((byte = this.readByte()) != delimiter) {
				buffer.addByte(byte);
			}
		} catch (e:haxe.io.Eof) {}

		return buffer.getBytes().toString();
	}

	public inline function int(delimiter:Int):Int
		return Ut.atoi(str(delimiter));
}

enum abstract Delimiter(Int) to Int {
	final LF = "\n".code;
	final SP = " ".code;
}

class Ut {
	@:noUsing public static macro function debug(message:haxe.macro.Expr):haxe.macro.Expr
		return macro null;

	@:pure public static inline function atoi(s:String):Int
		return #if macro 0; #else java.lang.Integer.parseInt(s, 10); #end
}