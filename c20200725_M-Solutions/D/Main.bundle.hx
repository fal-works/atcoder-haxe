using Main.VecsSort;
using Main.CharInsInt64;
using Main.CharIns;

import Sys.println;


class Main {
	static function main() {
		final cin = new CharIn(6);

		final n = cin.uint();
		final a = cin.int64Vec(n);
		Debug.log(a.toArray());

		final a2 = new Vec<Int64>(a.dedup(a));
		Vec.blit(a, 0, a2, 0, a2.length);
		Debug.log(a2.toArray());

		// final a3Array:Array<Int> = [a2[0]];
		// for (i in 1...a2.length) {
		// 	if (a2[i - 1] < a2[i] && (i == a2.length - 1 || a2[i + 1] < a2[i])) a3Array.push(a2[i]);
		// 	else if (a2[i - 1] > a2[i] && (i == a2.length - 1 || a2[i + 1] > a2[i])) a3Array.push(a2[i]);
		// }
		// Debug.log(a3Array);

		var last = a2.length - 1;
		while (0 < last) {
			if (a2[last - 1] < a2[last])
				break;
			--last;
		}

		final a3 = new Vec<Int64>(last + 1);
		Vec.blit(a2, 0, a3, 0, a3.length);
		Debug.log(a3.toArray());

		final d = new Vec(a3.length - 1);
		for (i in 0...d.length) {
			d[i] = a[i + 1] - a[i];
		}
		Debug.log(d.toArray());

		var amount: Int64 = 1000;
		var stocks: Int64 = 0;
		for (i in 0...d.length) {
			if (0 < d[i]) {
				final count = Int64s.div(amount, a3[i]);
				amount -= count * a3[i];
				stocks += count;
			} else {
				amount += stocks * a3[i];
				stocks = 0;
			}
			Debug.log('$i amount: $amount, stock: $stocks');
		}
		amount += stocks * a3[a3.length - 1];

		println(amount);
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

class CharIns {
	public static inline function bits(cin:CharIn):Bits
		return @:privateAccess cin.uintWithRadix(2);

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

class CharInsInt64 {
	public static inline function int64(cin:CharIn):Int64 {
		var result:Int64 = 0;
		var negative = false;
		try {
			var character = cin.char();
			if (character == "-".code) {
				negative = true;
				character = cin.char();
			}
			while (character.isNotWhiteSpace()) {
				final digit = character.toDigit();
				#if debug
				if (digit < 0 || 10 <= digit)
					throw "Failed to parse.";
				#end
				result = 10 * result + digit;
				character = cin.char();
			}
		} catch (e:haxe.io.Eof) {}

		return if (negative) -result else result;
	}

	public static inline function uint64(cin:CharIn):Int64
		return uint64WithRadix(cin, 10);

	public static inline function int64Vec(cin:CharIn, length:Int):Vec<Int64> {
		final vec = new Vec<Int64>(length);
		for (i in 0...length)
			vec[i] = int64(cin);
		return vec;
	}

	public static inline function uint64Vec(cin:CharIn, length:Int):Vec<Int64> {
		final vec = new Vec<Int64>(length);
		for (i in 0...length)
			vec[i] = uint64(cin);
		return vec;
	}

	static inline function uint64WithRadix(cin:CharIn, radix:Int64):Int64 {
		var result:Int64 = 0;
		try {
			var character:Char32;
			while ((character = cin.char()).isNotWhiteSpace())
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

typedef Int64 = haxe.Int64;

class Int64s {
	@:pure @:noUsing public static inline function min(a:Int64, b:Int64):Int64
		return if (a < b) a else b;

	@:pure @:noUsing public static inline function max(a:Int64, b:Int64):Int64
		return if (a < b) b else a;

	@:pure public static inline function div(n:Int64, divisor:Int64):Int64
		return #if macro 0; #else untyped __java__("{0} / {1}", n, divisor); #end

	@:pure public static inline function abs(n:Int64):Int64 {
		return (n ^ (n >> 63)) - (n >> 63);
	}

	@:pure public static inline function isEven(n:Int64):Bool {
		return n & 1 == 0;
	}

	@:pure public static inline function isOdd(n:Int64):Bool {
		return n & 1 == 1;
	}
}

typedef Vec<T> = haxe.ds.Vector<T>;

class VecsSort {
	static var recursionStack = new Vec<Int>(64);

	@:generic
	public static inline function reverse<T>(vec:Vec<T>):Vec<T> {
		final length = vec.length;
		final newVec = new Vec<T>(length);
		final lastIndex = length - 1;
		for (i in 0...length)
			newVec[i] = vec[lastIndex - i];
		return newVec;
	}

	@:noUsing
	public static inline function stackCapacity(capacity:Int):Void {
		recursionStack = new Vec<Int>(capacity);
	}

	@:generic
	public static inline function quicksort<T>(vec:Vec<T>, compare:T->T->Int, stackCapacity:Int = 0):Void {
		if (stackCapacity > recursionStack.length)
			VecsSort.stackCapacity(stackCapacity);

		final stack = recursionStack;
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

	@:generic public static inline function dedup<T>(vec:Vec<T>, out:Vec<T>):Int {
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

abstract Bits(Int) from Int to Int {
	public static inline function from(v:Int):Bits
		return v;

	@:op(A << B) static function leftShift(bits:Bits, shiftCount:Int):Bits;

	@:op(A >> B) static function rightShift(bits:Bits, shiftCount:Int):Bits;

	@:op(A >>> B) static function unsignedRightShift(bits:Bits, shiftCount:Int):Bits;

	@:op(A == B) static function equal(a:Bits, b:Bits):Bool;

	@:op(A != B) static function notEqual(a:Bits, b:Bits):Bool;

	@:op(A & B) static function and(a:Bits, b:Bits):Bits;

	@:op(A | B) static function or(a:Bits, b:Bits):Bits;

	@:op(A ^ B) static function xor(a:Bits, b:Bits):Bits;

	@:op(~A) static function negate(a:Bits):Bits;

	public static inline function set(bits:Bits, index:Int):Bits {
		return bits | (1 << index);
	}

	public static inline function unset(bits:Bits, index:Int):Bits {
		return bits & ~(1 << index);
	}

	@:op([]) public inline function get(index:Int):Bool {
		return this & (1 << index) != 0;
	}

	public inline function countOnes():Int
		return #if macro 0; #else java.lang.Integer.bitCount(this); #end

	public inline function trailingZeros():Int
		return #if macro 0; #else java.lang.Integer.numberOfTrailingZeros(this); #end

	public inline function trailingOnes():Int
		return #if macro 0; #else java.lang.Integer.numberOfTrailingZeros(~this); #end

	public inline function toBoolVec(length:Int):Vec<Bool> {
		final vec = new Vec(length);
		var bitMask = 1;
		for (i in 0...length) {
			vec[i] = this & bitMask != 0;
			bitMask <<= 1;
		}
		return vec;
	}

	public inline function forEachBit(callback:(flag:Bool) -> Void, length:Int):Void {
		var bitMask = 1;
		for (i in 0...length) {
			callback(this & bitMask != 0);
			bitMask <<= 1;
		}
	}

	public inline function forEachBitReversed(callback:(flag:Bool) -> Void, length:Int):Void {
		var bitMask = 1 << (length - 1);
		for (i in 0...length) {
			callback(this & bitMask != 0);
			bitMask >>>= 1;
		}
	}
}

class Debug {
	@:noUsing public static macro function log(message:haxe.macro.Expr):haxe.macro.Expr {
		#if debug
		return macro Sys.println('[DEBUG] ' + Std.string($message));
		#else
		return macro null;
		#end
	}
}
