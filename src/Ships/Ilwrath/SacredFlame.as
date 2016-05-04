package Ships.Ilwrath 
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
	public class SacredFlame extends FlxSprite
	{
	
		[Embed(source='../../../img/ilwrath/flame/sacred_flame.png')] private var flamesprite:Class;
		
		public var COLLISION_GROUP:uint = 0;
		private var exploding:Boolean = false;
		private var damage:int = 2;
		private var delta_size:Number = 0;
		
		public function SacredFlame(_x:Number, _y:Number, _a:Number, _exists:Boolean = true ) 
		{
			
			super(_x, _y, null);
			angle = _a;
			loadGraphic(flamesprite, true, false, 19, 19, true);
			addAnimation("normal", [8]);
			//addAnimation("boom", [5, 6, 7, 8], 30, false);
			addAnimation("boom", [8,7,6,5,4,3,2,1], 30, false);
			addAnimation("wroom", [1, 2, 3, 4, 5, 6, 7, 8], 15, false);
			
			exists = _exists;
			offset.x = frameWidth/2;
			offset.y = frameHeight / 2;
			
			delta_size = frameWidth / (16*3);

			//createCircle();
			exploding = true;
		}
		
		public var physBody :RigidBody;
        private function createCircle() : void {
            physBody = new RigidBody(RigidBody.DYNAMIC_BODY, 10, 100);
			physBody.collisionProcessingMask = 7;
            physBody.p.setTo(x, y); 
			physBody.a = angle * Math.PI / 180;
            //physBody.addShape(new Polygon(Polygon.createRectangleframeWidth, frameHeight), Vector2D.zeroVect, new Material(1, 0.9, 0.1)));
			physBody.addShape(new Circle(0, Vector2D.zeroVect, new Material(1, 0.9, 0.1)));
			physBody.setMass(0.1);
			//physBody.rotationLocked = true;
			physBody.setMaxVelocity(200);
			physBody.onCollisionFunc = Hit;
			PlayState._physicWorld.AddRigidBody(physBody);
			//physBody.lock();
			physBody.group = COLLISION_GROUP;
        }		
		
		override public function update():void
		{
            if(exploding)
            {
				if (finished)
                kill();
                super.update();
                return;
            } else
			{
				if (finished) Hit(null);
			}
			
			x = physBody.p.x ;
			y = physBody.p.y ;
			
			angle = physBody.a * 180 / Math.PI;		
			(physBody.memberShapes[0] as Circle).r += delta_size;
			
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
		
		override public function reset(X:Number,Y:Number):void
		{
			super.reset(X, Y);
			
			
			if (exploding)
			createCircle();
			//physBody.unlock();
			
			
			exploding = false;
			play("wroom");
		}
		
	}
	
}