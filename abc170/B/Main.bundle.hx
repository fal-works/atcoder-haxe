using Main.Printer;
using Main.Ints;

class Main {
	static function main() {
		final cin = new CharIn(32);

		final x = cin.uint();
		final y = cin.uint();

		final cranes2 = (4 * x - y);
		if (cranes2 % 2 == 1) {
			"No".println();
			return;
		}
		final cranes = cranes2.div(2);
		Debug.log(cranes);
		if (0 <= cranes && cranes <= x) "Yes".println() else "No".println();
	}
}


/**
	wronganswer v0.3.0 / CC0
	https://github.com/fal-works/wronganswer
**/

abstract CharIn(#if macro Dynamic #else java.io.InputStream #end) {
	static var byteArray:#if macro Dynamic; #else java.NativeArray<java.types.Int8>; #end

	public extern inline function new(bufferCapacity:Int) {
		#if !macro
		this = untyped __java__("java.lang.System.in");
		byteArray = new java.NativeArray(bufferCapacity);
		#end
	}

	public inline function char():Char32 {
		final byte = this.read();
		if (byte == -1)
			throw new haxe.io.Eof();
		return byte;
	}

	public inline function str():String {
		final byteArray = CharIn.byteArray;
		var index = 0;

		try {
			var character:Char32;
			while ((character = char()).isNotWhiteSpace())
				byteArray[index++] = character;
		} catch (e:haxe.io.Eof) {}

		try {
			return #if macro ""; #else new String(byteArray, 0, index, "UTF-8"); #end
		} catch (e:Dynamic) {
			throw e;
		}
	}

	public inline function int():Int {
		var result = 0;
		var negative = false;
		try {
			var character = char();
			if (character == '-'.code) {
				negative = true;
				character = char();
			}
			while (character.isNotWhiteSpace()) {
				result = 10 * result + character.toDigit();
				character = char();
			}
		} catch (e:haxe.io.Eof) {}

		return if (negative) -result else result;
	}

	public inline function uint():Int
		return uintWithRadix(10);

	public inline function strVec(length:Int):Vec<String> {
		final vec = new Vec<String>(length);
		for (i in 0...length)
			vec[i] = str();
		return vec;
	}

	public inline function intVec(length:Int):Vec<Int> {
		final vec = new Vec<Int>(length);
		for (i in 0...length)
			vec[i] = int();
		return vec;
	}

	public inline function uintVec(length:Int):Vec<Int> {
		final vec = new Vec<Int>(length);
		for (i in 0...length)
			vec[i] = uint();
		return vec;
	}

	inline function uintWithRadix(radix:Int):Int {
		var result = 0;
		try {
			var character:Char32;
			while ((character = char()).isNotWhiteSpace())
				result = radix * result + character.toDigit();
		} catch (e:haxe.io.Eof) {}

		return result;
	}
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

class Ints {
	@:pure @:noUsing public static inline function min(a:Int, b:Int):Int
		return if (a < b) a else b;

	@:pure @:noUsing public static inline function max(a:Int, b:Int):Int
		return if (a < b) b else a;

	@:pure public static inline function div(n:Int, divisor:Int):Int
		return #if macro 0; #else untyped __java__("{0} / {1}", n, divisor); #end

	@:pure public static inline function abs(n:Int):Int {
		return (n ^ (n >> 31)) - (n >> 31);
	}

	@:pure public static inline function isEven(n:Int):Bool {
		return n & 1 == 0;
	}

	@:pure public static inline function isOdd(n:Int):Bool {
		return n & 1 == 1;
	}
}

typedef Vec<T> = haxe.ds.Vector<T>;

class Debug {
	@:noUsing public static macro function log(message:haxe.macro.Expr):haxe.macro.Expr {
		#if debug
		return macro Sys.println('[DEBUG] ' + Std.string($message));
		#else
		return macro null;
		#end
	}
}
