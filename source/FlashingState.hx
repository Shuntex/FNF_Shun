package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;
	public static var critical:Bool = false;
	public static var errorSeen:Bool = false;
	public static var access:Bool = true;
	
	var warnText:FlxText;
	var errText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"WARNING\n
			VS Shun contains flashing lights and various effects\n
			that may trigger epileptic seizures in some people.\n
			Please continue with caution.\n
			You've been warned!",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(access) {
			if(!errorSeen) {
				var back:Bool = controls.BACK;
					if (controls.ACCEPT || back) {
					leftState = true;
					access = false;
					if(!back) {
					MusicBeatState.switchState(new TitleState());
				}
			}
		}
		if(access) {
			if(errorSeen) {
				var back:Bool = controls.BACK;
					if (controls.ACCEPT || back) {
					leftState = true;
					access = false;
					if(!back) {
					MusicBeatState.switchState(new TitleState());
				}
			}
		}
		super.update(elapsed);
		}
	}
}
}