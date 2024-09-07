package framerate;

import flixel.FlxG;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * DECOMPILED
 * TOTAL ERRORS: 0
 * DECOMPILED WITH
 *  _   ___  ______  _____ ____ ___  __  __ ____ ___ _     _____ ____  
 * | | | \ \/ /  _ \| ____/ ___/ _ \|  \/  |  _ \_ _| |   | ____|  _ \ 
 * | |_| |\  /| | | |  _|| |  | | | | |\/| | |_) | || |   |  _| | |_) |
 * |  _  |/  \| |_| | |__| |__| |_| | |  | |  __/| || |___| |___|  _ < 
 * |_| |_/_/\_\____/|_____\____\___/|_|  |_|_|  |___|_____|_____|_| \_\
*/

/**
	An easy to use FPS counter made for Psych Engine Modified Build.
	Written by Richard.
**/
class FPSCounter extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	/**
		The current memory usage (WARNING: this is NOT your total program memory usage, rather it shows the garbage collector memory)
	**/
	public var memoryMegas(get, never):Float;

	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000, font:String)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat(font, 23, color);
		autoSize = LEFT;
		multiline = true;
		text = "ADD FPS TEXT HERE";

		times = [];
	}

	var deltaTimeout:Float = 0.0;

	// Event Handlers
	private override function __enterFrame(deltaTime:Float):Void
	{
		// prevents the overlay from updating every frame, why would you need to anyways
		if (deltaTimeout > 1000) {
			deltaTimeout = 0.0;
			return;
		}

		final now:Float = haxe.Timer.stamp() * 1000;
		times.push(now);
		while (times[0] < now - 1000) times.shift();

		currentFPS = times.length < FlxG.updateFramerate ? times.length : FlxG.updateFramerate;		
		updateText();
		deltaTimeout += deltaTime;
	}

	public dynamic function updateText():Void { // so people can override it in hscript
		text = '${currentFPS}';
		//+ '\nMemory: ${flixel.util.FlxStringUtil.formatBytes(memoryMegas)}';

		textColor = 0xFFFFFFFF;
		if (currentFPS < FlxG.drawFramerate * 0.5)
			textColor = 0xFF454545;
	}

	inline function get_memoryMegas():Float
		return cpp.vm.Gc.memInfo64(cpp.vm.Gc.MEM_INFO_USAGE);
}

class FPSSmall extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000, font:String)
	{
		super();

		this.x = x;
		this.y = y;

		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat(font, 16, color);
		autoSize = LEFT;
		multiline = true;
		text = "ADD SMALL FPS TEXT HERE";

		times = [];
	}

	var deltaTimeout:Float = 0.0;

	// Event Handlers
	private override function __enterFrame(deltaTime:Float):Void
	{
		// prevents the overlay from updating every frame, why would you need to anyways
		if (deltaTimeout > 1000) {
			deltaTimeout = 0.0;
			return;
		}

		final now:Float = haxe.Timer.stamp() * 1000;
		times.push(now);
		while (times[0] < now - 1000) times.shift();

		currentFPS = times.length < FlxG.updateFramerate ? times.length : FlxG.updateFramerate;		
		updateText();
		deltaTimeout += deltaTime;
	}

	public dynamic function updateText():Void { // so people can override it in hscript
		text = 'FPS';
		//+ '\nMemory: ${flixel.util.FlxStringUtil.formatBytes(memoryMegas)}';

		textColor = 0xFFFFFFFF;
	}
}