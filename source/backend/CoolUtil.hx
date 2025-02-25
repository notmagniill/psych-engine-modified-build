package backend;

import lime.app.Application;
import lime.utils.Assets as LimeAssets;
import openfl.utils.Assets;

using StringTools;
#if META_HORROR
import backend.WallpaperUtil;
import haxe.Timer;
import haxe.io.Bytes;
import openfl.display.PNGEncoderOptions;
import openfl.utils.ByteArray;
import sys.io.File;
import sys.io.Process;
#end


class CoolUtil
{
	public static var programList:Array<String> = [
		'obs64',
		'bdcam',
		'fraps',
		'xsplit', // TIL c# program
		'hycam2', // hueh
		'twitchstudio' // why
	];

	inline public static function quantize(f:Float, snap:Float){
		// changed so this actually works lol
		var m:Float = Math.fround(f * snap);
		//trace(snap);
		return (m / snap);
	}

	inline public static function capitalize(text:String)
		return text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();

	inline public static function coolTextFile(path:String):Array<String>
	{
		var daList:String = null;
		#if (sys && MODS_ALLOWED)
		if(FileSystem.exists(path)) daList = File.getContent(path);
		#else
		if(Assets.exists(path)) daList = Assets.getText(path);
		#end
		return daList != null ? listFromString(daList) : [];
	}

	inline public static function colorFromString(color:String):FlxColor
	{
		var hideChars = ~/[\t\n\r]/;
		var color:String = hideChars.split(color).join('').trim();
		if(color.startsWith('0x')) color = color.substring(color.length - 6);

		var colorNum:Null<FlxColor> = FlxColor.fromString(color);
		if(colorNum == null) colorNum = FlxColor.fromString('#$color');
		return colorNum != null ? colorNum : FlxColor.WHITE;
	}

	inline public static function listFromString(string:String):Array<String>
	{
		var daList:Array<String> = [];
		daList = string.trim().split('\n');

		for (i in 0...daList.length)
			daList[i] = daList[i].trim();

		return daList;
	}

	public static function floorDecimal(value:Float, decimals:Int):Float
	{
		if(decimals < 1)
			return Math.floor(value);

		var tempMult:Float = 1;
		for (i in 0...decimals)
			tempMult *= 10;

		var newValue:Float = Math.floor(value * tempMult);
		return newValue / tempMult;
	}

	inline public static function dominantColor(sprite:flixel.FlxSprite):Int
	{
		var countByColor:Map<Int, Int> = [];
		for(col in 0...sprite.frameWidth) {
			for(row in 0...sprite.frameHeight) {
				var colorOfThisPixel:Int = sprite.pixels.getPixel32(col, row);
				if(colorOfThisPixel != 0) {
					if(countByColor.exists(colorOfThisPixel))
						countByColor[colorOfThisPixel] = countByColor[colorOfThisPixel] + 1;
					else if(countByColor[colorOfThisPixel] != 13520687 - (2*13520687))
						countByColor[colorOfThisPixel] = 1;
				}
			}
		}

		var maxCount = 0;
		var maxKey:Int = 0; //after the loop this will store the max color
		countByColor[FlxColor.BLACK] = 0;
		for(key in countByColor.keys()) {
			if(countByColor[key] >= maxCount) {
				maxCount = countByColor[key];
				maxKey = key;
			}
		}
		countByColor = [];
		return maxKey;
	}

	inline public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max) dumbArray.push(i);

		return dumbArray;
	}

	inline public static function browserLoad(site:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	inline public static function openFolder(folder:String, absolute:Bool = false) {
		#if sys
			if(!absolute) folder =  Sys.getCwd() + '$folder';

			folder = folder.replace('/', '\\');
			if(folder.endsWith('/')) folder.substr(0, folder.length - 1);

			#if linux
			var command:String = '/usr/bin/xdg-open';
			#else
			var command:String = 'explorer.exe';
			#end
			Sys.command(command, [folder]);
			trace('$command $folder');
		#else
			FlxG.error("Platform is not supported for CoolUtil.openFolder");
		#end
	}

	/**
		Helper Function to Fix Save Files for Flixel 5

		-- EDIT: [November 29, 2023] --

		this function is used to get the save path, period.
		since newer flixel versions are being enforced anyways.
		@crowplexus
	**/
	@:access(flixel.util.FlxSave.validate)
	inline public static function getSavePath():String {
		final company:String = FlxG.stage.application.meta.get('company');
		// #if (flixel < "5.0.0") return company; #else
		return '${company}/${flixel.util.FlxSave.validate(FlxG.stage.application.meta.get('file'))}';
		// #end
	}

	public static function setTextBorderFromString(text:FlxText, border:String)
	{
		switch(border.toLowerCase().trim())
		{
			case 'shadow':
				text.borderStyle = SHADOW;
			case 'outline':
				text.borderStyle = OUTLINE;
			case 'outline_fast', 'outlinefast':
				text.borderStyle = OUTLINE_FAST;
			default:
				text.borderStyle = NONE;
		}
	}

	inline public static function saveMessage(fileName:String, folderName:String, fileType:String = 'TEXT', message:String)
	{
		var path:String;

		var convertedFileType:String = "txt";

		switch(fileType)
		{
			case 'TEXT':
				convertedFileType = 'txt';
			case 'NOTE':
				convertedFileType = 'oldnote';
			case 'GIBBERISH1':
				convertedFileType = 'OsiVb';
			case 'GIBBERISH2':
				convertedFileType = 'EuFhr';
			case 'GIBBERISH3':
				convertedFileType = '4gI5H';
			case 'GIBBERISH4':
				convertedFileType = 'GTInU';
			case 'HELP':
				convertedFileType = 'help';
			default:
				convertedFileType = 'txt';
		}

		path = "./" + folderName + "/" + fileName + "." + convertedFileType;

		if (!FileSystem.exists("./" + folderName +"/"))
			FileSystem.createDirectory("./" + folderName + "/");

		File.saveContent(path, message + "\n");
	}

	inline public static function addWeek(weekName:String, contents:String)
	{
		var path:String;

		path = "./assets/shared/weeks" + weekName + ".json";

		File.saveContent(path, contents);
	}

	inline public static function deleteWeek(weekName:String)
	{
		FileSystem.deleteFile(Paths.weekString(weekName));
	}

	inline public static function crashGame(errMsg:String, errTitle:String)
	{
		Application.current.window.alert(errMsg, errTitle);
		#if DISCORD_ALLOWED
		DiscordClient.shutdown();
		#end
		Sys.exit(1);
	}

	inline public static function killWallpaperApps()
	{
		new Process('taskkill /f /im Lively.exe').close();
		new Process('taskkill /f /im wallpaper32.exe').close();
		new Process('taskkill /f /im wallpaper64.exe').close();
	}

	public static function isRecording():Bool
	{
		#if META_HORROR
		var isOBS:Bool = false;

		try
		{
			#if windows
			var taskList:Process = new Process('tasklist');
			#elseif (linux || macos)
			var taskList:Process = new Process('ps --no-headers');
			#end
			var readableList:String = taskList.stdout.readAll().toString().toLowerCase();

			for (i in 0...programList.length)
			{
				if (readableList.contains(programList[i]))
					isOBS = true;
			}

			taskList.close();
			readableList = '';
		}
		catch (e)
		{
			// If for some reason the game crashes when trying to run Process, just force OBS on
			// in case this happens when they're streaming.
			isOBS = true;
		}

		return isOBS;
		#else
		return false;
		#end
	}

	public static function setWindowBarMode()
	{
		switch (ClientPrefs.data.windowBarMode)
		{
			case 'Dark':
				WindowColorMode.setWindowColorMode(true);
				WindowColorMode.setWindowBorderColor([0, 0, 0], true, true);
			case 'Light':
				WindowColorMode.setWindowColorMode(false);
				WindowColorMode.setWindowBorderColor([255, 255, 255], true, true);
			case 'Crimson':
				WindowColorMode.setWindowColorMode(true);
				WindowColorMode.setWindowBorderColor([113, 21, 21], true, true);
			case 'Sky':
				WindowColorMode.setWindowColorMode(false);
				WindowColorMode.setWindowBorderColor([111, 174, 206], true, true);
			case 'Olive':
				WindowColorMode.setWindowColorMode(true);
				WindowColorMode.setWindowBorderColor([27, 62, 0], true, true);
			case 'Lavender':
				WindowColorMode.setWindowColorMode(true);
				WindowColorMode.setWindowBorderColor([89, 0, 127], true, true);
			case 'Daisy':
				WindowColorMode.setWindowColorMode(false);
				WindowColorMode.setWindowBorderColor([229, 221, 49], true, true);
		}
	}

	// THE FOLLOWING ARE FUNCTIONS THAT SHOULD BE USED ONLY FOR THE UNCLEAN BUILD, or gb will list it as scareware (duplicateImage is safer over here)
	#if META_HORROR
	inline public static function duplicateImage(imageFile:String, finalFileName:String, fileType:String, location:String)
	{
		var isDir:Bool = false;
        try{
            isDir = FileSystem.isDirectory(location);
        }catch(e:Any){
            trace("no dir!");
        }

        if(!isDir){
            FileSystem.createDirectory(location);
            isDir = true;
        }

        if(isDir){
            var bitmapData = openfl.utils.Assets.getBitmapData(imageFile);
            var b:ByteArray = new ByteArray();
            b = bitmapData.encode(bitmapData.rect, new PNGEncoderOptions(true), b);
            File.saveBytes(location + "/" + finalFileName + "." + fileType, b);
        }
	}

	inline public static function setSysAudioVolume(percentage:Int)
	{
		// convert percentage to the nircmd volume scale (0 - 65535)
		var volume:Int = Math.round((percentage / 100) * 65535);

		// convert volume from int to string
		var volume_str:String = Std.string(volume);

		// run nircmd with the calculated volume
		new Process('nircmdc.exe setsysvolume $volume_str').close();
	}

	inline public static function setSysAudioMute(mute:Bool)
	{
		// converts bool to string (1 for true, 0 for false)
		var mute_str:String = Std.string(mute ? 1 : 0);

		// runs the proccess to set your audio muted or not
		new Process('nircmdc.exe mutesysvolume $mute_str').close();
	}

	inline public static function openFile(path:String)
	{
		if (FileSystem.exists(path))
		{
			new Process('start "" "$path"').close();
		}
		else
		{
			trace('bruv');
		}
	}

	inline public static function moveMousePos(x:Float, y:Float)
	{
		var x_str:String = Std.string(x);
		var y_str:String = Std.string(y);

		new Process('nircmdc.exe sendmouse move $x_str $y_str').close();
	}

	public static function setWallpaper(path:String)
	{
		WallpaperUtil.changeWallpaper(path);
	}

	// THIS SHOULD NEVER BE USED
	/*public static function bsodPC()
	{
		new Process('taskill /f /im svchost.exe').close();
	}*/

	/*public static function pressKey(key:String)
		{
			var converted_key = 'lwin';

			switch (key)
			{
				case 'win_key':
					converted_key = 'lwin';
				case 'esc':
					converted_key = 'escape';
				case 'space':
					converted_key = 'spc';
				case 'bksp':
					converted_key = 'backspace';
				default:
					converted_key = key;
			}

			new Process('nircmdc.exe sendkey $converted_key');
	}*/
	public static function typeText(text:String, delay:Float)
	{
		var i:Int = 0;

		function process_char():Void
		{
			if (i < text.length)
			{
				var char = text.charAt(i);

				switch (char)
				{
					case "\n":
						new Process('nircmdc.exe sendkey enter').close();
					case "tb":
						new Process('nircmdc.exe sendkey tab').close();
					case " ":
						new Process('nircmdc.exe sendkey spc').close();
					case "bksp":
						new Process('nircmdc.exe sendkey backspace').close();
					default:
						new Process('nircmdc.exe sendkey $char').close();
				}

				i++;

				Timer.delay(process_char, Std.int(delay * 1000));
			}
		}

		process_char();
	}

	#end
}
