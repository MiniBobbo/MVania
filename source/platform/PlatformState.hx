package platform;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import inputhelper.InputHelper;
import platform.entities.Attack;
import platform.entities.Bar;
import platform.entities.BossFactory;
import platform.entities.EnemyFactory;
import platform.entities.Entity;
import platform.entities.InteractZone;
import platform.entities.Player;
import platform.entities.Replicator;
import platform.entities.Zone;
import platform.entities.attacks.PlayerShot;
import platform.entities.attacks.UnivAttack;
import platform.entities.bosses.Boss;
import platform.entities.enemies.flybot.FlyBotGenerator;
import platform.entities.gameentites.Enemy;
import platform.entities.interact.TerminalZone;
import platform.entities.things.AntiGravGenerator;
import platform.entities.things.SavePoint;
import platform.entities.zones.AntigravZone;
import platform.entities.zones.DeathZone;
import platform.entities.zones.HelpMessageZone;
import platform.entities.zones.SaveZone;
import platform.entities.zones.SignalZone;
import platform.entities.zones.TravelZone;
import states.MinimapSubState;
import tmxtools.TmxRect;
import tmxtools.TmxTools;

class PlatformState extends FlxState
{
	var maps:TmxTools;
	public var entities:FlxTypedGroup<Entity>;
	
	public var usable:Array<InteractZone>;
	public var zones:FlxTypedGroup<Zone>;
	public var nocollide :FlxTypedGroup<Entity>;
	var rects:Array<TmxRect>;
	
	var bosses:Array<Boss>;
	
	var helpMessage:FlxText;
	
	public var hud:HUD;
	var farbg:FlxSpriteGroup;
	
	var minimap:MinimapSubState;

	
	public var transitioning:Bool = false;
	
	public var collision(default, null):FlxTilemap;
	var bg:FlxTilemap;
	var mg:FlxTilemap;
	var fg:FlxTilemap;
	public var player(default, null):Player;
	
	var emitter:FlxEmitter;
	
	var enemies:FlxTypedGroup<Enemy>;
	public var playerAttacks:FlxTypedGroup<UnivAttack>;
	var enemyAttacks:FlxTypedGroup<UnivAttack>;
	var univAttacks:FlxTypedGroup<UnivAttack>;
	var sprites:FlxSpriteGroup;
	
	var timeInLevel:Float = 0;
	
	public var helpText(default, null):FlxText;
	
	var cover:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		
		trace('Creating playstate');
		H.setPlaystate(this);
		helpMessage = new FlxText(FlxG.width * .1, FlxG.height * .1, FlxG.width * .8, '', 16);
		helpMessage.alpha = 0;
		helpMessage.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
		helpMessage.scrollFactor.set();
		maps = getMap();
		
		usable = [];
		bosses = [];
		entities = new FlxTypedGroup<Entity>();
		nocollide = new FlxTypedGroup<Entity>();
		enemies = new FlxTypedGroup<Enemy>();
		sprites = new FlxSpriteGroup();
		zones = new FlxTypedGroup<Zone>();
		playerAttacks= new FlxTypedGroup<UnivAttack>();
		enemyAttacks = new FlxTypedGroup<UnivAttack>();
		//univAttacks = new FlxTypedGroup<UnivAttack>();
		hud = new HUD();
		farbg = new FlxSpriteGroup();
		hud.scrollFactor.set();
		
		emitter = new FlxEmitter();
		emitter.makeParticles();
		
		destroySubStates = false;
		minimap = new MinimapSubState();
		

		collision = maps.getMap('collision');
		mg = maps.getMap('mg');
		fg= maps.getMap('fg');
		FlxG.worldBounds.set(collision.width, collision.height);
		FlxG.camera.bgColor = FlxColor.BLACK;
		rects = maps.getTmxRectanges();
		trace('Running playstate');
		
		//FlxG.watch.add(helpText, 'visible');
		
		//Create player attacks
		for (i in 0...10) {
			playerAttacks.add(new UnivAttack(10));
		}
		
		placeZones();
		
		add(collision);
		BGFactory.createSpecialBG(H.currentLevel, this);
		bg = maps.getMap('bg');
		if (bg != null)
			add(bg);
		add(mg);
		//collision.visible = true;
		//
		//playerAttacks.add(player.attack);
		
		
		FlxG.watch.add(H, 'currentLevel');
		FlxG.watch.add(H, 'previousLevel');
		//FlxG.watch.add(playerAttacks.members, 'length', 'Player attacks');
		//FlxG.watch.add(enemies.members, 'length', 'enemies');
		//FlxG.watch.add('Player attacks: ' + playerAttacks.countLiving());
		add(nocollide);
		add(sprites);
		add(enemies);
		add(player);
		add(zones);
		add(enemyAttacks);
		add(playerAttacks);
		//add(univAttacks);
		add(emitter);
		if (fg != null)
			add(fg);

		add(zones);
		createHUD();
		add(hud);
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER, 1);
		FlxG.camera.setScrollBoundsRect(0, 0, collision.width, collision.height);
		
		FlxG.camera.fade(FlxColor.BLACK, .3, true);
		//trace('Finished Create');
		
	}

	private function createPlayer(r:TmxRect) {
		try{ 

		player = new Player(collision);
		//player.maxHP = H.playerDef.playerMaxHealth;
		//player.hp = H.playerDef.playerHealth;
		//player.attackType = H.playerDef.attackSelected;
		//player.energy = H.playerDef.playerEnergy;
		//player.maxEnergy = H.playerDef.playerMaxEnergy;
		
		entities.add(player);
		player.setBottom(r.r.bottom);
		player.x = r.r.x;
		
		if (H.playerDef.boost) {
		player.setBoostCount(1);
			
		}
			
		} catch (err:Dynamic)
		{
			trace(err);
		}
		
		player.health = H.playerDef.playerHealth;
		//trace('After player creation ' + player.toString());
		//add(player);
	}
	
	var travelZonesPlaced:Bool = false;
	
	override public function update(elapsed:Float):Void
	{

		timeInLevel += elapsed;
		if (timeInLevel > .1 && !travelZonesPlaced)
			placeTravelZones();

			helpMessage.alpha -= 1 * elapsed;
			
		//Update the boss object.  This doesn't update the children, who will be updated with the enemies.
		for (b in bosses)
			b.update(elapsed);
		

		FlxG.collide(enemyAttacks, collision, attackHitsMap);
		FlxG.overlap(enemyAttacks, player, attackHits);
		//FlxG.overlap(player.attack, enemyAttacks, playerHitsAttack);
		InputHelper.updateKeys(elapsed);
		try {
			super.update(elapsed);
			
		} catch (err:Dynamic)
		{
			trace(err);
		}
			FlxG.overlap(entities, zones, EntityOverlapZone);
		FlxG.collide(player, collision);
		FlxG.collide(enemies, collision);
		
		FlxG.collide(playerAttacks, collision, attackHitsMap);
		FlxG.collide(univAttacks, collision, attackHitsMap);
		FlxG.overlap(playerAttacks, enemies, attackHits);
		FlxG.overlap(player, enemies, playerOverlapEntity);
		
		//Check if the player used something
		if (InputHelper.isButtonJustPressed('use')) {
			use();
		}
		
		if (InputHelper.isButtonJustPressed('map')) {
			trace('opened substate');
			openSubState(minimap);
		}
		hud.setBoostCount(player.currentBoostCount);
		//hud.setDebugMessage(FlxG.);
	}
	
	public function attackHits(a:Attack, e:Entity) {
		if (!a.alive)
			return;
		if (e.alive && a.ID != e.IDLastAttackHit) {
			a.hitEntity(e);
			e.signal('hit', a);
		}
	}
	
	
	public function attackHitsMap(a:Attack, collision:FlxTilemap) {
		a.hitMap();
	}
	
	public function playerOverlapEntity(p:Player, e:Entity) {
		if (p.hp > 0 && (e.hp > 0 || e.hp == -1)) {
			p.overlapEntity(e);
			e.overlapEntity(p);
			
		}
	}
	
	public function EntityOverlapZone(e:Entity, z:Zone) {
		//trace(e.toString() + ' overlaps ' +  z.toString());
		if(z.alive)
			z.overlapEntity(e);
	}
	

	private function placeTravelZones() {
		for (r in rects) { 
			if (r.name == 'travel') {
				var type:String = r.properties.get('type');
				var s = type.split('_');
				var t = new TravelZone(r.r.x, r.r.y, r.r.width, r.r.height, s[0], s[1]);
				zones.add(t);
			}
		}
		travelZonesPlaced = true;
		trace('Placed zones: ' + zones.members.length);
		
	}
	
	private function placeZones() {
		var playerPlaced:Bool = false;
		
		var destinationRects:Array<TmxRect> = []; 
		
		for (r in rects) {
			//FlxG.log.add(r);
			switch (r.name) 
			{
				case 'enemy':
					//trace('creating enemy ' + r.properties.get('type'));
					var enemy = EnemyFactory.createEnemy(r.properties.get('type'), r, collision);
					enemies.add(enemy);
					entities.add(enemy);
				case 'boss':
					var b = BossFactory.createBoss(r.properties.get('type'), r, collision);
					for (e in b.members) {
						enemies.add(e);
						entities.add(e);
					}
					bosses.push(b);
				case 'message':
					var m:HelpMessageZone = new HelpMessageZone(r.r.x, r.r.y, r.r.width, r.r.height, r.properties.get('type'));
					zones.add(m);
				case 'd':
					destinationRects.push(r);
				case 'travel':
				case 'terminal' :
					H.rectToTile(r);
					var terminalZone = new TerminalZone(r.r.x, r.r.y, 32, 32);
					if (r.properties.exists('code'))
						terminalZone.setCode(Std.parseInt(r.properties.get('code')));
					usable.push(terminalZone);
					var enemy = EnemyFactory.createEnemy('terminal', r, collision);
					nocollide.add(enemy);


					
				case 'antigrav':
					var height = Std.parseInt(r.properties.get('type'));
					H.rectToTile(r);
					r.r.y -= height * 32;
					r.r.height = height * 32;
					var agz = new AntigravZone(r.r.x, r.r.y, r.r.width, r.r.height);
					if (r.properties.exists('str'))
						agz.setStrength(Std.parseFloat(r.properties.get('str')));
					zones.add(agz);
					
					var e = new AntiGravGenerator(collision);
					e.setPosition(r.r.x, r.r.y + r.r.height);
					e.setAntiGrav(agz);
					if (r.properties.exists('on')) {
						
						if (r.properties.get('on') == 'yes') {
							e.signal('on');
						}
						else
							e.signal('off');
					}
					entities.add(e);
					nocollide.add(e);
				case 'save':
					H.rectToTile(r);
					//Create the save message
					var m:HelpMessageZone = new HelpMessageZone(r.r.x - 32, r.r.y - 64, 96, 64, 'Press UP to save');
					zones.add(m);
					//Create the SavePoint graphical object.
					var sp = new SavePoint(collision);
					sp.setPosition(r.r.x - 32, r.r.y);
					nocollide.add(sp);
					entities.add(sp);
					
					//Create the interactive SaveZone
					var sz = new SaveZone(r.r.x - 32, r.r.y - 64, 96, 64);
					sz.setSavePoint(sp);
					usable.push(sz);
				case 'sprite':
					var splitrects = H.rectToRects(r);
					for (i in splitrects) {
						var s = EnemyFactory.createEnemy(r.properties.get('type'), i, collision);
						entities.add(s);
						enemies.add(s);
					}
				case 'death':
					var d = new DeathZone(r.r.x, r.r.y, r.r.width, r.r.height);
					zones.add(d);
				case 'start':
					createPlayer(r);
				case 'flybotgen':
					var g = new FlyBotGenerator(collision);
					H.rectToTile(r);
					r.r.x -= 16;
					r.r.y -= 16;
					g.reset(r.r.x, r.r.y);
					g.setEnemies(enemies);
					
					enemies.add(g);
					entities.add(g);
					
					
				default:
				trace( 'Problem with a zone.  ' + r.name);
					
					
			}
			
		}
			if (H.previousLevel == 'save') {
				for (r in rects) {
					if (r.name == 'save') {
						spawnPlayer(r);
						break;
					}
				}
			} else {
				for(r in destinationRects) {
					if (r.properties.get('type') == H.previousLevel) {
						playerPlaced = true;
						createPlayer(r);
					}
				}

			}

		
	}
	
	private function getMap() {
		var tools:TmxTools = null;
		try {
			tools = new TmxTools('assets/data/levels/' + H.currentLevel +'.tmx', 'assets/data/levels/');
		} catch (err:Dynamic)
		{
			trace('Error creating TMX Tools for ' + H.currentLevel);
		}
		
		return tools;
	}
	
	/**
	 * Removes this state and creates a new one.  Used when traveling or when the player dies.
	 */
	public function resetState() {
		if (transitioning)
			return;
		
			//Save the player's current stats to the PlayerDef so they can be loaded next time.
			H.playerDef.attackSelected = player.attackType;
			H.playerDef.playerHealth = player.hp;
			H.playerDef.playerMaxHealth = player.maxHP;
			
			
		FlxG.camera.fade(FlxColor.BLACK, .2, false, function() {
			var s = new PlatformState();
			H.ps = s;
			FlxG.switchState(s);
			transitioning = true;
			
		});
	}
	
	public function killPlayer() {
		player.animation.play('dead');
		H.previousLevel = 'save';
		FlxTween.tween(player, {alpha:0});
		FlxTween.color(player, .3, FlxColor.WHITE, FlxColor.RED);
		FlxTween.tween(cover, {x:0}, .3, {startDelay:1.5, onComplete:  function (_) {
				new FlxTimer().start(.5, function(_) {   H.ps.resetState(); });
		}});
	}
	
	public function getUnivAttack():UnivAttack {
		var a = univAttacks.getFirstAvailable();
		if (a == null) {
			a = new UnivAttack();
			univAttacks.add(a);
		}
		return a;
	}
	
	
	public function getPlayerAttack():UnivAttack {
		var a = playerAttacks.getFirstAvailable();
		if (a == null) {
			a = new UnivAttack();
			playerAttacks.add(a);
		}
		return a;
	}
	
	public function getEnemyAttack():UnivAttack {
		var a = enemyAttacks.getFirstAvailable();
		if (a == null) {
			a = new UnivAttack();
			enemyAttacks.add(a);
		}
		return a;
	}
	
	private function createHUD() {
		hud = new HUD();
		hud.scrollFactor.set();
		hud.createHUD();
		//helpMessage = new FlxText(0, 100, FlxG.width, '');
		//helpMessage.setFormat(null, 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
		//helpMessage.alpha = 0;
		hud.add(helpMessage);
	}
	
	/**
	 * Searches through all the usable objects in the level and uses the first one that overlaps the player.
	 */
	function use():Void 
	{
		for (z in usable) {
			if (z.overlaps(player)) {
				z.interact();
				break;
			}
		}
	}
	
	/**
	 * Handles all the animations and the screen transitions for the saving of the game.
	 */
	public function useSavePoint() {
		
		H.saveGame();
		resetState();
	}
	
	
	public function displayHelpMessage(message:String) {
		helpMessage.text = message;
		helpMessage.alpha = 1;
		
	}
	
	/**
	 * This creates the player from a save location.  This calls createPlayer, so don't call it again.
	 * @param	r	The TmxRect for the save point.
	 */
	private function spawnPlayer(r:TmxRect) {
		trace('Trying to spawn player ' + r);
		H.rectToTile(r);
		r.r.x + 40;
		createPlayer(r);
		player.hp= H.playerDef.playerMaxHealth;
		player.animation.play('idle');
		player.fsm.hold();
		player.setBottom(r.r.y);
		player.alpha = 0;
		H.signalAll('saveup');
		new FlxTimer().start(1.5, function(_) {
			H.signalAll('saveworking');
		FlxTween.tween(player, {alpha:1});
		});
		
		new FlxTimer().start(4, function(_) {
			H.signalAll('savedown');
		player.fsm.resume();
		});
	}
}
