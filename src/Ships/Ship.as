package Ships 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.rje.glaze.engine.dynamics.RigidBody;
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
	public class Ship extends FlxSprite
	{
		[Embed(source = '../../img/gibs/gibs.png')] private static var ImgGibs:Class;
		[Embed(source = '../../img/gibs/asplode.mp3')] private var ExplosionSnd:Class;
		
		
		public static var GIBS:FlxEmitter;
		
		protected var PrimaryWeaponDelay:int = 10;
		protected var PrimaryDelayTimer:int = 0;
		protected var SecondaryWeaponDelay:int = 10;
		protected var SecondaryDelayTimer:int = 0;
		
		protected var HP:int = 10;
		public var alive:Boolean = true;
		
		protected var xplosion_snd:FlxSound;
		
		public static var COLLISION_GROUP_COUNTER:uint = 1;
		public var COLLISION_GROUP:uint=0;
		
		
		public static function Init():void
		{
			GIBS = new FlxEmitter();
			GIBS.delay = 1.5;
			GIBS.setXSpeed(-20,50);
			GIBS.setYSpeed( -50, 50);
			GIBS.gravity = 0;
			GIBS.setRotation(-720,-720);
			GIBS.createSprites(ImgGibs,100,10,true,0.5);			
		}
		
		public function Ship(X:Number=0, Y:Number=0, A:Number=0,ImgClass:Class=null,ani:Boolean=false,W:uint=0,H:uint=0) 
		{
			super(X, Y, null);

			loadGraphic(ImgClass,ani,false,W,H);
			//loadRotatedGraphic(ImgClass);
			
			offset.x = frameWidth/2;
			offset.y = frameHeight/2;
			
			angle = A;		
			antialiasing = true;
			
			COLLISION_GROUP = COLLISION_GROUP_COUNTER++;
			
			createBody();
			
			xplosion_snd = new FlxSound();
			xplosion_snd.loadEmbedded(ExplosionSnd);
			
		}
		protected var physBody :RigidBody;
        protected function createBody() : void {
			if (physBody) 
			{
				PlayState._physicWorld.RemoveRigidBody(physBody);
			}
            physBody = new RigidBody(RigidBody.DYNAMIC_BODY, 10, 100);
            physBody.p.setTo(x, y); 
			physBody.a = angle * Math.PI / 180;
			physBody.v.setTo(0, 0);
			physBody.w = 0;
            physBody.addShape(new Polygon(Polygon.createRectangle(frameWidth, frameHeight), Vector2D.zeroVect, new Material(1, 0.9, 1)));
            PlayState._physicWorld.AddRigidBody(physBody);
			physBody.rotationLocked = true;
			physBody.setMaxVelocity(100);
			physBody.wake(0);
			physBody.userData = { ship:this };
			physBody.group = COLLISION_GROUP;
			
        }		
		override public function update():void
		{
			//position sync
			x = physBody.p.x ;
			y = physBody.p.y ;
			angle = physBody.a * 180 / Math.PI;
			
			//update sprite
			super.update();
			
			//remove rotation
			if (alive)
			{
				physBody.w = 0;
				//firedelay
				if (PrimaryDelayTimer > 0) PrimaryDelayTimer--;
				if (SecondaryDelayTimer > 0) SecondaryDelayTimer--;
				//kill?
				if (HP <= 0) Kill();
			}
			
		}
		
		public function LeftEngine():void
		{
			
		}
		public function RightEngine():void
		{
			
		}
		public function UpEngine():void
		{
			
		}
		public function DownEngine():void
		{
			
		}
		
		public function FirePrimary():Boolean
		{
			if (PrimaryDelayTimer > 0) return false;
				else PrimaryDelayTimer = PrimaryWeaponDelay;
				
			return true;
		}
		public function FireSecondary():Boolean
		{
			if (SecondaryDelayTimer > 0) return false;
				else SecondaryDelayTimer = SecondaryWeaponDelay;			
			return true;
		}
		public function FireSpecial():Boolean
		{
			return false;
		}
		
		public function TakeDamage(amount:int):void
		{
			
			HP -= amount;
			
		}
		
		public function Kill():void
		{
			alive = false;
			HP = 0;
			//GIBS.at(this);
			GIBS.x = x;
			GIBS.y = y;
			GIBS.start(true, 0, 20);
			
			xplosion_snd.play();

			//PlayState._physicWorld.RemoveRigidBody(physBody);
			//kill();
		}
		
	}
	
}