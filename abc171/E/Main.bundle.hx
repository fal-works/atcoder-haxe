using Main.CharOuts;

class Main {
	static function main() {
		final cin = new CharIn(32);
		final cout = new CharOut();

		final n = cin.uint();
		final a = cin.uintVec(n);
		var all = a[0];
		for (i in 1...a.length) all = all ^ a[i];

		for (i in 0...a.length) {
			cout.int(all ^ a[i]);
			cout.space();
		}

		cout.println();
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

abstract CharOut(#if macro Dynamic #else java.io.PrintWriter #end) #if !macro from java.io.PrintWriter #end {
	public inline function new() {
		this = #if macro null; #else new java.io.PrintWriter(java.lang.System.out); #end
	}

	public inline function str(s:String):CharOut {
		#if !macro
		untyped __java__("{0}.print({1})", this, s);
		#end
		return this;
	}

	public inline function int(v:Int):CharOut {
		this.print(v);
		return this;
	}

	public inline function char(character:Char16):CharOut {
		#if !macro
		this.append(character);
		#end
		return this;
	}

	public inline function lf():CharOut
		return char("\n".code);

	public inline function space():CharOut
		return char(" ".code);

	public inline function strVec(vec:Vec<String>, separator:Char16):CharOut {
		str(vec[0]);
		for (i in 1...vec.length) {
			char(separator);
			str(vec[i]);
		}
		return this;
	}

	public inline function intVec(vec:Vec<Int>, separator:Char16):CharOut {
		int(vec[0]);
		for (i in 1...vec.length) {
			char(separator);
			int(vec[i]);
		}
		return this;
	}

	public inline function print():Void
		this.flush();

	public inline function println():Void {
		lf();
		print();
	}

	inline function internal()
		return this;
}

class CharOuts {
	public static inline function int64(cout:CharOut, v:Int64):CharOut {
		@:privateAccess cout.internal().print(v);
		return cout;
	}

	public static inline function float(cout:CharOut, v:Float):CharOut {
		@:privateAccess cout.internal().print(v);
		return cout;
	}

	public static inline function floatWithScale(cout:CharOut, v:Float, scale:Int):CharOut {
		if (v < 0) {
			cout.char("-".code);
			v = -v;
		}
		v += Math.pow(10.0, -scale) / 2.0;

		int64(cout, cast(v, Int64));
		if (scale != 0) {
			cout.char(".".code);
			v -= cast(cast(v, Int64), Float);

			for (i in 0...scale) {
				v *= 10.0;
				cout.int(((cast v) : Int));
				v -= Std.int(v);
			}
		}

		return cout;
	}

	public static inline function int64Vec(cout:CharOut, vec:Vec<Int64>, separator:Char16):CharOut {
		int64(cout, vec[0]);
		for (i in 1...vec.length) {
			cout.char(separator);
			int64(cout, vec[i]);
		}
		return cout;
	}

	public static inline function floatVec(cout:CharOut, vec:Vec<Float>, separator:Char16):CharOut {
		float(cout, vec[0]);
		for (i in 1...vec.length) {
			cout.char(separator);
			float(cout, vec[i]);
		}
		return cout;
	}

	public static inline function floatVecWithScale(cout:CharOut, vec:Vec<Float>, scale:Int, separator:Char16):CharOut {
		floatWithScale(cout, vec[0], scale);
		for (i in 1...vec.length) {
			cout.char(separator);
			floatWithScale(cout, vec[i], scale);
		}
		return cout;
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

typedef Int64 = haxe.Int64;

typedef Vec<T> = haxe.ds.Vector<T>;
