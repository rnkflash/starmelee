package
{
	import org.flixel.*;

	//This is a simple, auto-generated menu (See the flx.py Tutorial on the wiki for more info)
	public class ShipSelectState extends FlxState
	{
		public static var PLAYER_CHOICE:uint = 0;
		
		[Embed(source = "../img/selectship/human_1.png")] private var HumanShip1:Class;
		[Embed(source = "../img/selectship/human_2.png")] private var HumanShip2:Class;
		[Embed(source = "../img/selectship/ilwrath_1.png")] private var IlwrathShip1:Class;
		[Embed(source = "../img/selectship/ilwrath_2.png")] private var IlwrathShip2:Class;
		[Embed(source = "../img/selectship/yehat_1.png")] private var YehatShip1:Class;
		[Embed(source = "../img/selectship/yehat_2.png")] private var YehatShip2:Class;
		
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0, FlxG.height - 20, FlxG.width, "Select your ship");
			t.size = 16;
			t.alignment = "center";
			add(t);
			
			var bsx:Number = (640-160)/2;
			var bsy:Number = (480-40)/2;
			var bso:Number = 60;
			
			var button:FlxButton = new FlxButton(bsx, bsy, onbutton1,{choice:0});
			var buttonspr1:FlxSprite = new FlxSprite(0, 0, HumanShip1);
			var buttonspr2:FlxSprite = new FlxSprite(0, 0, HumanShip2);
			button.loadGraphic(buttonspr1, buttonspr2);
			add(button);
			
			button= new FlxButton(bsx+bso, bsy, onbutton1,{choice:1});
			buttonspr1= new FlxSprite(0, 0, IlwrathShip1);
			buttonspr2= new FlxSprite(0, 0, IlwrathShip2);
			button.loadGraphic(buttonspr1, buttonspr2);
			add(button);

			button = new FlxButton(bsx + bso * 2, bsy, onbutton1, { choice:2 } );
			add(button);
			buttonspr1= new FlxSprite(0, 0, YehatShip1);
			buttonspr2= new FlxSprite(0, 0, YehatShip2);
			button.loadGraphic(buttonspr1, buttonspr2);
			
			if (FlxG.music) FlxG.music.stop();
			
			//FlxG.mouse.show();
		}
		
		public function onbutton1(e:Object):void
		{
			if (gamestarting) return;
			PLAYER_CHOICE = e.choice;
			gamestarting = true;
			FlxG.fade.start(0xff000000, 1, onFade);
			
		}
		
		private var gamestarting:Boolean = false;
		override public function update():void
		{
						super.update();

		}
		
		private function onFade():void
		{
			FlxG.state = new PlayState();
		}
	}
}
