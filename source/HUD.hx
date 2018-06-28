package;
import flixel.FlxSprite;
import flixel.addons.text.FlxTextField;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import platform.H;
import platform.entities.Bar;

/**
 * ...
 * @author Dave
 */
class HUD extends FlxSpriteGroup
{
	var selectedBox:FlxSprite;
	var boostCount:FlxText;
	var boost:FlxSprite;
	var healthBar:Bar;
	var energyBar:Bar;
	var BOOST_LOCATION:Float;

	var weaponStart:Int;
	public function new() {
		super();
	}
	
	public  function createHUD() {
		var player = H.ps.player;
		healthBar = new Bar(player, 'hp', player.maxHP); 
		energyBar = new Bar(player, 'energy', player.maxEnergy); 
		energyBar.y = 12;
		energyBar.setBarColor(FlxColor.CYAN);
		
		add(healthBar);
		add(energyBar);
		createWeaponBoxes();
		createBoost();
	}
	
	public function createWeaponBoxes() {
		var a = H.playerDef.attacks;
		selectedBox = createSprite();
		selectedBox.animation.frameName = 'icons_selected_0';
		//Find the larger of the two bars.
		weaponStart = healthBar.barWidth + 10;
		selectedBox.setPosition(weaponStart,0);
			var s = createSprite();
			s.animation.frameName = 'icons_normal_0';
			s.x = weaponStart;
			add(s);
			s.visible = H.playerDef.attacks[0];
			var s2 = createSprite();
			s2.animation.frameName = 'icons_fire_0';
			s2.x = weaponStart + 34;
			add(s2);
			s2.visible = H.playerDef.attacks[1];
			var s3 = createSprite();
			s3.animation.frameName = 'icons_lightning_0';
			s3.x = weaponStart + 68;
			add(s3);
			s3.visible = H.playerDef.attacks[2];
			
			
			
		
		add(selectedBox);
		
		selectWeapon(H.playerDef.attackSelected);
	}
	
	
	private function createSprite():FlxSprite {
		var s = new FlxSprite();
		s.frames = H.getFrames();
		s.setSize(32, 32);
		return s;
	}
	
	public function selectWeapon(selection:Int) {
		selectedBox.x = weaponStart + (34 * selection);
		
		
	}
	
	
	private function createBoost() {
		var booststart = healthBar.barWidth + 100;
		boost = createSprite();
		boost.animation.addByPrefix('boost', 'icons_boost_',6);
		boost.animation.play('boost');
		boost.reset(booststart, 0);
		boostCount = new FlxText(booststart - 3, 16, 0, '');
		boostCount.setFormat(null, 10, FlxColor.WHITE, null, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
		
		if (!H.playerDef.boost) { 
			boost.visible = false;
			boostCount.visible = false;
		}
		
		add(boost);
		add(boostCount);
	}
	
	public function setBoostCount(count:Int) {
		boostCount.text = count + '';
	}
	
}