package Ships.Earthling 
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
	public class Missile extends FlxSprite
	{
	
		[Embed(source = "../../../img/missile_ani.png")] private var missilesprite:Class;
		
		private var exploding:Boolean = false;
		
		private var damage:int = 10;
		
		private var timetolive:Number = 10.0;
		private var timetolivetimer:Number = 0;		
		
		public var COLLISION_GROUP:uint=0;
		
		public function Missile(_x:Number, _y:Number, _a:Number, _exists:Boolean = true ) 
		{
			
			super(_x, _y, null);
			angle = _a;
			loadGraphic(missilesprite, true, false);
			addAnimation("fly", [0]);
			addAnimation("boom", [1, 2, 3, 4, 5, 6, 7, 8 , 9], 30, false);
			exists = _exists;
			offset.x = 37/2;
			offset.y = 37/2;

			//createCircle();
			exploding = true;
		}
		
		public var physBody :RigidBody;
        private function createCircle() : void {
            physBody = new RigidBody(RigidBody.DYNAMIC_BODY, 10, 100);
			physBody.collisionProcessingMask = 7;
            physBody.p.setTo(x, y); 
			physBody.a = angle * Math.PI / 180;
            physBody.addShape(new Polygon(Polygon.createRectangle(25, 5), Vector2D.zeroVect, new Material(1, 0.9, 1)));
			//physBody.rotationLocked = true;
			physBody.setMaxVelocity(200);
			physBody.onCollisionFunc = Hit;
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
			
			if (Math.random() > 0.2) 
			{
				return;
			}
			
			if (e && e.userData && e.userData.ship)
			{
				e.userData.ship.TakeDamage(damage);
			}
			
			exploding = true;
			play("boom");
			PlayState._physicWorld.RemoveRigidBody(physBody);

		}
		
        override public function kill():void
        {
			
            super.kill();
		
        }
		
		override public function reset(X:Number,Y:Number):void
		{
			super.reset(X, Y);
			
			
			if (exploding)
			createCircle();
			//physBody.unlock();
			
			timetolivetimer = timetolive;
			
			exploding = false;
			play("fly");
		}
		
	}
	
}