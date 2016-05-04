package Ships.Yehat 
{
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import Ships.Ship;
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
	public class YehatTerminator extends Ship
	{
		
		private var shootsnd:FlxSound;
		private var shootsnd2:FlxSound;
		private var soundfirst:Boolean = true;
		
		[Embed(source='../../../img/yehat_ani.png')] private var ImgShip:Class;
		[Embed(source="../../../snd/yehat_primary.mp3")] private var shootsound:Class;	
		
		private var bullets:Array;		
		private var bulletIndex:int;	
		
		private var soundtimer:int = 0;
		
		private var bShieldOnline:Boolean = false;

		
		public function YehatTerminator(_x:Number,_y:Number,_a:Number=0) 
		{
			super(_x, _y, _a, ImgShip,true,14,17);
			bullets = [];
			var s:FlxSprite;
			for(var i:int = 0; i < 64; i++)		
			{
				s = new AutocannonShell(0, 0, 0, false);
				(s as AutocannonShell).COLLISION_GROUP = COLLISION_GROUP;
				PlayState.instance.SHIPS_LAYER.add(s);
				bullets.push(s);
			}
			
			bulletIndex = 0;	
			
			shootsnd = new FlxSound();
			shootsnd.loadEmbedded(shootsound);		
			
			
			shootsnd2 = new FlxSound();
			shootsnd2.loadEmbedded(shootsound);		
			
			PrimaryWeaponDelay = 3;
			SecondaryWeaponDelay = 100;
			
			addAnimation("intact", [0]);
			addAnimation("wreck", [1]);				
			addAnimation("shield", [2]);				
			
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
					var engine_power:Number = 20.0;
					var engine_vector:Vector2D = new Vector2D(	Math.cos(physBody.a) * engine_power, 
																Math.sin(physBody.a) * engine_power);
					physBody.ApplyImpulse(engine_vector, Vector2D.zeroVect);			
		}
		override public function DownEngine():void
		{
			
		}	
		
		override public function update():void
		{
			super.update();
			
		}
		
		override public function FirePrimary():Boolean
		{
			if (!super.FirePrimary()) return false;
				
				if (soundtimer > 0)
				{
					soundtimer--;
				} else
				{
					if (soundfirst)
					{
						//shootsnd.proximity(x, y, PlayState.instance.player.mShip, 10);
						shootsnd.stop();
						shootsnd.volume = 0.25;
						shootsnd.play();
						soundfirst = !soundfirst;
					} else
					{
						//shootsnd2.proximity(x, y, PlayState.instance.player.mShip, 10);
						shootsnd2.stop();
						shootsnd2.volume = 0.25;
						shootsnd2.play();
						
					}
					soundtimer = 3;
				}
				var engine_power:Number = 400;
				var engine_vector:Vector2D = new Vector2D(Math.cos(physBody.a) * engine_power, Math.sin(physBody.a) * engine_power);
				var firerange:Number = frameWidth-3;
				var cannonpos:Array = [
							new Vector2D(Math.cos(physBody.a+Math.PI/4) * firerange, Math.sin(physBody.a+Math.PI/4) * firerange),
							new Vector2D(Math.cos(physBody.a-Math.PI/4) * firerange, Math.sin(physBody.a-Math.PI/4) * firerange)
							];
				var doubleshot:int = 2;
				while (doubleshot--)
				{
					
				var b:AutocannonShell = bullets[bulletIndex]
				b.Reset(physBody.p.plus(cannonpos[doubleshot]).x , physBody.p.plus(cannonpos[doubleshot]).y,physBody.a*180/Math.PI );
				b.physBody.v.setTo(engine_vector.x, engine_vector.y);
				bulletIndex++;							
				if(bulletIndex >= bullets.length)		
					bulletIndex = 0;			
				}
			return true;
		}		
		
		override public function FireSecondary():Boolean
		{
			if (!super.FireSecondary()) return false;
			if (!bShieldOnline)
			{
				play("shield");
				bShieldOnline = true;
			} else
			{
				play("intact");
				bShieldOnline = false;
			}
			return true;
		}
		
		override public function Kill():void
		{
			super.Kill();
			play("wreck");
			
		}			
		
		override public function TakeDamage(amount:int):void
		{
			if (bShieldOnline) return;
			super.TakeDamage(amount);
		}
	}
	
}