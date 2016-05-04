package Starfield 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Kishi
	 */
	public class Starfield extends FlxGroup
	{
		
		[Embed(source = "../../img/redstar.png")] private var redstar:Class;
		[Embed(source = "../../img/redstar2.png")] private var redstar2:Class;
		[Embed(source = "../../img/redstar3.png")] private var redstar3:Class;
		
		private var starfield:Array;
		
		public function Starfield() 
		{
			super();
			starfield = [new FlxGroup(), new FlxGroup(), new FlxGroup()];
			starfield[0].scrollFactor = new FlxPoint(0.4,0.4);
			starfield[1].scrollFactor = new FlxPoint(0.7,0.7);
			starfield[2].scrollFactor = new FlxPoint(1.0,1.0);
			FillWithStars(starfield[0], 100, redstar3);
			FillWithStars(starfield[1], 70, redstar2);
			FillWithStars(starfield[2], 50, redstar);
			add(starfield[0]);
			add(starfield[1]);
			add(starfield[2]);			
		}
		
		
		
		//fill with stars
		private function FillWithStars(_grp:FlxGroup, _cnt:int ,_clr:Class):void
		{
			for (var i:int = 0; i < _cnt; i++) 
			{
				
				var star:Star = new Star(Math.random() * FlxG.width, Math.random() * FlxG.height, _clr);
				_grp.add(star,true);
			}
		}		
		
		
	}
	
}