
@:native("os")
extern class OS {
  static function execute(cmd:String):Void;
}

@:native("awesome")
extern class Awesome {
  static function quit():Void;
}

class Main {

	public static function main():Void {
		trace("hello");
                OS.execute("echo yolo");
	}

}
