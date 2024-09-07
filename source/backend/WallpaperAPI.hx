package backend;

import haxe.io.Bytes;
import openfl.display.PNGEncoderOptions;
import openfl.utils.ByteArray;
import sys.io.File;

@:cppInclude('windows.h')

class WallpaperAPI
{
    var appdata:String = Sys.getEnv('AppData');

    /**
     * Changes wallpaper which is in `path`. Do a warning for players in your mod if you want use this function!!!!
     * @param path Path to image
     * @param absolute If false, `path` => mods/images/`path`.png
     * @return Bool - If false, wallpaper wasnt changed / target isnt Windows
     */

    public static function changeWallpaper(path:String, ?absolute:Bool):Bool
    {
        if (!absolute) path = Paths.modsImages(path);
        return #if windows untyped __cpp__('SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, (void*){0}.c_str(), SPIF_UPDATEINIFILE)', sys.FileSystem.absolutePath(path)) #else false #end;
    }
}