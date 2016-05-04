package Ships.Alien
{
	import org.flixel.*;
	import org.rje.glaze.engine.collision.shapes.Circle;
	import org.rje.glaze.engine.collision.shapes.GeometricShape;
	import org.rje.glaze.engine.collision.shapes.Polygon;
	import org.rje.glaze.engine.dynamics.Material;
	import org.rje.glaze.engine.dynamics.RigidBody;
	import org.rje.glaze.engine.math.Vector2D;
	import Ships.Ship;

	public class AlienCruiser extends Ship
	{
		private var bullets:Array;		
		private var bulletIndex:int;	
		
		private var shootsnd:FlxSound;
		
		[Embed(source = "../../../img/blackurq.big.4.png")] private var ImgShip:Class;
		
		[Embed(source = "../../../img/urquan.big.4.png")] private var ImgShip2:Class;
		[Embed(source = "../../../img/druuge.big.4.png")] private var ImgShip3:Class;
		[Embed(source = "../../../img/ilwrath.big.4.png")] private var ImgShip4:Class;
		
		private var ships:Array = [ { img:ImgShip}, { img:ImgShip2 },{ img:ImgShip3 },{ img:ImgShip4 } ];
		

		
		public function AlienCruiser(_x:Number,_y:Number,_a:Number=0)
		{
			var randomtype:int = Math.floor(Math.random() * ships.length);
			super(_x, _y, _a,ships[randomtype].img);
			
			
		}
		
		private var cirBody :RigidBody;
        private function createBody() : void {
            cirBody = new RigidBody(RigidBody.DYNAMIC_BODY, 10, 100);
            cirBody.p.setTo(x, y); 
			
            cirBody.addShape(new Polygon(Polygon.createRectangle(frameWidth, frameHeight), Vector2D.zeroVect, new Material(1, 0.9, 1)));
            PlayState._physicWorld.AddRigidBody(cirBody);
			
			var oupos:Vector2D = new Vector2D(300, 0);
			var firePos:Vector2D = new Vector2D(300, -100);
			var projVelocity:Vector2D = oupos.minus(firePos).normalize().multEquals(8);
			cirBody.v.copy(projVelocity);
			cirBody.w = Math.random() * 2.0;
			cirBody.v.x = Math.random() * 100.0-Math.random() * 50.0;
			cirBody.v.y = Math.random() * 100.0-Math.random() * 50.0;
			cirBody.rotationLocked = true;
			
			
        }
		
		
		override public function update():void
		{

			x = cirBody.p.x ;
			y = cirBody.p.y ;
			
			angle = cirBody.a * 180 / Math.PI;
			
			
			super.update();
			
			

			
				
				/*
				var testpoint:FlxPoint = FlxU.rotatePoint(150,0,0,0,angle);
				PlayState.DEBUG_SCREEN.graphics.moveTo(x+ offset.x+FlxG.scroll.x, y+ offset.y+FlxG.scroll.y);
				PlayState.DEBUG_SCREEN.graphics.lineStyle(1, 0x00ff00);
				PlayState.DEBUG_SCREEN.graphics.lineTo(x + offset.x +FlxG.scroll.x+ velocity.x, y + offset.y +FlxG.scroll.y+ velocity.y);
				*/
				
			
		}
	}
}