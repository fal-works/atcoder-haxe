using Main.Printer;

class Main {
	static inline final aUnitAmount = 10000;
	static inline final bUnitAmount = 5000;
	static inline final cUnitAmount = 1000;

	static function main() {
		final cin = new CharIn();
		final n = cin.int();
		final y = cin.int();

		var aValidCount = -1;
		var bValidCount = -1;
		var cValidCount = -1;
		var found = false;

		inline function saveValidCount(a:Int, b:Int, c:Int) {
			aValidCount = a;
			bValidCount = b;
			cValidCount = c;
			found = true;
		}

		var aAmount = 0;
		for (aCount in 0...n + 1) {
			Debug.log('a: $aCount');
			var abAmount = aAmount;
			final bMaxCount = n - aCount;
			if (aAmount + bMaxCount * bUnitAmount < y) {
				aAmount += aUnitAmount;
				continue;
			}
			if (y < aAmount)
				break;

			for (bCount in 0...bMaxCount + 1) {
				final cCount = bMaxCount - bCount;
				Debug.log('  b: $bCount, c: $cCount');
				final abcAmount = abAmount + cCount * cUnitAmount;
				if (abcAmount == y) {
					saveValidCount(aCount, bCount, cCount);
					break;
				}

				abAmount += bUnitAmount;
			}

			if (found)
				break;

			aAmount += aUnitAmount;
		}

		'$aValidCount $bValidCount $cValidCount'.println();
	}
}


/**
	wronganswer v0.2.0-alpha / CC0
	https://github.com/fal-works/wronganswer
**/

abstract CharIn(haxe.io.Input) {
	public extern inline function new()
		this = Sys.stdin();

	public inline function char():Char
		return this.readByte();

	public inline function str() {
		final buffer = new haxe.io.BytesBuffer();
		try {
			var character:Char;
			while ((character = char()).isNotWhiteSpace())
				buffer.addByte(character);
		} catch (e:haxe.io.Eof) {}

		return buffer.getBytes().toString();
	}

	public inline function int():Int
		return Std.parseInt(str());
}

abstract Char(Int) from Int to Int {
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

class Debug {
	@:noUsing public static macro function log(message:haxe.macro.Expr):haxe.macro.Expr {
		#if debug
		return macro Sys.println('[DEBUG] ' + Std.string($message));
		#else
		return macro null;
		#end
	}
}
