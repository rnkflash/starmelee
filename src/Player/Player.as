package Player 
{
	import org.flixel.FlxG;
	import Ships.Ship;
	
	/**
	 * ...
	 * @author Kishi
	 */
	public class Player 
	{
		
		public var mShip:Ship;
		
		public function Player(_ship:Ship) 
		{
			mShip = _ship;
			FlxG.followBounds( -1000, -1000, 1000, 1000);
			FlxG.follow(mShip, 2 );
		}
		
		public function update():void
		{
			if (!mShip.alive) return;
			
			if(FlxG.keys.LEFT)
				{
					
					mShip.LeftEngine();
				}
			if(FlxG.keys.RIGHT)
				{
					
					mShip.RightEngine();
				}
			
			
			
			if(FlxG.keys.UP)
				{
					mShip.UpEngine();
				}
				
			if(FlxG.keys.SPACE)
			{
				
				mShip.FirePrimary();
			}	
			
			if(FlxG.keys.X)
			{
				
				mShip.FireSecondary();
			}			
		}
		
	}
	
}