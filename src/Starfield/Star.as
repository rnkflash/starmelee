package Starfield 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Kishi
	 */
	public class Star extends FlxSprite
	{
		
		public function Star(X:int=0, Y:int=0, Graphic:Class=null)
		{
			super(X, Y, Graphic);
		}
		
		override public function update():void
		{
			super.update();
			
			//optimus prime was here
			var FlxGscrollxscrollFactorx:Number = FlxG.scroll.x * scrollFactor.x;
			var FlxGscrollyscrollFactory:Number = FlxG.scroll.y * scrollFactor.y;
			//
			
			if(x+FlxGscrollxscrollFactorx >= frameWidth + FlxG.width)
				{
					x = -FlxGscrollxscrollFactorx + frameWidth ;
					y = -FlxGscrollyscrollFactory + FlxG.height * Math.random();
				}
			else if(x + FlxGscrollxscrollFactorx <= -frameWidth)
				{
					x = -FlxGscrollxscrollFactorx + frameWidth + FlxG.width;
					y = -FlxGscrollyscrollFactory + FlxG.height * Math.random();
				}
				
			if(y+FlxGscrollyscrollFactory >= frameHeight + FlxG.height)
				{
					x = -FlxGscrollxscrollFactorx + FlxG.width* Math.random();
					y = -FlxGscrollyscrollFactory+frameHeight ;
				}
			else if(y + FlxGscrollyscrollFactory <= -frameHeight)
				{
					x = -FlxGscrollxscrollFactorx + FlxG.width* Math.random();
					y = -FlxGscrollyscrollFactory+frameHeight + FlxG.height;
				}
		}
		
	}
	
}