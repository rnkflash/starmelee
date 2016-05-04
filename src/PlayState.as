package
{
	import Ai.Ai;
	import Ai.SimpleBot;
	import flash.display.Sprite;
	import org.flixel.*;
	import org.rje.glaze.util.FPSCounter;
	import Physics.GlazeStuff;
	import Player.Player;
	import Ships.Alien.AlienCruiser;
	import Ships.Earthling.EarthlingCruiser;
	import Ships.Earthling.Missile;
	import Ships.Ilwrath.IlwrathAvenger;
	import Ships.Ship;
	import Ships.Yehat.YehatTerminator;
	import Starfield.Starfield;

	//This is our main game state, where we initialize all our game objects and do
	// things like check for game over, perform collisions, etc.
	public class PlayState extends FlxState
	{
		
		public var SHIPS_LAYER:FlxGroup;	//A list of all the asteroids 
		
		public static var _physicWorld:GlazeStuff;
		
		public static var DEBUG_SCREEN:Sprite;
		public static var DEBUG_DRAW:Boolean = false;
		
		
		[Embed(source = "../snd/01_Attack.mp3")] private var BattleMusic:Class;
		
		
		private var starfield:Starfield;
		public var player:Player;
		
		private var bots:Array;
		
		public static var instance:PlayState;

		
		override public function create():void
		{
			//FlxG.mouse.hide();
			instance = this;
			var i:int;
			
			//lets start da music
			FlxG.playMusic(BattleMusic);
			
			//debug
			DEBUG_SCREEN = new Sprite();
			stage.addChild(DEBUG_SCREEN);
			
			//physworld
			_physicWorld = new GlazeStuff();
			_physicWorld.Init();
			
			//init background
			starfield = new Starfield();
			add(starfield);
			
			//Initialize ships layers etc
			SHIPS_LAYER = new FlxGroup();
			add(SHIPS_LAYER);
			Ship.Init();
			add(Ship.GIBS);
			
			//player
			var choices:Array = [EarthlingCruiser,IlwrathAvenger,YehatTerminator];
			player = new Player(AddShip(choices[ShipSelectState.PLAYER_CHOICE]));
			
			//bots
			bots = [];
			for (var ibots:int = 0; ibots < 100; ibots++) 
			{
				bots.push(new SimpleBot(AddShip(choices[Math.floor(Math.random() * choices.length)], 
				Math.random() * 640, Math.random() * 480, Math.random() * 360)));
			}
			
			
			
			//fps
			var fps:FPSCounter = new FPSCounter();
			stage.addChild(fps);
			
			//gui
			var t:FlxText;
			var gui:FlxGroup = new FlxGroup();
			gui.scrollFactor = new FlxPoint(0, 0);
			add(gui);
			t = new FlxText(0,FlxG.height-20,FlxG.width,"Controls: arrows - engine, SPACE - shoot, D - debug draw");
			t.alignment = "center";
			gui.add(t,true);

			/*
			var exitbutton:FlxButton = new FlxButton(600, 10, exitbuttonpressed);
			gui.add(exitbutton, true);
			exitbutton.loadGraphic(	(new FlxSprite(0, 0)).createGraphic(100, 20, 0x990000), 
									(new FlxSprite(0, 0)).createGraphic(100, 20, 0xff0000)
									);
			var t1:FlxText = new FlxText(0, 0, 100, "Exit");
			t1.color = 0x999999;
			var t2:FlxText = new FlxText(0, 0, 100, "Exit");
			t2.color = 0xffffff;
			exitbutton.loadText(t1,t2);
			*/
			
			
			
		}
		private var gameexiting:Boolean = false;
		private function exitbuttonpressed():void
		{
			if(!gameexiting)
				{
					gameexiting = true;
					//FlxG.flash.start(0xffffffff, 0.75);
					FlxG.fade.start(0xff000000, 1, function():void {FlxG.state = new ShipSelectState();});
				}			
		}
		
		override public function update():void
		{
			//global hotkeys
			if (FlxG.keys.justPressed("D") )
			{
				DEBUG_DRAW = !DEBUG_DRAW;
				DEBUG_SCREEN.graphics.clear();
			}

				
			//players update
			player.update();
			for each (var bot:Ai in bots) 
			{
				bot.update();
			}
			
			//phys world update
			_physicWorld.Update();
			
			//debug draw
			if (DEBUG_DRAW) 
			{
				DEBUG_SCREEN.graphics.clear();
				DEBUG_SCREEN.x = FlxG.scroll.x;
				DEBUG_SCREEN.y = FlxG.scroll.y;
				_physicWorld.DebugDraw(DEBUG_SCREEN.graphics);
			}
			
			//flixel update
			super.update();
			
			
			
		}
		
		

		
		private function AddShip(_typeclass:Class,_x:Number=300,_y:Number=300,_a:Number=0):Ship
		{
			var _ship:Ship;
			_ship = new _typeclass(_x, _y, _a);
			SHIPS_LAYER.add(_ship);
			return _ship;
			
			
		}
	}
}
