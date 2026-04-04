class_name SimReportMarkdown

## Generates a markdown class balance report from build_entry()-format stage data.
## Used by battle_simulator.gd via --markdown flag.

## Boss detection is now dynamic via has_boss field from EnemyRoles tier data.
const BASE_CLASSES := [
	"Entertainer", "Mage", "Squire", "Tinker", "Wanderer", "Wildling"]
const T1_CLASSES := [
	"Acolyte", "Arithmancer", "Artificer", "Bard", "Beastcaller", "Dervish",
	"Duelist", "Herbalist", "Invoker", "Martial Artist", "Orator", "Pathfinder",
	"Philosopher", "Ranger", "Sentinel", "Shaman"]
const T2_CLASSES := [
	"Aegis", "Alchemist", "Astronomer", "Automaton", "Blighter", "Bombardier",
	"Bulwark", "Cavalry", "Chronomancer", "Dragoon", "Elegist", "Falconer",
	"Grove Keeper", "Hunter", "Illusionist", "Infernalist", "Laureate",
	"Mercenary", "Mime", "Minstrel", "Monk", "Ninja", "Paladin", "Priest",
	"Shapeshifter", "Spiritwalker", "Survivalist", "Technomancer", "Tempest",
	"Tidecaller", "Trailblazer", "Warcrier", "Warlock", "Witch Doctor"]
const TIER_BAND := {"base": 0.15, "tier1": 0.125, "tier2": 0.10}


static func write_markdown(path: String, entries: Array,
		mode: String = "quick") -> void:
	var lines := PackedStringArray()
	lines.append_array(_header(entries, mode))
	lines.append_array(_summary(entries))
	lines.append_array(_strongest_weakest(entries))
	for t: Array in [["base", "Base Tier (Prog 0-2)"],
			["tier1", "Tier 1 (Prog 3-7)"], ["tier2", "Tier 2 (Prog 8+)"]]:
		lines.append_array(_tier_section(entries, t[0], t[1]))
	lines.append_array(_combat_effectiveness(entries))
	lines.append_array(_spread_analysis(entries))
	lines.append_array(_outlier_details(entries))
	lines.append_array(_boss_section(entries))
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string("\n".join(lines))
		file.close()
		print("\n  Markdown report: %s" % path)
	else:
		print("\n  ERROR: Could not write markdown to: %s" % path)


# -- Section generators --------------------------------------------------------

static func _header(entries: Array, mode: String) -> PackedStringArray:
	var stories := {}
	for e: Dictionary in entries:
		stories[e.get("story", 1)] = true
	var skeys := stories.keys()
	skeys.sort()
	var slist := PackedStringArray()
	for s in skeys:
		slist.append(str(int(s)))
	return PackedStringArray([
		"# Class Balance Report", "",
		"Generated: %s | Mode: %s | Stories: %s" % [
			Time.get_date_string_from_system(), mode, ", ".join(slist)], ""])


static func _summary(entries: Array) -> PackedStringArray:
	var lines := PackedStringArray()
	lines.append("## Summary")
	lines.append("")
	var by_story := _group_by_story(entries)
	var skeys := by_story.keys()
	skeys.sort()
	var hdr := "| Metric |"
	var sep := "|--------|"
	for s in skeys:
		hdr += " Story %d |" % s
		sep += "---------|"
	lines.append(hdr)
	lines.append(sep)
	var row := "| Stages |"
	for s in skeys:
		row += " %d |" % by_story[s].size()
	lines.append(row)
	row = "| All PASS |"
	for s in skeys:
		var ok := true
		for e: Dictionary in by_story[s]:
			if e.get("status", "") != "PASS":
				ok = false
				break
		row += " %s |" % ("YES" if ok else "NO")
	lines.append(row)
	row = "| Avg WR |"
	for s in skeys:
		var total := 0.0
		for e: Dictionary in by_story[s]:
			total += e.get("overall_win_rate", 0.0)
		row += " %.1f%% |" % [total / by_story[s].size() * 100]
	lines.append(row)
	lines.append("")
	return lines


static func _strongest_weakest(entries: Array) -> PackedStringArray:
	var lines := PackedStringArray()
	for ti: Array in [["base", "Base", 3], ["tier1", "T1", 3],
			["tier2", "T2", 5]]:
		var tier: String = ti[0]
		var label: String = ti[1]
		var count: int = ti[2]
		var tier_entries := entries.filter(
			func(e: Dictionary) -> bool: return e.get("tier", "") == tier)
		if tier_entries.is_empty():
			continue
		var avgs := _class_avg_wr(tier_entries)
		avgs.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
			return a.avg > b.avg)
		var top := mini(count, avgs.size())
		var bot := mini(count, avgs.size())
		var parts := PackedStringArray()
		for i in top:
			parts.append("%s %.1f%%" % [avgs[i].name, avgs[i].avg * 100])
		lines.append("**%s strongest:** %s" % [label, ", ".join(parts)])
		parts = PackedStringArray()
		for i in bot:
			parts.append("%s %.1f%%" % [
				avgs[avgs.size() - 1 - i].name,
				avgs[avgs.size() - 1 - i].avg * 100])
		lines.append("**%s weakest:** %s" % [label, ", ".join(parts)])
	lines.append("")
	return lines


static func _tier_section(entries: Array, tier: String,
		heading: String) -> PackedStringArray:
	var lines := PackedStringArray()
	var classes := _classes_for(tier)
	var filtered := entries.filter(func(e: Dictionary) -> bool:
		return e.get("tier", "") == tier and not e.get("has_boss", false))
	if filtered.is_empty():
		return lines
	lines.append("## %s" % heading)
	lines.append("")
	var by_story := _group_by_story(filtered)
	var skeys := by_story.keys()
	skeys.sort()
	for s in skeys:
		lines.append("### Story %d" % s)
		lines.append("")
		lines.append_array(_class_table(by_story[s], classes, false))
		lines.append("")
	return lines


static func _combat_effectiveness(entries: Array) -> PackedStringArray:
	var lines := PackedStringArray()
	lines.append("## Combat Effectiveness")
	lines.append("")
	lines.append(
		"Per-class averages across all battles the class appears in.")
	lines.append("")
	for ti: Array in [["base", "Base Tier"], ["tier1", "Tier 1"],
			["tier2", "Tier 2"]]:
		var tier: String = ti[0]
		var classes := _classes_for(tier)
		var filtered := entries.filter(
			func(e: Dictionary) -> bool: return e.get("tier", "") == tier)
		if filtered.is_empty():
			continue
		lines.append("### %s" % ti[1])
		lines.append(
			"| Class | Avg Dealt | Avg Taken | Avg Mitigated | Avg Heals | Avg Buffs | Avg Debuffs |")
		lines.append(
			"|-------|-----------|-----------|---------------|-----------|-----------|-------------|")
		for cls: String in classes:
			var d := 0.0
			var t := 0.0
			var m := 0.0
			var h := 0.0
			var bu := 0.0
			var de := 0.0
			var c := 0
			for e: Dictionary in filtered:
				var cs: Dictionary = e.get("combat_stats", {})
				if cs.has(cls):
					d += cs[cls].get("avg_dealt", 0.0)
					t += cs[cls].get("avg_taken", 0.0)
					m += cs[cls].get("avg_mitigated", 0.0)
					h += cs[cls].get("avg_heals", 0.0)
					bu += cs[cls].get("avg_buffs", 0.0)
					de += cs[cls].get("avg_debuffs", 0.0)
					c += 1
			if c > 0:
				lines.append("| %s | %.1f | %.1f | %.1f | %.1f | %.1f | %.1f |" % [
					cls, d / c, t / c, m / c, h / c, bu / c, de / c])
			else:
				lines.append("| %s | - | - | - | - | - | - |" % cls)
		lines.append("")
	return lines


static func _spread_analysis(entries: Array) -> PackedStringArray:
	var lines := PackedStringArray()
	lines.append("## Spread Analysis")
	lines.append("")
	lines.append(
		"| Battle | Story | Prog | Target | Overall | Core Spread | Verdict |")
	lines.append(
		"|--------|-------|------|--------|---------|-------------|---------|")
	var sorted := entries.duplicate()
	sorted.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		if a.get("story", 1) != b.get("story", 1):
			return a.story < b.story
		return a.progression_stage < b.progression_stage)
	for e: Dictionary in sorted:
		var sp: Dictionary = e.get("spread", {})
		lines.append("| %s | %d | %d | %d%% | %.1f%% | %.1f%% | %s |" % [
			e.stage_name, e.story, e.progression_stage,
			int(e.target_win_rate * 100), e.overall_win_rate * 100,
			sp.get("core_spread", 0.0) * 100, sp.get("verdict", "?")])
	lines.append("")
	return lines


static func _outlier_details(entries: Array) -> PackedStringArray:
	var lines := PackedStringArray()
	lines.append("## Outlier Details")
	lines.append("")
	var regular := entries.filter(func(e: Dictionary) -> bool:
		return not e.get("has_boss", false))
	var outliers := {}
	for e: Dictionary in regular:
		var tier: String = e.get("tier", "base")
		var band: float = TIER_BAND.get(tier, 0.10)
		var target: float = e.get("target_win_rate", 0.0)
		for cls: String in e.get("class_breakdown", {}):
			var wr: float = e.class_breakdown[cls].get("win_rate", 0.0)
			if wr < target - band or wr > target + band:
				if not outliers.has(cls):
					outliers[cls] = []
				outliers[cls].append({
					"battle": e.stage_name, "wr": wr, "target": target,
					"dir": "below floor" if wr < target - band \
						else "above ceiling"})
	if outliers.is_empty():
		lines.append("No classes outside tier-specific bands.")
		lines.append("")
		return lines
	var avg_map := {}
	for a: Dictionary in _class_avg_wr(entries):
		avg_map[a.name] = a.avg
	var sorted_cls := outliers.keys()
	sorted_cls.sort()
	for cls: String in sorted_cls:
		lines.append("### %s (avg %.1f%%)" % [
			cls, avg_map.get(cls, 0.0) * 100])
		for o: Dictionary in outliers[cls]:
			lines.append("- %s: %.1f%% (target %d%%, **%s**)" % [
				o.battle, o.wr * 100, int(o.target * 100), o.dir])
		lines.append("")
	return lines


static func _boss_section(entries: Array) -> PackedStringArray:
	var lines := PackedStringArray()
	var bosses := entries.filter(func(e: Dictionary) -> bool:
		return e.get("has_boss", false))
	if bosses.is_empty():
		return lines
	lines.append("## Boss Battles")
	lines.append("")
	var by_story := _group_by_story(bosses)
	var skeys := by_story.keys()
	skeys.sort()
	for s in skeys:
		if s == 3:
			var t1 := (by_story[s] as Array).filter(
				func(e: Dictionary) -> bool: return e.get("tier", "") == "tier1")
			var t2 := (by_story[s] as Array).filter(
				func(e: Dictionary) -> bool: return e.get("tier", "") == "tier2")
			if not t1.is_empty():
				lines.append("#### Story 3 -- T1 Boss")
				lines.append("")
				lines.append_array(_class_table(t1, T1_CLASSES, true))
				lines.append("")
			if not t2.is_empty():
				lines.append("#### Story 3 -- T2 Bosses")
				lines.append("")
				lines.append_array(_class_table(t2, T2_CLASSES, true))
				lines.append("")
		else:
			lines.append("### Story %d" % s)
			lines.append("")
			lines.append_array(_class_table(by_story[s], T2_CLASSES, true))
			lines.append("")
	return lines


# -- Shared helpers ------------------------------------------------------------

static func _class_table(entries: Array, classes: Array,
		strip_prefix: bool) -> PackedStringArray:
	var lines := PackedStringArray()
	if entries.is_empty():
		return lines
	var sorted := entries.duplicate()
	sorted.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		return a.get("progression_stage", 0) < b.get("progression_stage", 0))
	var hdr := "| Class |"
	var sep := "|-------|"
	for e: Dictionary in sorted:
		hdr += " %s (P%d, %d%%) |" % [_shorten(e.stage_name, strip_prefix),
			e.progression_stage, int(e.target_win_rate * 100)]
		sep += "---|"
	if sorted.size() > 1:
		hdr += " Avg |"
		sep += "---|"
	lines.append(hdr)
	lines.append(sep)
	for cls: String in classes:
		var row := "| %s |" % cls
		var total := 0.0
		var count := 0
		for e: Dictionary in sorted:
			var bd: Dictionary = e.get("class_breakdown", {})
			if bd.has(cls):
				var wr: float = bd[cls].get("win_rate", 0.0)
				row += " %s |" % _fmt_wr(wr, e.target_win_rate, e.tier)
				total += wr
				count += 1
			else:
				row += " - |"
		if sorted.size() > 1:
			if count > 0:
				row += " %.1f%% |" % [total / count * 100]
			else:
				row += " - |"
		lines.append(row)
	return lines


static func _fmt_wr(wr: float, target: float, tier: String) -> String:
	var band: float = TIER_BAND.get(tier, 0.10)
	var text := "%.1f%%" % [wr * 100]
	if wr < target - band:
		return "**%s**" % text
	if wr > target + band:
		return "*%s*" % text
	return text


static func _shorten(sname: String, strip_story: bool = false) -> String:
	var s := sname
	if s.ends_with("Battle"):
		s = s.left(s.length() - 6)
	if strip_story:
		for prefix in ["S2_", "S3_"]:
			if s.begins_with(prefix):
				s = s.substr(prefix.length())
				break
	return s


static func _classes_for(tier: String) -> Array:
	match tier:
		"base": return BASE_CLASSES
		"tier1": return T1_CLASSES
		"tier2": return T2_CLASSES
	return []


static func _group_by_story(entries: Array) -> Dictionary:
	var result := {}
	for e: Dictionary in entries:
		var s: int = int(e.get("story", 1))
		if not result.has(s):
			result[s] = []
		result[s].append(e)
	return result


static func _class_avg_wr(entries: Array) -> Array:
	var totals := {}
	for e: Dictionary in entries:
		for cls: String in e.get("class_breakdown", {}):
			if not totals.has(cls):
				totals[cls] = [0.0, 0]
			totals[cls][0] += e.class_breakdown[cls].get("win_rate", 0.0)
			totals[cls][1] += 1
	var result := []
	for cls: String in totals:
		result.append({"name": cls, "avg": totals[cls][0] / totals[cls][1]})
	return result
