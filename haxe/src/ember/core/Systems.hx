package ember.core;

import cmtc.ds.hash.ObjectHash;
import xirsys.injector.Injector;

/**
 * ...
 * @author MikeCann
 */

class Systems 
{

	private var _injector:Injector;
	private var _systems:ObjectHash<Dynamic,Dynamic>;
	
	public function new(injector:Injector)
	{
		_injector = injector;
		_systems = new ObjectHash<Dynamic,Dynamic>();
	}
	
	public function add(systemClass:Dynamic):Void
	{
		var system:Dynamic = _injector.instantiate(systemClass);
		_systems.set(systemClass,system);
		
		system.onRegister();
	}

	public function has(systemClass:Dynamic):Bool
	{
		return _systems.get(systemClass) != null;
	}

	public function get(systemClass:Dynamic):Dynamic
	{
		return _systems.get(systemClass);
	}

	public function remove(systemClass:Dynamic):Bool
	{
		var system:Dynamic = _systems.get(systemClass);
		if (!system)
			return false;
		
		_systems.delete(systemClass);
		system.hasOwnProperty("onRemove") && system.onRemove();
		
		return true;
	}

}