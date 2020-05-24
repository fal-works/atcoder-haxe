import haxe.io.Input;
import haxe.io.BytesBuffer;

class InputExtension {
  static final buffer = new BytesBuffer();

	/**
		Read a string until a character code specified by `end` is occurred.

		The final character is not included in the resulting string.
	**/
	public static inline function readUntil(_this: Input, buffer: BytesBuffer, end:Int):String {
		var last:Int;
		while ((last = _this.readByte()) != end)
			buffer.addByte(last);
		return buffer.getBytes().toString();
	}
}

class Main {
  static public function main():Void {
    Sys.println("start.");
    // final input = Sys.stdin();
    // input.bigEndian = true;
    // // final a = input.readUntil(" ".code);
    // final a = input.readLine();
    // input.close();
    // Sys.println(a);
  }

  static function run(input: String): Void {

  }
}
