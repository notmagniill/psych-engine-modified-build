package debug;

import openfl.display.Sprite;
import debug.FPSCounter;

class PEMDFramerate extends Sprite
{
    public static var fpsVar:FPSCounter;
	public static var fpsSmol:FPSSmall;
	public static var memPeak:MEMPeak;
	public static var memVar:MEMCounter;
	public static var pemdInfo:PEMDInfo;

    public function new(x:Float, y:Float, fontName:String)
    {
        super();

        fpsVar = new FPSCounter(10, 3, 0xFFFFFF, fontName);
		addChild(fpsVar);
		fpsSmol = new FPSSmall(43, 9, 0xFFFFFF, fontName);
		addChild(fpsSmol);
		memPeak = new MEMPeak(10, 28, 0xFFBDBDBD, fontName);
		addChild(memPeak);
		memVar = new MEMCounter(10, 28, 0xFFFFFF, fontName);
		addChild(memVar);
        pemdInfo = new PEMDInfo(10, 47, 0xFFFFFF, fontName);
        addChild(pemdInfo);
    }
}