using Main.Printer;

class Main {
	static function main() {
		final cin = new CharIn();
		final a = cin.int();
		final b = cin.int();
		(if ((a * b) % 2 == 0) "Even" else "Odd").println();
	}
}


/**
	wronganswer v0.2.0-alpha / CC0
	https://github.com/fal-works/wronganswer
**/

abstract CharIn(haxe.io.Input) {
	public extern inline function new()
		this = Sys.stdin();

	public inline function char():Char32
		return this.readByte();

	public inline function str() {
		final buffer = new haxe.io.BytesBuffer();
		try {
			var character:Char32;
			while ((character = char()).isNotWhiteSpace())
				buffer.addByte(cast character);
		} catch (e:haxe.io.Eof) {}

		return buffer.getBytes().toString();
	}

	public inline function int():Int
		return Std.parseInt(str());
}

#if macro
abstract Char16(Int) from Int to Int {}
#else
abstract Char16(java.types.Char16) from java.types.Char16 to java.types.Char16 {
	@:to public inline function toInt():Int
		return cast this;
}
#end

abstract Char32(Int) from Int to Int to Char16 {
	@:to inline function char16():Char16
		return #if macro this; #else untyped __java__("(char) {0}", this); #end

	public inline function isNotWhiteSpace():Bool {
		return switch this {
			case " ".code | "\t".code | "\n".code | "\r".code:
				false;
			default:
				true;
		}
	}

	public inline function toDigit():Int
		return this - "0".code;

	public inline function toString():String
		return String.fromCharCode(this);
}

class Printer {
	@:generic public static inline function print<T>(x:T):Void {
		#if !macro
		untyped __java__("java.lang.System.out.print({0});", x);
		#end
	}

	@:generic public static inline function println<T>(x:T):Void {
		#if !macro
		untyped __java__("java.lang.System.out.println({0});", x);
		#end
	}
}
