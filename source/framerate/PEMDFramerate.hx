package framerate;

import framerate.FPSCounter;
import framerate.MEMCounter;
import framerate.PEMDInfo;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

class PEMDFramerate extends Sprite
{
    public static var fpsVar:FPSCounter;
	public static var fpsSmol:FPSSmall;
	public static var memPeak:MEMPeak;
	public static var memVar:MEMCounter;
	public static var pemdInfo:PEMDInfo;

	public static var FRAMERATE_BG_HEIGHT:Int = 140;
	public static var FRAMERATE_BG_WIDTH:Int = 64;

	public static var FRAMERATE_X_POSITION:Float = 2;
	public static var FRAMERATE_Y_POSITION:Float = 2;

    public function new(x:Float, y:Float, fontName:String)
    {
        super();

		fpsVar = new FPSCounter(FRAMERATE_X_POSITION, FRAMERATE_Y_POSITION, 0xFFFFFF, fontName);
		fpsSmol = new FPSSmall(FRAMERATE_X_POSITION, fpsVar.height, 0xFFFFFF, fontName);
		memVar = new MEMCounter(FRAMERATE_X_POSITION, fpsSmol.y + fpsSmol.height - 1, 0xFFFFFF, fontName);
		memPeak = new MEMPeak(FRAMERATE_X_POSITION, memVar.y + memVar.height - 1, 0xFFBDBDBD, fontName);
		pemdInfo = new PEMDInfo(FRAMERATE_X_POSITION, memPeak.y + memPeak.height, 0xFFFFFF, fontName);

		var bg:Bitmap = new Bitmap(new BitmapData(FRAMERATE_BG_WIDTH, FRAMERATE_BG_HEIGHT, true, 0x7F000000));
		bg.x = bg.y = 0;

		addChild(bg);
		addChild(fpsVar);
		addChild(fpsSmol);
		addChild(memVar);
		addChild(memPeak);
		addChild(pemdInfo);
    }
}