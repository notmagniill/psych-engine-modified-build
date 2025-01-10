package scares;

class EmergencyAlertSystem extends MusicBeatState
{
	var EAS_SPRITE:FlxSprite;
	var can_press_enter:Bool = false;

	override function create()
	{
		EAS_SPRITE = new FlxSprite();
		EAS_SPRITE.frames = Paths.getSparrowAtlas('EAS_SPRITE');
		EAS_SPRITE.animation.addByPrefix('blank', 'blank', 24);
		EAS_SPRITE.animation.addByPrefix('booting', 'booting', 24);
		EAS_SPRITE.animation.addByPrefix('booted', 'loud beeps', 24);
		EAS_SPRITE.animation.play('blank');
		EAS_SPRITE.antialiasing = ClientPrefs.data.antialiasing;
		EAS_SPRITE.screenCenter();
		add(EAS_SPRITE);

		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			EAS_SPRITE.animation.play('booting');
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				EAS_SPRITE.animation.play('booted');
				FlxG.sound.playMusic(Paths.music('eas'), 5, true);
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					can_press_enter = true;
				});
			});
		});

		super.create();
	}
	override function update(elapsed:Float)
	{
		if (can_press_enter && controls.ACCEPT)
		{
			CoolUtil.crashGame("The Military knows what have you done.", "A reminder to Richard.");
		}

		super.update(elapsed);
	}
}