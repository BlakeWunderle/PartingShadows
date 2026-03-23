class_name FighterDBMeta

## Class metadata: display names, ability lookups, and flavor text for all 56 classes.

const AbilityDB := preload("res://scripts/data/ability_db.gd")
const PAB := preload("res://scripts/data/ability_db_player.gd")


static func get_display_name(class_id: String) -> String:
	match class_id:
		# T0
		"Squire": return "Squire"
		"Mage": return "Mage"
		"Entertainer": return "Entertainer"
		"Tinker": return "Tinker"
		"Wildling": return "Wildling"
		# T1:Squire
		"Duelist": return "Duelist"
		"Ranger": return "Ranger"
		"MartialArtist": return "Martial Artist"
		# T1:Mage
		"Invoker": return "Invoker"
		"Acolyte": return "Acolyte"
		# T1:Entertainer
		"Bard": return "Bard"
		"Dervish": return "Dervish"
		"Orator": return "Orator"
		# T1:Tinker
		"Artificer": return "Artificer"
		"Cosmologist": return "Philosopher"
		"Arithmancer": return "Arithmancer"
		# T1:Wildling
		"Herbalist": return "Herbalist"
		"Shaman": return "Shaman"
		"Beastcaller": return "Beastcaller"
		# T0:Wanderer
		"Wanderer": return "Wanderer"
		# T1:Wanderer
		"Sentinel": return "Sentinel"
		"Pathfinder": return "Pathfinder"
		# T2:Squire
		"Cavalry": return "Cavalry"
		"Dragoon": return "Dragoon"
		"Mercenary": return "Mercenary"
		"Hunter": return "Hunter"
		"Ninja": return "Ninja"
		"Monk": return "Monk"
		# T2:Mage
		"Infernalist": return "Infernalist"
		"Tidecaller": return "Tidecaller"
		"Tempest": return "Tempest"
		"Paladin": return "Paladin"
		"Priest": return "Priest"
		"Warlock": return "Warlock"
		# T2:Entertainer
		"Warcrier": return "Warcrier"
		"Minstrel": return "Minstrel"
		"Illusionist": return "Illusionist"
		"Mime": return "Mime"
		"Laureate": return "Laureate"
		"Elegist": return "Elegist"
		# T2:Tinker
		"Alchemist": return "Alchemist"
		"Bombardier": return "Bombardier"
		"Chronomancer": return "Chronomancer"
		"Astronomer": return "Astronomer"
		"Automaton": return "Automaton"
		"Technomancer": return "Technomancer"
		# T2:Wildling
		"Blighter": return "Blighter"
		"GroveKeeper": return "Grove Keeper"
		"WitchDoctor": return "Witch Doctor"
		"Spiritwalker": return "Spiritwalker"
		"Falconer": return "Falconer"
		"Shapeshifter": return "Shapeshifter"
		# T2:Wanderer
		"Bulwark": return "Bulwark"
		"Aegis": return "Aegis"
		"Trailblazer": return "Trailblazer"
		"Survivalist": return "Survivalist"
		_: return class_id


static func get_abilities_for_class(class_id: String) -> Array:
	match class_id:
		# T0
		"Squire": return [AbilityDB.slash(), AbilityDB.guard()]
		"Mage": return [AbilityDB.arcane_bolt()]
		"Entertainer": return [AbilityDB.mockery(), AbilityDB.demoralize()]
		"Tinker": return [AbilityDB.proof(), AbilityDB.energy_blast()]
		"Wildling": return [AbilityDB.thorn_whip(), AbilityDB.bark_skin()]
		"Wanderer": return [AbilityDB.wild_strike(), AbilityDB.natures_ward()]
		# T1:Squire
		"Duelist": return [AbilityDB.slash(), PAB.feint()]
		"Ranger": return [PAB.pierce(), PAB.double_arrow()]
		"MartialArtist": return [PAB.punch(), PAB.topple()]
		# T1:Mage
		"Invoker": return [AbilityDB.arcane_bolt(), PAB.elemental_surge()]
		"Acolyte": return [PAB.cure(), PAB.protect(), PAB.radiance()]
		# T1:Entertainer
		"Bard": return [PAB.seduce(), PAB.melody(), PAB.encourage()]
		"Dervish": return [PAB.mesmerize(), PAB.dance()]
		"Orator": return [PAB.oration(), PAB.encourage()]
		# T1:Tinker
		"Artificer": return [AbilityDB.energy_blast(), PAB.magical_tinkering()]
		"Cosmologist": return [PAB.time_warp(), PAB.black_hole(), PAB.gravity()]
		"Arithmancer": return [PAB.theorem(), PAB.calculate()]
		# T1:Wildling
		"Herbalist": return [PAB.mending_herbs(), PAB.sapping_vine()]
		"Shaman": return [PAB.spectral_lance(), PAB.player_hex()]
		"Beastcaller": return [PAB.feral_strike(), PAB.pack_howl(), PAB.stampede()]
		# T1:Wanderer
		"Sentinel": return [PAB.shield_bash(), PAB.barrier(), PAB.fortify()]
		"Pathfinder": return [PAB.keen_strike(), PAB.exploit_weakness()]
		# T2:Squire
		"Cavalry": return [PAB.lance(), PAB.trample(), AbilityDB.rally()]
		"Dragoon": return [PAB.jump(), PAB.wyvern_strike(), PAB.dragon_ward()]
		"Mercenary": return [PAB.gun_shot(), PAB.called_shot(), PAB.quick_draw()]
		"Hunter": return [PAB.triple_arrow(), PAB.snare(), PAB.hunters_mark()]
		"Ninja": return [PAB.sweeping_slash(), PAB.dash(), PAB.blade_flurry()]
		"Monk": return [PAB.spirit_attack(), PAB.precise_strike(), PAB.meditate()]
		# T2:Mage
		"Infernalist": return [PAB.fire_ball(), PAB.burning_brand(), PAB.cauterize()]
		"Tidecaller": return [PAB.purify(), PAB.tsunami(), PAB.undertow()]
		"Tempest": return [PAB.hurricane(), PAB.tornado(), PAB.eye_of_the_storm()]
		"Paladin": return [PAB.cure(), PAB.holy_strike(), PAB.smite()]
		"Priest": return [PAB.restoration(), PAB.heavenly_body(), PAB.holy()]
		"Warlock": return [PAB.shadow_bolt(), PAB.curse(), PAB.drain_life()]
		# T2:Entertainer
		"Warcrier": return [PAB.battle_cry(), PAB.encore(), PAB.rally_cry()]
		"Minstrel": return [PAB.ballad(), PAB.dissonance(), PAB.serenade()]
		"Illusionist": return [PAB.phantom_strike(), PAB.mirage(), PAB.bewilderment()]
		"Mime": return [PAB.invisible_wall(), PAB.anvil(), PAB.invisible_box()]
		"Laureate": return [PAB.ovation(), PAB.recite(), PAB.eulogy()]
		"Elegist": return [PAB.requiem(), PAB.elegy_of_valor(), PAB.dirge()]
		# T2:Tinker
		"Alchemist": return [PAB.transmute(), PAB.corrosive_acid(), PAB.elixir()]
		"Bombardier": return [PAB.shrapnel(), PAB.explosion(), PAB.field_repair()]
		"Chronomancer": return [PAB.warp_speed(), PAB.time_bomb(), PAB.time_freeze()]
		"Astronomer": return [PAB.starfall(), PAB.meteor_shower(), PAB.eclipse()]
		"Automaton": return [PAB.servo_strike(), PAB.discharge(), PAB.overclock()]
		"Technomancer": return [PAB.circuit_blast(), PAB.circuit_shield(), PAB.emp_pulse()]
		# T2:Wildling
		"Blighter": return [PAB.blight(), PAB.life_siphon(), PAB.poison_sting()]
		"GroveKeeper": return [PAB.thorn_burst(), PAB.root_trap(), PAB.draining_vines()]
		"WitchDoctor": return [PAB.voodoo_bolt(), PAB.dark_hex(), PAB.creeping_rot()]
		"Spiritwalker": return [PAB.spirit_shield(), PAB.ancestral_blessing(), PAB.spirit_mend()]
		"Falconer": return [PAB.falcon_strike(), PAB.talon_rend(), PAB.raptors_gift()]
		"Shapeshifter": return [PAB.savage_maul(), PAB.frenzy(), PAB.primal_roar()]
		# T2:Wanderer
		"Bulwark": return [PAB.fortress_strike(), PAB.iron_fist(), PAB.ironclad_challenge()]
		"Aegis": return [PAB.guardians_blessing(), PAB.protective_ward(), PAB.aegis_barrier()]
		"Trailblazer": return [PAB.blaze_trail(), PAB.ambush(), PAB.expose()]
		"Survivalist": return [PAB.endure(), PAB.resourceful_strike(), PAB.adapt()]
		_:
			push_error("Unknown class_id for abilities: %s" % class_id)
			return []


static func get_flavor_text(class_id: String) -> String:
	match class_id:
		# T0
		"Squire": return "A fresh recruit with more courage than skill. Every legend starts with a wooden sword and a stubborn heart."
		"Mage": return "An apprentice of the arcane, still learning to channel raw magic without singeing their robes."
		"Entertainer": return "A traveling performer whose quick wit and silver tongue are sharper than any blade."
		"Tinker": return "A curious inventor forever tinkering with gears and gadgets. Their workshop is wherever they happen to sit down."
		"Wildling": return "Raised beyond the reach of civilization, they speak the language of root and claw."
		"Wanderer": return "A seasoned traveler who has walked roads that no longer appear on any map. The wilds have taught them well."
		# T1: Squire tree
		"Duelist": return "A blade artist who treats every fight as a performance. Precision over power, always."
		"Ranger": return "A keen-eyed archer comfortable in the deep woods, where patience is the truest weapon."
		"MartialArtist": return "Fists and feet honed through years of discipline. They fight with nothing but their body and their will."
		# T1: Mage tree
		"Invoker": return "A channeler of elemental fury who bends fire, water, and lightning to their command."
		"Acolyte": return "A student of divine light, still finding their faith. Their healing hands grow steadier with each prayer."
		# T1: Entertainer tree
		"Bard": return "A musician who weaves magic through melody. Their songs can mend wounds or shatter morale."
		"Dervish": return "A whirling dancer whose movements blur the line between art and combat."
		"Orator": return "A master of rhetoric whose speeches move allies to action and enemies to doubt."
		# T1: Tinker tree
		"Artificer": return "A skilled craftsperson who turns raw materials into instruments of war and healing alike."
		"Cosmologist": return "A philosopher who gazes beyond the stars, seeking the hidden laws that govern all things."
		"Arithmancer": return "A scholar who finds power in pure mathematics, solving equations that reshape reality."
		# T1: Wildling tree
		"Herbalist": return "A keeper of plant lore who can coax both remedy and ruin from the simplest garden."
		"Shaman": return "A spirit-speaker who communes with the unseen world, drawing on ancestral power."
		"Beastcaller": return "One who shares a primal bond with wild creatures, calling them to fight as family."
		# T1: Wanderer tree
		"Sentinel": return "A stoic guardian who stands between their allies and harm. Their wards hold when walls would crumble."
		"Pathfinder": return "A tactical scout who reads the battlefield like a map, finding every advantage the terrain offers."
		# T2: Squire tree
		"Cavalry": return "A mounted lancer who charges through enemy lines with devastating momentum. Few can stand before the thundering hooves."
		"Dragoon": return "A skyborne warrior who leaps to impossible heights, crashing down with the force of a falling star."
		"Mercenary": return "A gun-wielding sellsword who lets coin decide their loyalty and a well-placed shot decide the battle."
		"Hunter": return "A patient tracker who lays cunning traps and reads every broken twig. Their quarry never escapes."
		"Ninja": return "A shadow that strikes without warning and vanishes without a trace. By the time you see them, it is already too late."
		"Monk": return "A spiritual warrior who channels inner harmony into devastating strikes and mending light."
		# T2: Mage tree
		"Infernalist": return "A pyromancer consumed by the thrill of flame. Their fire burns hotter than reason, leaving only ash behind."
		"Tidecaller": return "A water mage who commands the tides to shield allies and sweep away foes in surging waves."
		"Tempest": return "A storm incarnate who crackles with lightning and howls with thunder. Standing near them makes your hair stand on end."
		"Paladin": return "A holy knight who wields faith as both sword and shield. Their conviction is as unyielding as their armor."
		"Priest": return "A devoted healer whose prayers call down radiant light, mending the broken and sanctifying the battlefield."
		"Warlock": return "A wielder of forbidden magic who draws power from the dark spaces between stars. Their curses linger long after the battle ends."
		# T2: Entertainer tree
		"Warcrier": return "A battlefield vocalist whose thunderous shouts bolster allies and shatter enemy resolve."
		"Minstrel": return "A gentle musician whose healing melodies can soothe even the deepest wounds."
		"Illusionist": return "A trickster who bends light and perception, striking from angles that should not exist."
		"Mime": return "A silent performer who shapes invisible walls and conjures phantom objects from pure imagination."
		"Laureate": return "A poet of legendary renown whose words of praise elevate allies to heights they never thought possible."
		"Elegist": return "A somber wordsmith who speaks of loss and futility, draining the will to fight from all who listen."
		# T2: Tinker tree
		"Alchemist": return "A master of transmutation who brews elixirs of restoration and vials of corrosive ruin."
		"Bombardier": return "An explosives expert who solves every problem with a bigger blast. Subtlety is not in their vocabulary."
		"Chronomancer": return "A time-bender who accelerates allies and freezes foes in moments stolen from the future."
		"Astronomer": return "A celestial scholar who calls down starfire and meteor showers, wielding the heavens as a weapon."
		"Automaton": return "A living construct of clockwork and willpower, trading flesh for steel without a moment of regret."
		"Technomancer": return "A hybrid genius who fuses arcane circuits with raw magic, creating something entirely new."
		# T2: Wildling tree
		"Blighter": return "A harbinger of decay who wields poison and rot, turning the natural cycle of death into a weapon."
		"GroveKeeper": return "A guardian of the green who commands roots and vines to shield allies and ensnare the unwary."
		"WitchDoctor": return "A hex-weaver who curses enemies with ancient rites, unraveling their strength from the inside."
		"Spiritwalker": return "A bridge between the living and the ancestral realm, channeling protective spirits to shelter their companions."
		"Falconer": return "A raptor-bonded marksman whose birds of prey strike with surgical precision from above."
		"Shapeshifter": return "A primal warrior who abandons human form to become fang and claw, embracing the beast within."
		# T2: Wanderer tree
		"Bulwark": return "An immovable fortress of magical defense. Spells break against them like waves against a cliff."
		"Aegis": return "A counter-magic warrior who turns enemy sorcery back upon its caster with devastating precision."
		"Trailblazer": return "An aggressive vanguard who carves new paths through enemy ranks with relentless mixed assaults."
		"Survivalist": return "An endurance fighter who thrives where others falter, drawing strength from hardship itself."
		_: return ""
