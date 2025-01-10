package states.scares;

import flixel.addons.display.FlxBackdrop;

// ILL FINISH THIS SOMEDAY IM TIRED
class ErrorState extends MusicBeatState
{
	// TEXTS
	var tex:FlxText;

	// SPRITES
	var menubg:FlxSprite;
	var dizzybf:FlxSprite;
	var censor:FlxSprite;

	// BACKDROPS
	var outtaluck:FlxBackdrop;

	// MISC
	var isActivaterd = false;

	override function create()
	{
		// TEXT HANDLING

		tex = new FlxText(0, 95, FlxG.width,
			"Oopsie!\nThe game has ran into an unresolvable error\nand unfortunately has crashed.\nThe game will restart shortly.", 36);
		tex.setFormat("VCR OSD Mono", 36, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tex.screenCenter(X);
		tex.antialiasing = ClientPrefs.data.antialiasing;

		// SPRITE HANDLING

		menubg = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		menubg.antialiasing = ClientPrefs.data.antialiasing;
		// menubg.scrollFactor.set(0, yScroll);
		menubg.setGraphicSize(Std.int(menubg.width * 1.175));
		menubg.updateHitbox();
		menubg.screenCenter();
		menubg.color = 0xFFfd719b;

		dizzybf = new FlxSprite(475.1, 366.9);
		dizzybf.frames = Paths.getSparrowAtlas('error_state/dizzy_dickhead');
		dizzybf.animation.addByPrefix('dizzy', 'mr im dizzy', 24);
		dizzybf.animation.addByPrefix('dead', 'mr spilled ketchup', 24);
		dizzybf.animation.play('dizzy');
		dizzybf.antialiasing = ClientPrefs.data.antialiasing;

		censor = new FlxSprite(555.35, 354.5).loadGraphic(Paths.image('error_state/big_black_block'));
		censor.antialiasing = ClientPrefs.data.antialiasing;
		censor.visible = false;

		// BACKDROP HANDLING

		outtaluck = new FlxBackdrop(Paths.image('error_state/OUT OF LUCK'));
		outtaluck.antialiasing = false;
		outtaluck.visible = false;
		outtaluck.velocity.set(80, 80);

		// IMPLEMENTATION

		add(menubg);
		add(tex);
		add(outtaluck);
		add(dizzybf);
		add(censor);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.R)
			MusicBeatState.resetState();

		if (FlxG.keys.justPressed.O)
			isActivaterd = !isActivaterd;

		if (isActivaterd)
		{
			outtaluck.visible = true;
			tex.visible = false;
			dizzybf.animation.play('dead');
			censor.visible = true;
		}
		else
		{
			outtaluck.visible = false;
			tex.visible = true;
			dizzybf.animation.play('dizzy');
			censor.visible = false;
		}

		super.update(elapsed);
	}
}