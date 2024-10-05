package scares;

class EmergencyAlertSystem extends MusicBeatState
{
	var EAS_SPRITE:FlxSprite;

	override function create()
	{
		EAS_SPRITE = new FlxSprite();
		EAS_SPRITE.frames = Paths.getSparrowAtlas('EAS_SPRITE');
		EAS_SPRITE.animation.addByPrefix('blank', 'blank', 24);
		EAS_SPRITE.animation.addByPrefix('booting', 'booting', 24);
		EAS_SPRITE.animation.addByPrefix('booted', 'loud beeps', 24);
		EAS_SPRITE.animation.play('blank');
		EAS_SPRITE.antialiasing = ClientPrefs.data.antialiasing;
		add(EAS_SPRITE);

		super.create();
	}
}