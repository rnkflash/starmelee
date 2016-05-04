package Ai 
{
	import Ships.Ship;
	
	/**
	 * ...
	 * @author Kishi
	 */
	public class SimpleBot extends Ai
	{
		private var mShip:Ship;
		
		private var lefttimer:Number = 0;
		
		private var firetimer:Number = Math.random() *5;
		private var goleft:Boolean = false;
		private var gostraight:Boolean = false;
		public function SimpleBot(_ship:Ship) 
		{
			super();
			mShip = _ship;
		}
		
		override public function update():void
		{
			if (!mShip.alive) return;
			lefttimer -= 1 / 30;
			if (lefttimer < 0)
			{
				lefttimer = Math.random() * 3.0;
					if (gostraight) goleft = !goleft;
					gostraight = !gostraight;
					
			}
			firetimer -= 1 / 30;
			if (firetimer < 0)
			{
				firetimer = 5.0 + Math.random() * 10.0;
				mShip.FirePrimary();
			}
			
			mShip.UpEngine();
			if (!gostraight && goleft) mShip.LeftEngine(); 
			else 
			if (!gostraight && !goleft) mShip.RightEngine(); 
		}
	}
	
}