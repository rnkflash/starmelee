package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class SpaceZomboShooter extends FlxGame
	{
		public function StarMelee()
		{
			super(640,480,MenuState,1);
			//showLogo = false;
		}
	}
}