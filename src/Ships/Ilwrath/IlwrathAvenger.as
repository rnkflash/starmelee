package Ships.Ilwrath
{
	import org.flixel.*;
	import org.rje.glaze.engine.collision.shapes.Circle;
	import org.rje.glaze.engine.collision.shapes.GeometricShape;
	import org.rje.glaze.engine.collision.shapes.Polygon;
	import org.rje.glaze.engine.dynamics.Material;
	import org.rje.glaze.engine.dynamics.RigidBody;
	import org.rje.glaze.engine.math.Vector2D;
	import Ships.Ship;

	public class IlwrathAvenger extends Ship
	{
		private var bullets:Array;		
		private var bulletIndex:int;	
		
		private var shootsnd:FlxSound;
		
		[Embed(source='../../../img/ilwrath_ani.png')] private var ImgShip:Class;
		//[Embed(source="../../../img/missile.mp3")] private var shootsound:Class;	
		
		
		
		public function IlwrathAvenger(_x:Number,_y:Number,_a:Number=0)
		{
			super(_x, _y, _a,ImgShip,true,33,36);
			
			
			bullets = [];	
			bulletIndex = 0;	
			var s:FlxSprite;
			for(var i:int = 0; i < 20; i++)		
			{
				s = new SacredFlame(0, 0, 0, false);
				(s as SacredFlame).COLLISION_GROUP = COLLISION_GROUP;
				PlayState.instance.SHIPS_LAYER.add(s);	
				bullets.push(s);
			}			
			
			
			//shootsnd = new FlxSound();
			//shootsnd.loadEmbedded(shootsound);
			
			addAnimation("intact", [0]);
			addAnimation("wreck", [1]);	
			
			PrimaryWeaponDelay = 6;
			
		}
		
        override protected function createBody() : void {
            physBody = new RigidBody(RigidBody.DYNAMIC_BODY, 10, 100);
            physBody.p.setTo(x, y); 
			physBody.a = angle * Math.PI / 180;
			physBody.v.setTo(0, 0);
			physBody.w = 0;
            physBody.addShape(new Polygon(Polygon.createRectangle(frameWidth, 10), Vector2D.zeroVect, new Material(1, 0.9, 0.5)));
			physBody.addShape(new Polygon(Polygon.createRectangle(10, frameHeight), new Vector2D(-10,0), new Material(1, 0.9, 0.5)));
            PlayState._physicWorld.AddRigidBody(physBody);
			physBody.rotationLocked = true;
			physBody.setMaxVelocity(80);
			physBody.wake(0);
			physBody.userData = { ship:this };
			
			physBody.group = COLLISION_GROUP;
        }
		
		

		
		//overriden controls
		override public function LeftEngine():void
		{
			physBody.w = -4;
		}
		override public function RightEngine():void
		{
			physBody.w = 4;
		}
		override public function UpEngine():void
		{
			
					var engine_power:Number = 100.0;
					var engine_vector:Vector2D = new Vector2D(Math.cos(physBody.a) * engine_power, Math.sin(physBody.a) * engine_power);
					physBody.ApplyImpulse(engine_vector, Vector2D.zeroVect);			
					
			
		}
		override public function DownEngine():void
		{
			
		}
		
		override public function FirePrimary():Boolean
		{
			if (!super.FirePrimary()) return false;
			
			/*
				shootsnd.stop();
				shootsnd.play();
				*/
				var b:SacredFlame = bullets[bulletIndex]
				b.reset(x , y );
				
				var engine_vector:Vector2D = new Vector2D(Math.cos(physBody.a) * 200, Math.sin(physBody.a) * 200);
				var pos_vector:Vector2D = new Vector2D(Math.cos(physBody.a) * 20, Math.sin(physBody.a) * 20);
				b.physBody.p.setTo(physBody.p.plus(pos_vector).x, physBody.p.plus(pos_vector).y) ;
				b.physBody.a = physBody.a;
				b.physBody.v.setTo(engine_vector.x, engine_vector.y);
				b.x = physBody.p.x;
				b.y = physBody.p.y;
				b.angle = b.physBody.a * 180 / Math.PI;
				bulletIndex++;							
				if(bulletIndex >= bullets.length)		
					bulletIndex = 0;			
					
			
			return true;
		}
		override public function FireSecondary():Boolean
		{
			return false;
		}
		override public function FireSpecial():Boolean
		{
			return false;
		}		
		
		override public function Kill():void
		{
			super.Kill();
			play("wreck");
		}		
		
	}
}