-- Created By Bapes#1111 --
-- Please do not distrubute without consent --

---@diagnostic disable: undefined-global, lowercase-global
local Tinkr, UI = ...
local name = "Bapes Destro Rotation"
local version = "v1.1"
local Routine = Tinkr.Routine
local player = "player"
local target = "target"
local pet = "pet"

-- Print name and version
print("|cFFFFD700[Bapes Scripts]|cFF8A2BE2 " .. name .. " " .. version)

Routine:RegisterRoutine(
  function()
    if gcd() > latency() then
      return
    end

    if not latencyCheck() then
      return
    end

    if mounted() then
      return
    end

    -- COMBAT --
    local function do_combat()
      local mana = power()

      -- SETTINGS --

      local useHealthStone = UI.config.read("useHealthStone", "true")
      local healthstonePercentage = UI.config.read("healthstonePercentage", 40)

      local lifeTapPercentage = UI.config.read("lifeTapPercentage", 40)

      local useWand = UI.config.read("useWand", "true")
      local drainSoulPercentage = UI.config.read("drainSoulPercentage", 5)
      local shadowburnPercentage = UI.config.read("shadowburnPercentage", 5)
      local conflagratePercentage = UI.config.read("conflagratePercentage", 10)

      local curse = UI.config.read("curse", "Elements")

      -- END SETTINGS --

      -- SPELLS --

      local lifeTap = highestrank(1454)

      local wand = highestrank(5019)

      local elements = highestrank(1490)
      local recklessness = highestrank(704)
      local doom = highestrank(603)
      local agony = highestrank(980)
      local exhaustion = highestrank(18223)
      local tongues = highestrank(1714)

      local immolate = highestrank(348)
      local shadowBolt = highestrank(686)
      local shadowburn = highestrank(17877)
      local conflagrate = highestrank(17962)
      local drainSoul = highestrank(1120)

      -- END SPELLS --

      -- ITEMS --

      local healthstones = {
        19005,
        19004,
        5512,
        19007,
        19006,
        5511,
        19009,
        19008,
        19011,
        19010,
        5510,
        19013,
        19012,
        9421,
        22105,
        22104,
        22103
      }

      local soulShard = 6265

      -- END ITEMS --

      -- HEALING --

      -- Healthstone
      if health() <= healthstonePercentage and useHealthStone then
        for _, healthstone in pairs(healthstones) do
          if itemInBags(healthstone) and usable(healthstone) then
            return useItem(healthstone, player)
          end
        end
      end

      -- END HEALING --

      -- BUFFS --

      if mana <= lifeTapPercentage and castable(lifeTap, player) then
        cast(lifeTap, player)
      end

      -- END BUFFS --

      -- ATTACK START --

      if useWand and castable(wand, target) and not IsAutoRepeatSpell(wand) then
        return cast(wand, target)
      end

      -- END ATTACK START --

      -- ROTATION --

      -- Curse
      if curse == "Elements" then
        if not debuff(elements, target) and castable(elements, target) then
          return cast(elements, target)
        end
      elseif curse == "Recklessness" then
        if not debuff(recklessness, target) and castable(recklessness, target) then
          return cast(recklessness, target)
        end
      elseif curse == "Doom" then
        if not debuff(doom, target) and castable(doom, target) then
          return cast(doom, target)
        end
      elseif curse == "Agony" then
        if not debuff(agony, target) and castable(agony, target) then
          return cast(agony, target)
        end
      elseif curse == "Exhaustion" then
        if not debuff(exhaustion, target) and castable(exhaustion, target) then
          return cast(exhaustion, target)
        end
      elseif curse == "Tongues" then
        if not debuff(tongues, target) and castable(tongues, target) then
          return cast(tongues, target)
        end
      end

      -- Shadowburn
      if health(target) <= shadowburnPercentage and castable(shadowburn, target) then
        return cast(shadowburn, target)
      end

      -- Conflagrate
      if health(target) <= conflagratePercentage and castable(conflagrate, target) then
        return cast(conflagrate, target)
      end

      -- Drain Soul
      if
        health(target) <= drainSoulPercentage and itemcount(soulShard) < 5 and not debuff(drainSoul, target) and
          castable(drainSoul, target)
       then
        return cast(drainSoul, target)
      end

      -- Immolate
      if not debuff(immolate, target) and castable(immolate, target) then
        return cast(immolate, target)
      end

      -- Shadow Bolt
      if castable(shadowBolt, target) then
        return cast(shadowBolt, target)
      end

      -- END ROTATION --
    end

    -- RESTING --
    local function do_resting()
      if UnitIsDeadOrGhost(player) or UnitIsDeadOrGhost(target) or IsEatingOrDrinking() then
        return
      end

      -- SETTINGS --

      local useHealthStone = UI.config.read("useHealthStone", "true")
      local useSoulstone = UI.config.read("useSoulstone", "true")

      -- END SETTINGS --

      -- SPELLS --

      local summonSuccubus = highestrank(712)
      local createHealthstone = highestrank(6201)
      local createSoulstone = highestrank(693)

      local demonArmor = highestrank(706)
      local demonicSacrifice = highestrank(18788)
      local touchOfShadow = highestrank(18791)

      -- END SPELLS --

      -- ITEMS --

      local healthstones = {
        19005,
        19004,
        5512,
        19007,
        19006,
        5511,
        19009,
        19008,
        19011,
        19010,
        5510,
        19013,
        19012,
        9421,
        22105,
        22104,
        22103
      }

      local soulstones = {
        [5232] = 20707,
        [16892] = 20762,
        [16895] = 20764,
        [16896] = 20765,
        [22116] = 27239
      }

      -- END ITEMS --

      -- PET --

      -- Summon Pet
      if
        (UnitIsDeadOrGhost(pet) or not IsPetActive()) and castable(summonSuccubus, player) and
          not buff(touchOfShadow, player)
       then
        return cast(summonSuccubus, player)
      end

      -- END PET --

      -- STONES --

      -- Healthstone
      if useHealthStone and castable(createHealthstone, player) then
        for _, healthstone in pairs(healthstones) do
          if itemInBags(healthstone) then
            return
          end
        end

        return cast(createHealthstone, player)
      end

      -- Soulstone
      if useSoulstone and castable(createSoulstone, player) then
        for _, soulstoneItem in pairs(soulstones) do
          if itemInBags(soulstoneItem) then
            return
          end
        end

        return cast(createSoulstone, player)
      end

      -- END STONES --

      -- BUFFS --

      -- Demon Armor
      if castable(demonArmor, player) and not buff(demonArmor, player) then
        return cast(demonArmor, player)
      end

      -- Demonic Sacrifice
      if castable(demonicSacrifice, player) and not buff(touchOfShadow, player) then
        return cast(demonicSacrifice, player)
      end

      -- Soulstone
      if useSoulstone then
        for soulstoneBuff, soulstoneItem in pairs(soulstones) do
          if itemInBags(soulstoneItem) and not buff(soulstoneBuff, player) and usable(soulstoneItem) then
            return useItem(soulstoneItem, player)
          end
        end
      end

      -- END BUFFS --
    end

    if combat(player) then
      do_combat()
      return
    else
      do_resting()
      return
    end
  end,
  Routine.Classes.Warlock,
  "bapes-destro"
)
Routine:LoadRoutine("bapes-destro")

local bapesDestro_settings = {
  key = "bapes_destro_config",
  title = "Bapes Scripts",
  width = 400,
  height = 300,
  color = "F58CBA",
  resize = false,
  show = false,
  table = {
    {
      key = "heading",
      type = "heading",
      text = name .. " " .. version
    },
    -- Healing --
    {
      key = "heading",
      type = "heading",
      text = "Healing"
    },
    -- Healthstone
    {
      key = "useHealthStone",
      type = "checkbox",
      text = "Use Healthstone"
    },
    -- Healthstone Percentage
    {
      key = "healthstonePercentage",
      type = "slider",
      text = "Healthstone Percentage",
      label = "Healthstone %",
      min = 5,
      max = 95,
      step = 5
    },
    -- Buffs --
    {
      key = "heading",
      type = "heading",
      text = "Buffs"
    },
    -- Soulstone
    {
      key = "useSoulstone",
      type = "checkbox",
      text = "Use Soulstone"
    },
    -- Life Tap Percentage
    {
      key = "lifeTapPercentage",
      type = "slider",
      text = "Life Tap Percentage",
      label = "Life Tap %",
      min = 1,
      max = 100,
      step = 5
    },
    -- Combat Options --
    {
      key = "heading",
      type = "heading",
      text = "Combat Options"
    },
    -- Wand
    {
      key = "useWand",
      type = "checkbox",
      text = "Use Wand"
    },
    -- Drain Soul Percentage
    {
      key = "drainSoulPercentage",
      type = "slider",
      text = "Drain Soul Percentage",
      label = "Drain Soul %",
      min = 5,
      max = 95,
      step = 5
    },
    -- Shadowburn Percentage
    {
      key = "shadowburnPercentage",
      type = "slider",
      text = "Shadowburn Percentage",
      label = "Shadowburn %",
      min = 5,
      max = 95,
      step = 5
    },
    -- Conflagrate Percentage
    {
      key = "conflagratePercentage",
      type = "slider",
      text = "Conflagrate Percentage",
      label = "Conflagrate %",
      min = 5,
      max = 95,
      step = 5
    },
    -- Curse
    {
      key = "curse",
      width = 130,
      label = "Curse",
      type = "dropdown",
      options = {"Elements", "Recklessness", "Doom", "Agony", "Exhaustion", "Tongues"}
    }
  }
}

UI.build_rotation_gui(bapesDestro_settings)

local bapesDestro_buttons = {}

UI.button_factory(bapesDestro_buttons)
