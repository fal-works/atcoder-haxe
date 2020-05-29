import wa.CharIn;
import wa.Char16;

using wa.CharIns;
using wa.Printer;
using wa.Strs;
using wa.Vecs;

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
