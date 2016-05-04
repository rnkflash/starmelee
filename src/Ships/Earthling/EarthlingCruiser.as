package Ships.Earthling
{
	import org.flixel.*;
	import org.rje.glaze.engine.collision.shapes.Circle;
	import org.rje.glaze.engine.collision.shapes.GeometricShape;
	import org.rje.glaze.engine.collision.shapes.Polygon;
	import org.rje.glaze.engine.dynamics.Material;
	import org.rje.glaze.engine.dynamics.RigidBody;
	import org.rje.glaze.engine.math.Vector2D;
	import Ships.Ship;

	public class EarthlingCruiser extends Ship
	{
		private var bullets:Array;		
		private var bulletIndex:int;	
		
		private var shootsnd:FlxSound;
		
		
		[Embed(source='../../../img/human_ani.png')] private var ImgShip:Class;
		[Embed(source="../../../img/missile.mp3")] private var shootsound:Class;	
		
		
		public function EarthlingCruiser(_x:Number,_y:Number,_a:Number=0)
		{
			super(_x, _y, _a, ImgShip, true, 42, 11);
			
			bullets = [];
			var s:FlxSprite;
			for(var i:int = 0; i < 8; i++)		
			{
				s = new Missile(0, 0, 0, false);
				(s as Missile).COLLISION_GROUP = COLLISION_GROUP;
				PlayState.instance.SHIPS_LAYER.add(s);
				bullets.push(s);
			}
			
			bulletIndex = 0;	
			
			
			shootsnd = new FlxSound();
			shootsnd.loadEmbedded(shootsound);
			
			PrimaryWeaponDelay = 20;
			
			addAnimation("intact", [0]);
			addAnimation("wreck", [1]);
			
		}
		

		override public function LeftEngine():void
		{
			physBody.w = -2;
		}
		override public function RightEngine():void
		{
			physBody.w = 2;
		}
		override public function UpEngine():void
		{
					var engine_power:Number = 30.0;
					var engine_vector:Vector2D = new Vector2D(Math.cos(physBody.a) * engine_power, Math.sin(physBody.a) * engine_power);
					//var dx:Number = engine_vector.x - physBody.v.x > 0?engine_power: -engine_power;
					//var dy:Number = engine_vector.y - physBody.v.y > 0?engine_power: -engine_power;
					//physBody.v.plusEquals(new Vector2D(dx,dy));
					physBody.ApplyImpulse(engine_vector, Vector2D.zeroVect);			
		}
		override public function DownEngine():void
		{
			
		}
		
		override public function FirePrimary():Boolean
		{
				if (!super.FirePrimary()) return false;
			
				shootsnd.stop();
				shootsnd.play();
				var b:Missile = bullets[bulletIndex]
				b.reset(x , y );
				
				var range_from_center:Number = 10;
				var engine_vector:Vector2D = new Vector2D(Math.cos(physBody.a) * 200, Math.sin(physBody.a) * 200);
				var pos_vector:Vector2D = new Vector2D(Math.cos(physBody.a) * range_from_center, Math.sin(physBody.a) * range_from_center);
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