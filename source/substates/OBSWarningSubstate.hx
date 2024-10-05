package substates;

class OBSWarningSubstate extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var tex:FlxText;
	var yes:PsychUIButton;
	var nah:PsychUIButton;

	override function create()
	{
		super.create();

		var cam = new FlxCamera();
		cam.bgColor = 0;
		cameras = [cam];

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);

		tex = new FlxText(0, 0, FlxG.width,
			"Hold up!\nWe detected you are currently running\na recording software! The mod\nmay close it in one part of the mod\nWould you like to enable streamer mode?",
			12);
		tex.setFormat("VCR OSD Mono", 12, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tex.screenCenter();
		tex.alpha = 0;
		add(tex);

		yes = new PsychUIButton(30, FlxG.height - 30, "Yes", function()
		{
			si();
		});
		yes.alpha = 0;
		add(yes);

		nah = new PsychUIButton(FlxG.width - 30, FlxG.height - 30, "No", function()
		{
			no();
		});
		nah.alpha = 0;
		add(nah);

		FlxTween.tween(yes, {alpha: 1}, 0.5);
		FlxTween.tween(nah, {alpha: 1}, 0.5);
		FlxTween.tween(tex, {alpha: 1}, 0.5);
		FlxTween.tween(bg, {alpha: 1}, 0.5);

		trace('this is working');
	}

	function si()
	{
		FlxG.sound.play(Paths.sound('confirmMenu'));
		ClientPrefs.data.streamerMode = true;
		ClientPrefs.saveSettings();
		FlxTween.tween(yes, {alpha: 0}, 0.5);
		FlxTween.tween(nah, {alpha: 0}, 0.5);
		FlxTween.tween(tex, {alpha: 0}, 0.5);
		FlxTween.tween(bg, {alpha: 0}, 0.5, {
			onComplete: function(twn:FlxTween)
			{
				close();
			}
		});
	}

	function no()
	{
		FlxG.sound.play(Paths.sound('cancelMenu'));
		FlxTween.tween(yes, {alpha: 0}, 0.5);
		FlxTween.tween(nah, {alpha: 0}, 0.5);
		FlxTween.tween(tex, {alpha: 0}, 0.5);
		FlxTween.tween(bg, {alpha: 0}, 0.5, {
			onComplete: function(twn:FlxTween)
			{
				close();
			}
		});
	}
}