package platform.entities;

/**
 * ...
 * @author Dave
 */
class Replicator extends Entity 
{

	public function new(ID:Int) 
	{
		super();
		frames = H.getFrames();
		animation.addByPrefix('ready', 'port_replicator_', 12);
		animation.play('ready');
		this.ID = ID;
	}
	
}