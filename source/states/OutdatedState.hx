package states;

import states.OutdatedExtState;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;
	public static var currChanges:String = "";

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, looks like you're running an outdated\n
			version of Psych Engine Modified (" + MainMenuState.modifiedVersion + ")\n
			press Enter to see whats new in Version " + TitleState.updateVersion + "!", 32);

		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				leftState = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						OutdatedExtState.changesnshit = currChanges;
						MusicBeatState.switchState(new OutdatedExtState());
					}
				});
			}
			else if(controls.BACK) {
				leftState = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
