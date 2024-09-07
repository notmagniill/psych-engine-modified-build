package framerate;

import framerate.FPSCounter;
import framerate.MEMCounter;
import framerate.PEMDInfo;
import openfl.display.Sprite;

class PEMDFramerate extends Sprite
{
    public static var fpsVar:FPSCounter;
	public static var fpsSmol:FPSSmall;
	public static var memPeak:MEMPeak;
	public static var memVar:MEMCounter;
	public static var pemdInfo:PEMDInfo;

	public static var FRAMERATE_POSITION:Float = 4;

    public function new(x:Float, y:Float, fontName:String)
    {
        super();

        fpsVar = new FPSCounter(FRAMERATE_POSITION, 3, 0xFFFFFF, fontName);
		addChild(fpsVar);
		fpsSmol = new FPSSmall(FRAMERATE_POSITION, fpsVar.height, 0xFFFFFF, fontName);
		addChild(fpsSmol);
		memVar = new MEMCounter(FRAMERATE_POSITION, fpsSmol.y + fpsSmol.height - 1, 0xFFFFFF, fontName);
		addChild(memVar);
		memPeak = new MEMPeak(FRAMERATE_POSITION, memVar.y + memVar.height - 1, 0xFFBDBDBD, fontName);
		addChild(memPeak);
        pemdInfo = new PEMDInfo(FRAMERATE_POSITION, memPeak.y + memPeak.height, 0xFFFFFF, fontName);
        addChild(pemdInfo);
    }
}