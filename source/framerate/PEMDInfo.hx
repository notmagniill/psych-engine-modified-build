package framerate;

import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.system.System;

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
    Used to display info about Psych Engine Modified Build.
    Written by Richard.
 */
class PEMDInfo extends TextField
{
	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000, font:String)
	{
		super();

		this.x = x;
		this.y = y;

		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat(font, 13, color);
		autoSize = LEFT;
		multiline = true;
		text = 'PEMD\nBeta 1';
	}
}