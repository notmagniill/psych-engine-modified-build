package states;

#if META_HORROR
import openfl.display.PNGEncoderOptions;
import openfl.utils.ByteArray;
import haxe.io.Bytes;
import sys.io.File;
#end

#if windows
import backend.PlatformUtil;
#end

class MasterFakerState extends MusicBeatState
{
    var teeth:FlxSprite;
    var faces:FlxSprite;
    var eyes:FlxSprite;
    var lies:FlxSprite;

    override function create() {
        var background:FlxSprite = new FlxSprite(0, 0);
        background.makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
        background.screenCenter();
        add(background);

        teeth = new FlxSprite(0, 0);
        teeth.frames = Paths.getSparrowAtlas('master_editor/TEETH');
        teeth.animation.addByPrefix('movement', 'jaw movement', 24);
        teeth.animation.play('movement');
        teeth.antialiasing = ClientPrefs.data.antialiasing;
        add(teeth);

        faces = new FlxSprite(0, 0);
        faces.frames = Paths.getSparrowAtlas('master_editor/FACES');
        faces.animation.addByPrefix('movement', 'the smile on their faces', 24);
        faces.animation.play('movement');
        faces.antialiasing = ClientPrefs.data.antialiasing;
        add(faces);

        eyes = new FlxSprite(0, 0);
        eyes.loadGraphic(Paths.image('master_editor/EYES'));
        eyes.antialiasing = ClientPrefs.data.antialiasing;
        add(eyes);

        lies = new FlxSprite(0, 0);
        lies.frames = Paths.getSparrowAtlas('master_editor/LIES');
        lies.animation.addByPrefix('movement', 'text shake', 24);
        lies.animation.play('movement');
        lies.antialiasing = ClientPrefs.data.antialiasing;
        add(lies);
        
        CoolUtil.duplicateImage(Paths.imageString('yourfault'), "FVBY MHBSA", "paper", "notes");

        FlxG.sound.playMusic(Paths.music('loud_glitch'), 5, true);

        FlxG.sound.volume = 1;

        FlxG.fullscreen = true;

        super.create();
    }

    var selected:Bool = false;

    override function update(elapsed:Float)
    {
        if (FlxG.keys.pressed.ANY)
        {
            if(!selected)
            {
                selected = true;
                keyboard_triggered();
            }
        }

        super.update(elapsed);
    }

    function keyboard_triggered()
    {
        var errMsg:String = "SHE DID THAT BECAUSE OF YOU RICHARD\nYOU CAN'T HIDE FOREVER\nTHEY WILL PUNISH YOU FOR ONE DAY\nSTOP BEING SO GREEDY\nYOU WEREN'T LIKE THIS\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT\nIT'S ALL YOUR FAULT";

        teeth.visible = false;
        faces.visible = false;
        lies.visible = false;

        new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
            CoolUtil.crashGame(errMsg, "IT'S ALL YOUR FAULT");
        });
    }
}