using Main.Vecs;
using Main.Strs;
using Main.StrBufs;
using Main.Printer;
using Main.CharIns;

class Main {
	static function main() {
		final s = new CharIn(100000).str().toCharVec().reverse();

		final length = s.length;
		var position = 0;

		inline function endsWith(word:haxe.ds.Vector<Char16>) {
			final wordLength = word.length;
			if (position + wordLength > length) return false;

			var i = 0;
			var pos = position;
			var result = true;

			while(i < wordLength) {
				if (word[i++] != s[pos++]) {
					result = false;
					break;
				}
			}

			if (result)
				position = pos;

			return result;
		}

		final dream = "dream".toCharVec().reverse();
		final dreamer = "dreamer".toCharVec().reverse();
		final erase = "erase".toCharVec().reverse();
		final eraser = "eraser".toCharVec().reverse();

		while (endsWith(dream) || endsWith(dreamer) || endsWith(erase) || endsWith(eraser)) {
			if (position == length) {
				"YES".println();
				return;
			}
		}

		"NO".println();
	}
}


/**
	wronganswer v0.2.0-alpha / CC0
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

	public inline function binary():Int
		return uintWithRadix(2);

	public inline function strVec(length:Int):haxe.ds.Vector<String> {
		final vec = new haxe.ds.Vector<String>(length);
		for (i in 0...length)
			vec[i] = str();
		return vec;
	}

	public inline function intVec(length:Int):haxe.ds.Vector<Int> {
		final vec = new haxe.ds.Vector<Int>(length);
		for (i in 0...length)
			vec[i] = int();
		return vec;
	}

	public inline function uintVec(length:Int):haxe.ds.Vector<Int> {
		final vec = new haxe.ds.Vector<Int>(length);
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

class CharIns {
	public static inline function float(cin:CharIn):Float
		return Floats.atof(cin.str());

	public static inline function all(cin:CharIn):String {
		@:privateAccess final byteArray = CharIn.byteArray;
		var index = 0;

		try {
			var character:Char32;
			while (true) {
				character = cin.char();
				byteArray[index++] = character;
			}
		} catch (e:haxe.io.Eof) {}

		try {
			return #if macro ""; #else new String(byteArray, 0, index, "UTF-8"); #end
		} catch (e:Dynamic) {
			throw e;
		}
	}

	public static inline function until(cin:CharIn, delimiter:Char32):String {
		@:privateAccess final byteArray = CharIn.byteArray;
		var index = 0;

		try {
			var character:Char32;
			while ((character = cin.char()) != delimiter)
				byteArray[index++] = character;
		} catch (e:haxe.io.Eof) {}

		try {
			return #if macro ""; #else new String(byteArray, 0, index, "UTF-8"); #end
		} catch (e:Dynamic) {
			throw e;
		}
	}

	public static inline function floatVec(cin:CharIn, length:Int):haxe.ds.Vector<Float> {
		final vec = new haxe.ds.Vector<Float>(length);
		for (i in 0...length)
			vec[i] = float(cin);
		return vec;
	}

	public static inline function count(cin:CharIn, characterToCount:Char32):Int {
		var foundCount = 0;
		try {
			var character:Char32;
			while ((character = cin.char()).isNotWhiteSpace()) {
				if (character == characterToCount)
					++foundCount;
			}
		} catch (e:haxe.io.Eof) {}

		return foundCount;
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

class Strs {
	@:pure public static inline function atoi(s:String):Int
		return #if macro 0; #else java.lang.Integer.parseInt(s, 10); #end

	@:pure public static inline function toCharVec(s:String):haxe.ds.Vector<Char16>
		return #if macro null; #else untyped __java__("{0}.toCharArray()", s); #end

	@:pure public static inline function compareString(a:String, b:String):Int
		return if (a < b) -1 else if (b < a) 1 else 0;

	@:pure public static inline function characterAt(s:String, index:Int):Char16
		return #if macro ""; #else untyped __java__("{0}.charAt({1})", s, index); #end
}

class Floats {
	@:pure public static inline function atof(s:String):Float
		return #if macro 0; #else java.lang.Double.DoubleClass.parseDouble(s); #end

	@:pure public static inline function ftoa(v:Float, scale:Int):String {
		final buffer = new StrBuf(15 + scale);
		buffer.floatWithScale(v, scale);
		return buffer.toString();
	}
}

@:forward(length, toString)
abstract StrBuf(#if macro Dynamic #else java.lang.StringBuilder #end)
#if !macro from java.lang.StringBuilder
#end
{
	public inline function new(capacity = 16) {
		this = #if macro null; #else new java.lang.StringBuilder(capacity); #end
	}

	public inline function str(s:String):StrBuf
		return #if macro this; #else untyped __java__("{0}.append({1})", this, s); #end

	public inline function int(v:Int):StrBuf
		return this.append(v);

	public inline function char(character:Char32):StrBuf
		return this.append(@:privateAccess character.char16());

	public inline function lf():StrBuf
		return char("\n".code);

	public inline function space():StrBuf
		return char(" ".code);

	public inline function strVec(vec:haxe.ds.Vector<String>, separator:Char32):StrBuf {
		str(vec[0]);
		for (i in 1...vec.length) {
			char(separator);
			str(vec[i]);
		}
		return this;
	}

	public inline function intVec(vec:haxe.ds.Vector<Int>, separator:Char32):StrBuf {
		int(vec[0]);
		for (i in 1...vec.length) {
			char(separator);
			int(vec[i]);
		}
		return this;
	}

	inline function builder()
		return this;
}

class StrBufs {
	public static inline function int64(buf:StrBuf, v:haxe.Int64):StrBuf
		return @:privateAccess buf.builder().append(v);

	public static inline function float(buf:StrBuf, v:Float):StrBuf
		return @:privateAccess buf.builder().append(v);

	public static inline function floatWithScale(buf:StrBuf, v:Float, scale:Int):StrBuf {
		if (v < 0) {
			buf.char("-".code);
			v = -v;
		}
		v += Math.pow(10.0, -scale) / 2.0;

		int64(buf, cast(v, haxe.Int64));
		if (scale != 0) {
			buf.char(".".code);
			v -= cast(cast(v, haxe.Int64), Float);

			for (i in 0...scale) {
				v *= 10.0;
				buf.int(((cast v) : Int));
				v -= Std.int(v);
			}
		}

		return buf;
	}

	public static inline function int64Vec(buf:StrBuf, vec:haxe.ds.Vector<haxe.Int64>, separator:Char32):StrBuf {
		int64(buf, vec[0]);
		for (i in 1...vec.length) {
			buf.char(separator);
			int64(buf, vec[i]);
		}
		return buf;
	}

	public static inline function floatVec(buf:StrBuf, vec:haxe.ds.Vector<Float>, separator:Char32):StrBuf {
		float(buf, vec[0]);
		for (i in 1...vec.length) {
			buf.char(separator);
			float(buf, vec[i]);
		}
		return buf;
	}

	public static inline function floatVecWithScale(buf:StrBuf, vec:haxe.ds.Vector<Float>, scale:Int, separator:Char32):StrBuf {
		floatWithScale(buf, vec[0], scale);
		for (i in 1...vec.length) {
			buf.char(separator);
			floatWithScale(buf, vec[i], scale);
		}
		return buf;
	}
}

class Vecs {
	static var quicksortStack = new haxe.ds.Vector<Int>(64);

	@:generic @:noUsing
	public static inline function create<T>(length:Int, factory:(index:Int) -> T):haxe.ds.Vector<T> {
		final vec = new haxe.ds.Vector<T>(length);
		for (i in 0...length)
			vec[i] = factory(i);
		return vec;
	}

	@:generic
	public static inline function reverse<T>(vec:haxe.ds.Vector<T>):haxe.ds.Vector<T> {
		final length = vec.length;
		final newVec = new haxe.ds.Vector<T>(length);
		final lastIndex = length - 1;
		for (i in 0...length)
			newVec[i] = vec[lastIndex - i];
		return newVec;
	}

	public static inline function quicksortStackCapacity(capacity:Int):Void {
		quicksortStack = new haxe.ds.Vector<Int>(capacity);
	}

	@:generic
	public static inline function quicksort<T>(vec:haxe.ds.Vector<T>, compare:T->T->Int, stackCapacity:Int = 0):Void {
		if (stackCapacity > quicksortStack.length)
			quicksortStackCapacity(stackCapacity);

		final stack = quicksortStack;
		var stackSize = 0;

		inline function push(lowIndex:Int, highIndex:Int):Void {
			stack[stackSize++] = lowIndex;
			stack[stackSize++] = highIndex;
		}
		inline function pop():Int
			return stack[--stackSize];

		inline function leftIsLess(left:T, right:T):Bool
			return compare(left, right) < 0;

		push(0, vec.length - 1);

		while (stackSize != 0) {
			final maxIndex = pop();
			final minIndex = pop();
			final pivot = vec[(minIndex + maxIndex) >> 1];

			var i = minIndex;
			var k = maxIndex;
			while (i <= k) {
				while (i < maxIndex && leftIsLess(vec[i], pivot))
					++i;
				while (minIndex < k && leftIsLess(pivot, vec[k]))
					--k;
				if (i <= k) {
					final tmp = vec[i];
					vec[i++] = vec[k];
					vec[k--] = tmp;
				}
			}

			if (minIndex < k)
				push(minIndex, k);
			if (i < maxIndex)
				push(i, maxIndex);
		}
	}

	@:generic public static inline function dedup<T>(vec:haxe.ds.Vector<T>, out:haxe.ds.Vector<T>):Int {
		var last = vec[0];
		var writeIndex = 1;
		for (readIndex in 1...vec.length) {
			final current = vec[readIndex];
			if (current != last)
				out[writeIndex++] = current;
			last = current;
		}
		return writeIndex;
	}
}
