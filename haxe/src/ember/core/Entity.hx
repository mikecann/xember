package ember.core;

import signals.Signal2;
import cmtc.ds.hash.ObjectHash;

/**
 * ...
 * @author MikeCann
 */

class Entity 
{
	public var name(default,null):String;		

	private var _listOfComponents:Array<Dynamic>;
	private var _listOfClasses:Array<Dynamic>;
	private var _components:ObjectHash<Dynamic,Dynamic>; // TODO do I need this?
	private var _componentAdded:Signal2<Entity,Dynamic>;
	private var _componentRemoved:Signal2<Entity,Dynamic>;
			
	public function new(name:String, componentAdded:Signal2<Entity,Dynamic>, componentRemoved:Signal2<Entity,Dynamic>)
	{
		this.name = name;
		_listOfComponents = new Array<Dynamic>();
		_listOfClasses = new Array<Dynamic>();
		_components = new ObjectHash<Dynamic,Dynamic>();
		_componentAdded = componentAdded;
		_componentRemoved = componentRemoved;
	}
	
	public function addComponent(component:Dynamic, ?componentClass:Dynamic = null):Void
	{
		// componentClass ||= component["constructor"]; 
		_components.set(componentClass,component);
		_listOfComponents.push(component);
		_listOfClasses.push(componentClass);
		_componentAdded.dispatch(this, componentClass);
	}

	public function getComponents():Array<Dynamic>
	{
		return _listOfComponents;
	}
	
	public function getClasses():Array<Dynamic>
	{
		
		return _listOfClasses;
	}

	public function getComponent(component:Dynamic):Dynamic
	{
		return _components.get(component);
	}

	public function removeComponent(component:Dynamic):Void
	{
		//if (_components.set(component,null))
			//return;
		
		_components.delete(component);
		_listOfComponents.remove(component);
		_componentRemoved.dispatch(this, component);
	}

	public function hasComponent(component:Dynamic):Bool
	{
		return _components.get(component) != null;
	}	
}