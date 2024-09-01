package states;

import flixel.FlxSubState;

import flixel.effects.FlxFlicker;
import lime.app.Application;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	var warning:FlxSprite;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, watch out!\n
			This Mod contains some flashing lights!\n
			Press ENTER to disable them now or go to Options Menu.\n
			Press ESCAPE to ignore this message.\n
			You've been warned!",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		//add(warnText);

		warning = new FlxSprite(0, 0);
		warning.frames = Paths.getSparrowAtlas('warning');
		warning.animation.addByPrefix('anim1', 'warning', 24, true);
		warning.animation.addByPrefix('anim2', 'death', 24, true);
		warning.animation.play('anim1');
		warning.antialiasing = false;
		add(warning);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			var BACK:Bool = controls.BACK;
			if (controls.ACCEPT || BACK) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				warning.animation.play('anim2');
				new FlxTimer().start(0.015, function (tmr:FlxTimer) {
					warning.visible = false;
					new FlxTimer().start(0.1, function (tmr:FlxTimer) {
						MusicBeatState.switchState(new TitleState());
					});
				});
			}
		}
		super.update(elapsed);
	}
}
