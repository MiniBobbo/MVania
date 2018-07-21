package platform.entities;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import platform.H;
import platform.entities.enemies.PlantBlocker;
import platform.entities.enemies.Rat;
import platform.entities.enemies.RoboRat;
import platform.entities.enemies.Turret;
import platform.entities.enemies.TurretBase;
import platform.entities.enemies.constructionbot.ConstructionBot;
import platform.entities.enemies.flybot.FlyBot;
import platform.entities.enemies.glitchedrobot.GlitchedRobot;
import platform.entities.enemies.porter.Porter;
import platform.entities.gameentites.Enemy;
import platform.entities.things.Door;
import platform.entities.things.Panel;
import platform.entities.things.Terminal;
import tmxtools.TmxRect;

/**
 * ...
 * @author Dave
 */
class EnemyFactory 
{

	/**
	 * Creates an enemy and places it in the correct location and then returns it.
	 * @param	type	The type to create
	 * @param	rect	The rectangle to create it in.  really, just lines up the bottom
	 * @return	The new enemy.  Be sure to add it to the game.
	 */
	public static function createEnemy(type:String, rect:TmxRect, map:FlxTilemap):Enemy {
		var e:Enemy = null;
		switch (type) 
		{
			//Create the specific enemies here.
			case 'constructbot':
				e = new ConstructionBot(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
			case 'roborat':
				e = new RoboRat(map);
				H.rectToTile(rect);
				cast(e, RoboRat).setFinishPosition(rect.r.x, Std.parseFloat(rect.properties.get('finish') ));
				e.reset(rect.r.x, rect.r.y);
			case 'rat':
				e = new Rat(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
			case 'flybot':
				e = new FlyBot(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
			case 'porter':
				e = new Porter(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
			case 'turret':
				var base = createEnemy('turretbase', rect, map);
				if (rect.properties.exists('up'))
					base.flipY = true;
					
				H.ps.nocollide.add(base);
				e = new Turret(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
				if (rect.properties.exists('rate'))
					cast(e, Turret).FIRE_DELAY = Std.parseFloat(rect.properties.get('rate'));
			case 'glitchedrobot':
				e = new GlitchedRobot(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
			case 'turretbase':
				e = new TurretBase(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
			case 'plantblocker':
				e = new PlantBlocker(map);
				//H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
				FlxTween.tween(e, {y:rect.r.y+8}, FlxG.random.float(.8, 1.2), {ease:FlxEase.quadInOut, type:FlxTween.PINGPONG});
			case 'boost':
				e = new BoostUpgrade(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
			case 'terminal':
				e = new Terminal(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
			case 'fire':
				e = new FireAttack(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
				if (H.playerDef.attacks[1]){
					e.exists = false;
					e.visible = false;
					e.hp = 0;
				}
			case 'lightning':
				e = new LightningAttack(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
				if (H.playerDef.attacks[2]){
					e.exists = false;
					e.visible = false;
					e.hp = 0;
				}
			case 'door':
				var code = 0;
				if (rect.properties.exists('code'))
					code = Std.parseInt(rect.properties.get('code'));
				e = new Door(map, code);
				H.rectToTile(rect);
				e.reset(rect.r.x+2, rect.r.y-64);
			case 'panel':
				var code = 0;
				if (rect.properties.exists('code'))
					code = Std.parseInt(rect.properties.get('code'));
				e = new Panel(map, code);
				H.rectToTile(rect);
				e.reset(rect.r.x+2, rect.r.y);
				
				
			default:
				e = new Enemy(map);
				H.rectToTile(rect);
				e.reset(rect.r.x, rect.r.y);
				
		}
		if (rect.properties.exists('facing'))
			e.flipX = true;
		
		return e;
	}
	
	
	
}