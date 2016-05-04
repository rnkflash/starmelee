package
{
	import org.flixel.*;

	//This is a simple, auto-generated menu (See the flx.py Tutorial on the wiki for more info)
	public class MenuState extends FlxState
	{
		override public function create():void
		{
			//A couple of simple text fields
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"Star Melee");
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(0,FlxG.height-20,FlxG.width,"click to play");
			t.alignment = "center";
			add(t);
			
			FlxG.mouse.show();
			
			
		
			
		}
		
		private function onbutton1():void
		{
			trace("suck my dick");
		}
		
		private var gamestarting:Boolean = false;
		override public function update():void
		{
			//Switch to play state if the mouse is pressed
			if(!gamestarting && FlxG.mouse.justPressed())
				{
					gamestarting = true;
					FlxG.flash.start(0xffffffff, 0.75);
					FlxG.fade.start(0xff000000, 1, onFade);
				}
		}
		
		private function onFade():void
		{
			FlxG.state = new ShipSelectState();
		}
	}
}
