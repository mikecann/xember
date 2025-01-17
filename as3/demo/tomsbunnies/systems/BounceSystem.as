package tomsbunnies.systems
{
	import ember.core.EntitySystem;
	import ember.core.Nodes;
	import tomsbunnies.components.SpatialComponent;
	import tomsbunnies.events.Tick;
	import tomsbunnies.systems.nodes.SpatialNode;


	
	public class BounceSystem
	{

		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var tick:Tick;
		
		private const _maxX:int = 640;
		private const _minX:int = 0;
		private const _maxY:int = 480;
		private const _minY:int = 0;
		private const _gravity:int = 3;
		
		private var _entities:Nodes;

		public function onRegister():void
		{
			_entities = system.getNodes(SpatialNode);
			
			tick.add(onTick);
		}
		
		public function onTick(t:Number):void
		{
			var node:SpatialNode;
			for (node = _entities.head as SpatialNode; node; node = node.next)
			{
				var spatial:SpatialComponent = node.spatial;
				
				spatial.position.x += spatial.velocity.x;
				spatial.position.y += spatial.velocity.y;				
				spatial.velocity.y += _gravity;
				
				if (spatial.position.x > _maxX)
				{
					spatial.velocity.x *= -1;
					spatial.position.x = _maxX;
				}
				else if (spatial.position.x < _minX)
				{
					spatial.velocity.x *= -1;
					spatial.position.x = _minX;
				}
				
				if (spatial.position.y > _maxY)
				{
					spatial.velocity.y *= -0.8;
					spatial.position.y = _maxY;
					
					if (Math.random() > 0.5)
					{
						spatial.velocity.y -= Math.random() * 12;
					}
				} 
				else if (spatial.position.y < _minY)
				{
					spatial.velocity.y = 0;
					spatial.position.y = _minY;
				}
			}
		}
		
	}
}