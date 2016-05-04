package Physics 
{
	
	import flash.display.Graphics;
	import org.rje.glaze.engine.collision.shapes.AABB;
    import org.rje.glaze.engine.collision.shapes.Circle;
    import org.rje.glaze.engine.collision.shapes.GeometricShape;
    import org.rje.glaze.engine.collision.shapes.Polygon;
    import org.rje.glaze.engine.dynamics.Material;
    import org.rje.glaze.engine.dynamics.RigidBody;
    import org.rje.glaze.engine.dynamics.joints.Joint;
    import org.rje.glaze.engine.math.Vector2D;
    import org.rje.glaze.engine.space.BruteForceSpace;
	import org.rje.glaze.engine.space.SortAndSweepSpace;
    import org.rje.glaze.engine.space.Space;    
	import org.rje.glaze.engine.space.SpacialHashSpace;
	
	/**
	 * ...
	 * @author Kishi
	 */
	public class GlazeStuff 
	{
        /** The space that all the physics objects are created in */
        private var space : Space;

        /** Whether to draw bounding boxes or not */
        private var debug : Boolean = false;
		
		public function GlazeStuff() 
		{
			
		}
		
		public function Init():void
		{
            // Initialize the space
            space = new SortAndSweepSpace(30, 90);
			
			
		}
		
		public function AddRigidBody(b:RigidBody):void
		{
			space.addRigidBody(b);
		}
		
		public function RemoveRigidBody(b:RigidBody):void
		{
			space.removeRigidBody(b);
		}
		
		public function Update():void
		{
			space.step();
			
		}
		
		public function DebugDraw(somegraphics:Graphics):void
		{
            // Draw all the active shapes
            var shape : GeometricShape = space.activeShapes;
            while (shape) {
                shape.draw(somegraphics, debug,true,0xff0000,0.5);
                shape = shape.next;
            }
            
            // Draw all the static shapes
            shape = space.staticShapes;
            while (shape) {
                shape.draw(somegraphics, debug);
                shape = shape.next;
            }
            
            // Draw all the joints
            var joint : Joint = space.joints;
            while (joint) {
                joint.draw(somegraphics, debug);
                joint = joint.next;
			}
			
		}
		
	}
	
}