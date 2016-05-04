package Ships.Yehat 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.rje.glaze.engine.collision.shapes.Circle;
	import org.rje.glaze.engine.collision.shapes.GeometricShape;
	import org.rje.glaze.engine.collision.shapes.Polygon;
	import org.rje.glaze.engine.dynamics.Material;
	import org.rje.glaze.engine.dynamics.RigidBody;
	import org.rje.glaze.engine.math.Vector2D;	
	/**
	 * ...
	 * @author Kishi
	 */
	public class AutocannonShell extends FlxSprite
	{
	
		[Embed(source = "../../../img/missile.big.4.png")] private var shellsprite:Class;
		
		private var exploding:Boolean = false;
		
		private var timetolive:Number = 3.0;
		private var timetolivetimer:Number = 0;
		
		private var damage:int = 1;
		
		public var COLLISION_GROUP:uint=0;
		
		public function AutocannonShell(_x:Number, _y:Number, _a:Number, _exists:Boolean = true ) 
		{
			
			super(_x, _y, null);
			angle = _a;
			loadGraphic(shellsprite, true, false, 5, 5);
			addAnimation("fly", [0]);
			addAnimation("boom", [1], 10, false);
			exists = _exists;
			offset.x = frameWidth/2;
			offset.y = frameHeight/2;

			//createCircle();
			exploding = true;
		}
		
		public var physBody :RigidBody;
        private function createCircle() : void {
            physBody = new RigidBody(RigidBody.DYNAMIC_BODY, 10, 100);
			physBody.collisionProcessingMask = 7;
            physBody.p.setTo(x, y); 
			physBody.a = angle * Math.PI / 180;
            //physBody.addShape(new Polygon(Polygon.createRectangle(frameWidth, frameHeight), Vector2D.zeroVect, new Material(1, 0.9, 1)));
			physBody.addShape(new Circle(frameWidth/2, Vector2D.zeroVect, new Material(1, 0.9, 1)));
			//physBody.rotationLocked = true;
			physBody.setMaxVelocity(400);
			physBody.onCollisionFunc = Hit;
			physBody.setMass(0.1);
			physBody.group = COLLISION_GROUP;
			PlayState._physicWorld.AddRigidBody(physBody);
			//physBody.lock();
        }		
		
		override public function update():void
		{
            if(exploding)
            {
                if(finished) kill();
                else
                    super.update();
                return;
            } else
			{
				timetolivetimer-= 1 / 30;
				if (timetolivetimer < 0)
				{
					Hit(null);
					
				}
			}
			
			x = physBody.p.x ;
			y = physBody.p.y ;
			
			angle = physBody.a * 180 / Math.PI;			
			
			super.update();
		}
		
		
		public function Hit(e:RigidBody):void
		{
            if(exploding)
                return;      
			
			if (e && e.userData && e.userData.ship)
			{
				e.userData.ship.TakeDamage(damage);
			}				
			
			exploding = true;
			play("boom");
			PlayState._physicWorld.RemoveRigidBody(physBody);
			//physBody.lock();
			
			//physBody.unregisterSpace();
			//trace("nu ka "+physBody.space);
			//e.kill();
			//kill();
		}
		
        override public function kill():void
        {
			
            super.kill();
		
        }
		
		public function Reset(X:Number,Y:Number,A:Number):void
		{
			super.reset(X, Y);
			angle = A;
			
			if (exploding)
			createCircle();
			else
			{
				physBody.p.x = x;
				physBody.p.y = y;
				physBody.a = angle * Math.PI/180;
				
			}
			//physBody.unlock();
			
			
			exploding = false;
			play("fly");
			
			timetolivetimer = timetolive;
		}
		
	}
	
}