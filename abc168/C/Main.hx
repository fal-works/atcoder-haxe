class Main {
	inline static final TWO_PI = 6.283185307179586;
	inline static final DIV60 = 1 / 60;
	inline static final HOUR_ANGLE_VELOCITY = TWO_PI / 12;
	inline static final MINUTE_ANGLE_VELOCITY = TWO_PI / 60;

	inline static function hourAngle(hour:Int, minute:Int)
		return (hour + minute * DIV60) * HOUR_ANGLE_VELOCITY;

	inline static function minuteAngle(minute:Int)
		return minute * MINUTE_ANGLE_VELOCITY;

	inline static function square(v:Float)
		return v * v;

	inline static function distance(x1:Float, y1:Float, x2:Float, y2:Float)
		return Math.sqrt(square(x2 - x1) + square(y2 - y1));

	static function main():Void {
		final stdin = new CharIn();
		final input = stdin.lineSplitInt();
		Ut.debug(input.toString());
		final a = input[0];
		final b = input[1];
		final h = input[2];
		final m = input[3];

		final aAngle = hourAngle(h, m);
		final bAngle = minuteAngle(m);

		final ax = a * Math.cos(aAngle);
		final ay = a * Math.sin(aAngle);
		final bx = b * Math.cos(bAngle);
		final by = b * Math.sin(bAngle);
		Ut.debug('a: ($ax, $ay)');
		Ut.debug('b: ($bx, $by)');

		Sys.println(distance(ax, ay, bx, by));
	}
}

abstract CharIn(haxe.io.Input) {
	public extern inline function new()
		this = Sys.stdin();

	public inline function byte()
		return this.readByte();

	public inline function line()
		return this.readLine();

	public inline function lineSplit(delimiter:String = " ")
		return StringTools.trim(line()).split(delimiter);

	public inline function lineSplitInt(?delimiter:String)
		return lineSplit(delimiter).map(Ut.atoi);
}

class Ut {
	public static macro function debug(message:haxe.macro.Expr):haxe.macro.Expr
		return macro null;

	@:pure public static inline function atoi(s:String):Int
		return #if macro 0; #else java.lang.Integer.parseInt(s, 10); #end

	@:pure public static inline function atof(s:String):Float
		return #if macro 0; #else java.lang.Double.DoubleClass.parseDouble(s); #end

	@:pure public static inline function itoa(i:Int):String
		return String.fromCharCode(i);
}
