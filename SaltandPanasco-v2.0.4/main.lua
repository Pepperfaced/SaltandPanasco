--- STEAMODDED HEADER
--- MOD_NAME: Salt & Panasco
--- MOD_ID: SaltPanasco
--- MOD_AUTHOR: [Pepperfaced]
--- MOD_DESCRIPTION: A vanilla+ mod that adds jokers, consumeables, and decks.
--- PREFIX: salt
--- BADGE_COLOR: 14C3B3
--- VERSION: 2.0.4
----------------------------------------------
------------MOD CODE -------------------------

local saltconfig = SMODS.Mods.SaltPanasco.config

SMODS.current_mod.config_tab = function()
	return {n = G.UIT.ROOT, config = { minw = 8, minh = 4, r = 0.1, align = "cm", padding = 0.2, colour = G.C.BLACK},
    nodes = {
    {n = G.UIT.R, config = {align = "cl", padding = 0},
        nodes = {
            {n = G.UIT.C, config = { align = "tm", padding = 0.1 },
            nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = saltconfig, ref_value = "disable_jokers" },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 },
            nodes = {
                { n = G.UIT.T, config = { text = "Disable Jokers", scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},
    {n = G.UIT.R, config = {align = "cl", padding = 0},
        nodes = {
            {n = G.UIT.C, config = { align = "tm", padding = 0.1 },
            nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = saltconfig, ref_value = "disable_spices" },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 },
            nodes = {
                { n = G.UIT.T, config = { text = "Disable Consumeables", scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},
    {n = G.UIT.R, config = {align = "cl", padding = 0},
        nodes = {
            {n = G.UIT.C, config = { align = "tm", padding = 0.1 },
            nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = saltconfig, ref_value = "dark_mode" },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 },
            nodes = {
                { n = G.UIT.T, config = { text = "Dark Mode Jokers (Requires Restart)", scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},
    }}
end

jsuffix = function(self, args)
    if saltconfig.dark_mode then
        return "_dark.png"
    else
        return ".png"
    end
end

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = "Jokers" .. jsuffix(),
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Atlas{
    key = 'Spices', --atlas key
    path = 'Spices.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Atlas{
    key = 'Decks',
    path = "Decks.png",
    px = 71,
    py = 95
}

SMODS.Joker{ --8 Leaf Clover
    key = '8leaf', --joker key
    loc_txt = { -- local text
        name = '8 Leaf Clover',
        text = {
          'Each {C:clubs}Club{} {C:attention}held in hand{}',
          'gives {C:mult}+#1#{} Mult'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 8 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit('Clubs') then
			return {
				mult_mod = card.ability.extra.mult,
				card = card,
				message = '+8 Mult',
				colour = G.C.MULT
				}
			end
        end

        
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Collector
    key = 'collector', --joker key
    loc_txt = { -- local text
        name = 'Collector',
        text = {
          '{C:green}#2# in #3#{} chance to gain',
		  '{C:blue}+#4#{} Chips when any',
		  '{C:attention}Booster Pack{} is opened',
		  '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 2, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 0,	--configurable value
		chip_mod = 30,
		oddsmax = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, (G.GAME.probabilities.normal or 1), center.ability.extra.oddsmax, center.ability.extra.chip_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
	
	
    calculate = function(self,card,context)
        if context.open_booster and not context.blueprint then
			if pseudorandom('luckycard') < G.GAME.probabilities.normal/card.ability.extra.oddsmax then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			return {
				message = 'Lucky!',
				colour = G.C.CHIPS
				}
			end
        end
		
		if context.joker_main and card.ability.extra.chips > 0 then
		return {
			chip_mod = card.ability.extra.chips,
			card = card,
			message = '+' .. card.ability.extra.chips,
			colour = G.C.CHIPS
			}
			end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Spectral Joker
    key = 'spectraljoker', --joker key
    loc_txt = { -- local text
        name = 'Spectral Joker',
        text = {
          'This Joker gains {X:mult,C:white}X#2#{} Mult',
          'every time a',
		  '{C:spectral}Spectral{} card is used',
		  '{C:inactive}(Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 3, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 1, --configurable value
		Xmult_mod = 0.5
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				card = card,
				message = 'X'.. card.ability.extra.Xmult,
				colour = G.C.MULT
				}
			end
		
		if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.set == 'Spectral' then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
		return {
			message = 'X' .. card.ability.extra.Xmult .. ' Mult',
			colour = G.C.MULT
			}
        end
		end
    end,
    in_pool = function(self,arge)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --3D Glasses
    key = '3dglasses', --joker key
    loc_txt = { -- local text
        name = '3D Glasses',
        text = {
          '{C:mult}+#2#{} Mult per {C:attention}Mult{}',
          'or {C:attention}Bonus{} Card',
		  'in your full deck',
		  '{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
	enhancement_gate = 'm_mult',
    pos = {x = 4, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0, --configurable value
		gain = 1
      }
    },
    loc_vars = function(self,info_queue,center)
		info_queue[#info_queue+1] = G.P_CENTERS.m_mult
		info_queue[#info_queue+1] = G.P_CENTERS.m_bonus
		local count = G.playing_cards and calculate_redblue() or 0
        return {vars = {(center.ability.extra.gain * count), center.ability.extra.gain}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main then
			local count = G.playing_cards and calculate_redblue() or 0
            if count > 0 then
			return {
				mult_mod = card.ability.extra.mult + (card.ability.extra.gain * count),
				card = card,
				message = '+' .. card.ability.extra.mult + (card.ability.extra.gain * count) .. ' Mult',
				colour = G.C.MULT
				}
			end
        end
    end,
	
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

	function calculate_redblue()
    local count = 0
    for _, card in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(card, 'm_mult') or SMODS.has_enhancement(card, 'm_bonus') then
            count = count + 1
        end
    end
    return count
end

SMODS.Joker{ --Chip Joker
    key = 'chipjoker', --joker key
    loc_txt = { -- local text
        name = 'Chip Joker',
        text = {
          '{C:blue}+#1#{} Chips'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 30 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main then
			return {
				chip_mod = card.ability.extra.chips,
				card = card,
				message = '+' .. card.ability.extra.chips,
				colour = G.C.CHIPS
				}
        end

        
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Star Chart
    key = 'starchart', --joker key
    loc_txt = { -- local text
        name = 'Star Chart',
        text = {
          'If {C:attention}first hand{} of round is',
          'level {C:attention}1{}, create a {C:planet}Planet{}',
		  'card for that hand',
		  '{C:inactive}(Must have room){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 8 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.after then
            if G.GAME.hands[context.scoring_name].level == 1 and G.GAME.current_round.hands_played == 0 then
			local _planet = 0
                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == G.GAME.last_hand_played then
                            _planet = v.key
                        end
                    end
			SMODS.add_card({set = 'Planet', key = _planet, area = G.consumeables})
			return {
			true
				}
			end
        end

    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Jackpot
    key = 'jackpot', --joker key
    loc_txt = { -- local text
        name = 'Jackpot',
        text = {
          'Each played {C:attention}7{} gives',
          '{X:mult,C:white}X1.5{} Mult when scored'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 1.5 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 7 then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				card = card,
				message = 'X1.5 Mult',
				colour = G.C.MULT
				}
			end
        end

        
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Yin Yang
    key = 'yinyang', --joker key
    loc_txt = { -- local text
        name = 'Yin Yang',
        text = {
          'When playing a {C:attention}Pair{},',
          'scored cards turn into',
		  'either {C:attention}6{} or {C:attention}9{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        white = 6, --configurable value
		black = 9
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.white, center.ability.extra.black}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.before and not context.blueprint and context.scoring_name == 'Pair' then
            local _rank = pseudorandom_element({'6','9'}, pseudoseed('yin'))
            for i=1, #context.scoring_hand do
                G.E_MANAGER:add_event(Event({func = function()
                    local card = context.scoring_hand[i]
                    local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                    local rank_suffix =_rank
                    card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                    card:juice_up()
                return true end }))
				end
            return { message = "Changed!", colour = G.C.CHIPS}
        end
        
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Fencer
    key = 'fencer', --joker key
    loc_txt = { -- local text
        name = 'Fencer',
        text = {
          'Earn {C:gold}$#1#{} if {C:attention}Boss Blind{}',
          'is defeated in {C:attention}1 hand{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        dollars = 10 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.dollars}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calc_dollar_bonus = function(self,card)
		local bonus = card.ability.extra.dollars
        if G.GAME.current_round.hands_played == 1 and bonus > 0 and G.GAME.blind.boss then
			return bonus
		end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Traffic Light
    key = 'traffic', --joker key
    loc_txt = { -- local text
        name = 'Traffic Light',
        text = {
          'This Joker gains {X:mult,C:white}X#1#{} Mult',
		  'per scored {V:1}#2#{} card,',
		  'resets if {C:hearts}Hearts{} are scored',
		  '{s:0.8}First suit changes every round',
		  '{C:inactive}(Currently{} {X:mult,C:white}X#3#{} {C:inactive}Mult){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 5, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 1,	--configurable value
		Xmult_mod = 0.05
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
			center.ability.extra.Xmult_mod,
			localize(G.GAME.current_round.traffic_card.suit, 'suits_singular'),
			center.ability.extra.Xmult,
			colours = { G.C.SUITS[G.GAME.current_round.traffic_card.suit] }
			}
		}
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
	
	
    calculate = function(self, card, context)
		if
			context.individual and context.cardarea == G.play and
			not context.other_card.debuff and not context.blueprint then
			if context.other_card:is_suit(G.GAME.current_round.traffic_card.suit) then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.MULT,
				card = card
			}
			end
			if context.other_card:is_suit('Hearts') then
			card.ability.extra.Xmult = 1
			return {
			message = 'Reset!',
			colour = G.C.MULT,
			card = card
			}
			end
		end
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				message = 'X' .. card.ability.extra.Xmult .. ' Mult',
				Xmult_mod = card.ability.extra.Xmult,
				colour = G.C.MULT
			}
		end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

local igo = Game.init_game_object
function Game:init_game_object()
	local ret = igo(self)
	ret.current_round.traffic_card = { suit = 'Spades' }
	return ret
end

-- This is a part 2 of the above thing, to make the custom G.GAME variable change every round.
function SMODS.current_mod.reset_game_globals(run_start)
	-- The suit changes every round, so we use reset_game_globals to choose a suit.
	G.GAME.current_round.traffic_card = { suit = 'Spades' }
	local valid_traffic_cards = {'Spades', 'Clubs', 'Diamonds'}
	if valid_traffic_cards[1] then
		local traffic_card = pseudorandom_element(valid_traffic_cards, pseudoseed('traf' .. G.GAME.round_resets.ante))
		G.GAME.current_round.traffic_card.suit = traffic_card
	end
end

SMODS.Joker{ --Newspaper
    key = 'newspaper', --joker key
    loc_txt = { -- local text
        name = 'Newspaper',
        text = {
          'This Joker gains {C:mult}+#2#{} Mult',
          'when a {C:attention}Blind{} is selected,',
		  'resets if {C:attention}Blind{} is skipped',
		  '{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 5, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0, --configurable value
		mult_mod = 4
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult_mod = card.ability.extra.mult,
				card = card,
				message = '+'.. card.ability.extra.mult .. ' Mult',
				colour = G.C.MULT
				}
			end
		
		if context.setting_blind and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
		return {
			message = 'Extra!',
			colour = G.C.MULT
			}
		end
		
		if context.skip_blind and not context.blueprint then
			card.ability.extra.mult = 0
		return {
			message = 'Reset!',
			colour = G.C.PURPLE
			}
		end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Tome Joker
    key = 'tome', --joker key
    loc_txt = { -- local text
        name = 'Tome Joker',
        text = {
          '{X:mult,C:white}X#1#{} Mult,',
          'loses {X:mult,C:white}X#2#{} Mult',
		  'per hand played',
		  '{C:inactive}(#3# pages left){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 4, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 3, --configurable value
		Xmult_mod = 0.05
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.Xmult_mod, (40-((3 - center.ability.extra.Xmult)*20))}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				card = card,
				message = 'X'.. card.ability.extra.Xmult .. ' Mult',
				colour = G.C.MULT
				}
			end
		
		if context.after and not context.blueprint then
			card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_mod
		return {
			message = 'Next',
			colour = G.C.GREEN
			}
		end
		
		if not context.blueprint and context.main_eval then
			if card.ability.extra.Xmult <= 1 then
				-- This part plays the animation.
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = 'The End!',
					colour = G.C.GREEN
				}
				end
				end
		
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Smartphone
    key = 'smartphone', --joker key
    loc_txt = { -- local text
        name = 'Smartphone',
        text = {
          '{C:chips}+#1#{} Chips',
          '{C:chips}-#2#{} Chips for every',
		  'round played, resets',
		  'when {C:attention}Blind{} is skipped{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 5, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 100, --configurable value
		chip_mod = 20
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.chip_mod}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main then
			return {
				chip_mod = card.ability.extra.chips,
				card = card,
				message = '+'.. card.ability.extra.chips,
				colour = G.C.CHIPS
				}
			end
		
		if context.end_of_round and context.main_eval and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_mod
		return {
			message = '-10',
			colour = G.C.CHIPS
			}
		end
		
		if context.skip_blind and not context.blueprint then
			card.ability.extra.chips = 100
		return {
			message = 'Charged!',
			colour = G.C.CHIPS
			}
		end
		
		if not context.blueprint and context.main_eval then
			if card.ability.extra.chips <= 0 then
				-- This part plays the animation.
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = 'Drained!',
					colour = G.C.CHIPS
				}
				end
				end
		
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Route 2
    key = 'routetwo', --joker key
    loc_txt = { -- local text
        name = 'Route 2',
        text = {
          'Retrigger every',
          'played {C:attention}Ace{}, {C:attention}4{}, & {C:attention}9{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        repetitions = 1
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.repetitions}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if (context.other_card:get_id() == 14) or (context.other_card:get_id() == 4) or (context.other_card:get_id() == 9) then
			return {
				message = 'Again!',
				repetitions = card.ability.extra.repetitions,
				card = card
				}
				end
				end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Piggy Bank
    key = 'piggy', --joker key
    loc_txt = { -- local text
        name = 'Piggy Bank',
        text = {
          'After {C:attention}#1#{} rounds,',
          'sell this card',
		  'to earn {C:money}$#2#{}',
		  '{C:inactive}(Currently{} {C:attention}#3#{}{C:inactive}/#1#){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        payday = 3,
		dollars = 30,
		rounds = 0,
		juicer = true
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.payday, center.ability.extra.dollars, center.ability.extra.rounds}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.payday then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
			return {
				message = card.ability.extra.rounds .. '/' .. card.ability.extra.payday,
				colour = G.C.MONEY
			 }
        end
		
		if card.ability.extra.rounds >= card.ability.extra.payday then
			if context.selling_self and not context.blueprint then
			ease_dollars(card.ability.extra.dollars)
			return {
				message = '$' .. card.ability.extra.dollars,
				colour = G.C.MONEY,
				delay = 0.45
			 }
            end
		end
        
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Plus One
    key = 'plusone', --joker key
    loc_txt = { -- local text
        name = 'Plus One',
        text = {
          '{C:attention}+1 Voucher{}',
          'in each shop,',
          '{C:attention}-1{} hand size'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 4}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        h_size = 1
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = { center.ability.extra.h_size }}
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then
            unlock_card(self)
        end
        unlock_card(self)
    end,
	add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
        SMODS.change_voucher_limit(card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
        SMODS.change_voucher_limit(-card.ability.extra.h_size)
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
}

SMODS.Joker{ --Doppelganger
    key = 'doppel', --joker key
    loc_txt = { -- local text
        name = 'Doppelganger',
        text = {
          'Copies ability of',
          'the {C:attention}Joker{} in',
          'position {C:attention}#1#{}',
          '{s:0.8}Changes every round{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 4}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        host = '1'
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = { center.ability.extra.host }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
     calculate = function(self, card, context)
        if context.setting_blind then
            local position = math.random(#G.jokers.cards)
            card.ability.extra.host = position
        end
        local ret = SMODS.blueprint_effect(card, G.jokers.cards[card.ability.extra.host], context)
        if ret then
            ret.colour = G.C.RED
        end
        return ret
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Revolver
    key = 'revolver', --joker key
    loc_txt = { -- local text
        name = 'Revolver',
        text = {
          'Every {C:attention}#2#{} hands, all',
          'cards {C:attention}held in hand{}',
          'give {X:mult,C:white}X#1#{} mult',
          '{C:inactive}({}{C:attention}#3#{} {C:inactive}shots left){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 4}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 1.5,
        chamber = 5,
        shots = 5
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = { center.ability.extra.Xmult, 
        center.ability.extra.chamber + 1, 
        center.ability.extra.shots }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
     calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.shots = (card.ability.extra.chamber - 1 - (G.GAME.hands_played - card.ability.hands_played_at_create)) %
                (card.ability.extra.chamber + 1)
            if not context.blueprint then
                if card.ability.extra.shots == 0 then
                    local eval = function(card) return card.ability.extra.shots == 0 and not G.RESET_JIGGLES end
                    juice_card_until(card, eval, true)
                end
            end
        end
        if card.ability.extra.shots == 0 and context.individual and context.cardarea == G.hand and not context.end_of_round then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Banruptcy
    key = 'bankruptcy', --joker key
    loc_txt = { -- local text
        name = 'Bankruptcy',
        text = {
          'Sets money to {C:money}$0{}',
          'if {C:attention}poker hand{} is',
          'a {C:attention}#1#{}, changes',
          'at end of round'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 4}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        poker_hand = 'High Card'
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = { center.ability.extra.poker_hand }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
     calculate = function(self, card, context)
     if context.before and context.scoring_name == card.ability.extra.poker_hand then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - G.GAME.dollars
            return {
                dollars = -G.GAME.dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'bankroll')
            return {
                message = localize('k_reset')
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'bankroll')
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
}

SMODS.Joker{ --Graffiti Wall
    key = 'graffiti', --joker key
    loc_txt = { -- local text
        name = 'Graffiti Wall',
        text = {
          'Sell this card to',
          'create a free',
          'random {C:attention}Tag{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 4, y = 4}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = { }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
     calculate = function(self, card, context)
     if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = (function()
                local tag_pool = get_current_pool('Tag')
                local selected_tag = pseudorandom_element(tag_pool, 'graffiti')
                local it = 1
                while selected_tag == 'UNAVAILABLE' do
                    it = it + 1
                    selected_tag = pseudorandom_element(tag_pool, 'modprefix_seed_resample'..it)
                end
                add_tag(Tag(selected_tag, false, 'Small'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Honeycomb
    key = 'honeycomb', --joker key
    loc_txt = { -- local text
        name = 'Honeycomb',
        text = {
          'Earn {C:money}$#1#{} for each',
          '{C:attention}6 held in hand{}',
          'at end of round'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 5, y = 4}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        dollars = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = { center.ability.extra.dollars }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
     calculate = function(self, card, context)
     if context.individual and context.end_of_round and context.cardarea == G.hand and context.other_card:get_id() == 6 then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
                    return {
                        dollars = card.ability.extra.dollars,
                        func = function() -- This is for timing purposes, it runs after the dollar manipulation
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.dollar_buffer = 0
                                    return true
                                end
                            }))
                        end
                    }
                end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
}

SMODS.Joker{ --Stained Glass
    key = 'stained', --joker key
    loc_txt = { -- local text
        name = 'Stained Glass',
        text = {
          'All played {C:attention}face{} cards',
          'become {C:attention}Glass{} cards',
          'when scored'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 5}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        dollars = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return {vars = { center.ability.extra.dollars }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
     calculate = function(self, card, context)
     if context.before and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                    faces = faces + 1
                    scored_card:set_ability('m_glass', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if faces > 0 then
                return {
                    message = localize('k_glass'),
                    colour = G.C.BLUE
                }
            end
        end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
}

SMODS.Joker{ --Rockstar
    key = 'rockstar', --joker key
    loc_txt = { -- local text
        name = 'Rockstar',
        text = {
          'Each played {C:attention}#2#{}',
          'of {V:1}#3#{} gives',
          '{C:money}$#1#{} when scored',
          '{s:0.8}Card changes every round{}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 5}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        dollars = 5
      }
    },
    loc_vars = function(self,info_queue,center)
        local idol_card = G.GAME.current_round.vremade_idol_card or { rank = 'Ace', suit = 'Spades' }
        return { vars = { center.ability.extra.dollars, localize(idol_card.rank, 'ranks'), localize(idol_card.suit, 'suits_plural'), colours = { G.C.SUITS[idol_card.suit] } } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
     calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:get_id() == G.GAME.current_round.vremade_idol_card.id and
            context.other_card:is_suit(G.GAME.current_round.vremade_idol_card.suit) then
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end,
    
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
}

-- Idol card picking function
local function reset_vremade_idol_card()
    G.GAME.current_round.vremade_idol_card = { rank = 'Ace', suit = 'Spades' }
    local valid_idol_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_idol_cards[#valid_idol_cards + 1] = playing_card
        end
    end
    local idol_card = pseudorandom_element(valid_idol_cards, 'vremade_idol' .. G.GAME.round_resets.ante)
    if idol_card then
        G.GAME.current_round.vremade_idol_card.rank = idol_card.base.value
        G.GAME.current_round.vremade_idol_card.suit = idol_card.base.suit
        G.GAME.current_round.vremade_idol_card.id = idol_card.base.id
    end
end

SMODS.Joker{ --Mogul
    key = 'mogul', --joker key
    loc_txt = { -- local text
        name = 'Mogul',
        text = {
          'Gains {C:mult}+#2#{} Mult',
          'after {C:attention}#3#{} purchases',
          '{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 2, y = 5}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0,
        mult_mod = 2,
        purchases = 0,
        payout = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return { vars = { center.ability.extra.mult, center.ability.extra.mult_mod, (center.ability.extra.payout - center.ability.extra.purchases) } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
     calculate = function(self, card, context)
        if (context.buying_card or context.open_booster) and not context.blueprint then
            card.ability.extra.purchases = card.ability.extra.purchases + 1
            if card.ability.extra.purchases == card.ability.extra.payout then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            card.ability.extra.purchases = 0
			return {
				message = 'Upgrade!',
				colour = G.C.CHIPS
				}
            end
        end
		
		if context.joker_main and card.ability.extra.mult > 0 then
		return {
			mult_mod = card.ability.extra.mult,
			card = card,
			message = '+' .. card.ability.extra.mult .. ' Mult',
			colour = G.C.MULT
			}
			end
    end,
    
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
}

SMODS.Joker{ --Baker
    key = 'baker', --joker key
    loc_txt = { -- local text
        name = 'Baker',
        text = {
          'This Joker gains',
          '{C:mult}+#2#{} Mult every {C:attention}#3#{} {C:inactive}[#4#]{}',
          'cards discarded',
          '{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 3, y = 5}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0,
        mult_mod = 2,
        discards = 0,
        payout = 12
      }
    },
    loc_vars = function(self,info_queue,center)
        return { vars = { center.ability.extra.mult, center.ability.extra.mult_mod, center.ability.extra.payout, (center.ability.extra.payout - center.ability.extra.discards) } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
     calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            card.ability.extra.discards = card.ability.extra.discards + 1
            if card.ability.extra.discards == card.ability.extra.payout then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            card.ability.extra.discards = 0
			return {
				message = 'Upgrade!',
				colour = G.C.MULT
				}
            end
        end
		
		if context.joker_main and card.ability.extra.mult > 0 then
		return {
			mult_mod = card.ability.extra.mult,
			card = card,
			message = '+' .. card.ability.extra.mult .. ' Mult',
			colour = G.C.MULT
			}
			end
    end,
    
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
}

SMODS.Joker{ --Rigoletto
    key = 'rigoletto', --joker key
    loc_txt = { -- local text
        name = 'Rigoletto',
        text = {
          'Jokers with {C:attention}editions{}',
          'each give {X:mult,C:white}X2{} Mult'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 0, y = 2 },
    cost = 20, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 2 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.other_joker and context.other_joker.edition then
		 if context.other_joker.edition.key == 'e_polychrome' or context.other_joker.edition.key == 'e_holo' or context.other_joker.edition.key == 'e_foil' or context.other_joker.edition.key == 'e_negative' then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				card = other_joker,
				message = 'X' .. card.ability.extra.Xmult .. ' Mult',
				colour = G.C.MULT,
				card:juice_up(0.5,0.5)
				}
				end
        end

        
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Panasco
    key = 'panasco', --joker key
    loc_txt = { -- local text
        name = 'Panasco',
        text = {
          'Sell {C:attention}1{} Joker during',
          'the {C:attention}Boss Blind{}',
		  'to create a random',
		  '{C:dark_edition}Negative{} Joker'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 1, y = 2 },
    cost = 20, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 3, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        ready = true --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
	info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return {vars = {center.ability.extra.ready}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.first_hand_drawn and G.GAME.blind.boss and card.ability.extra.ready and not context.end_of_round and not context.blueprint then
			local eval = function(card) return card.ability.extra.ready and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
		if context.selling_card and card.ability.extra.ready then
			SMODS.add_card({set = 'Joker', area = G.jokers, key_append = 'pana', edition = 'e_negative'})
            G.GAME.joker_buffer = 0
			card.ability.extra.ready = false
            return {
			true
			}
            end
		if context.end_of_round then
			card.ability.extra.ready = false
			return end
		if context.setting_blind then
		card.ability.extra.ready = true
		return end

    end,
	
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
    
}

SMODS.Joker{ --Archibald
    key = 'archibald', --joker key
    loc_txt = { -- local text
        name = 'Archibald',
        text = {
          'Retrigger all scored',
          'cards {C:attention}#1#{} times'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 0, y = 3 },
    cost = 20, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 3, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        repetitions = 2 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.repetitions}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
			return {
				message = 'Again!',
				repetitions = card.ability.extra.repetitions,
				card = card
				}
				end

    end,
	
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
}

SMODS.Joker{ --Y'shtola
    key = 'yshtola', --joker key
    loc_txt = { -- local text
        name = 'Y\'shtola',
        text = {
          'Prevents Death for',
          'all {C:attention}non-Boss Blinds{}',
          'and {C:attention}#2# Boss Blinds{}',
          '{C:inactive}(Boss Blind saves:{} {C:attention}#1#{}{C:inactive}/#2#){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 5, y = 5 },
    cost = 20, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 4, y = 5}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        raises = 0,
        raise_limit = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.raises, center.ability.extra.raise_limit}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.end_of_round and context.game_over and context.main_eval then
            if G.GAME.blind.boss then
                if card.ability.extra.raises < card.ability.extra.raise_limit then
                    card.ability.extra.raises = card.ability.extra.raises + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand_text_area.blind_chips:juice_up()
                            G.hand_text_area.game_chips:juice_up()
                            play_sound('tarot1')
                            return true
                        end
                    }))
                    return {
                        message = 'Saved!',
                        saved = 'Saved by Y\'shtola',
                        colour = G.C.GREEN
                    }
                end
            end
            if G.GAME.blind and not G.GAME.blind.boss then
                G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand_text_area.blind_chips:juice_up()
                            G.hand_text_area.game_chips:juice_up()
                            play_sound('tarot1')
                            return true
                        end
                    }))
                    return {
                        message = 'Saved!',
                        saved = 'Saved by Y\'shtola',
                        colour = G.C.GREEN
                    }
            end
        end
    end,
	
    in_pool = function(self,args)
         
        return not saltconfig.disable_jokers
    end,
}

SMODS.Consumable{ --Salt
    key = 'salt', --key
    set = 'Tarot', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 0, y = 0}, --position in atlas
    loc_txt = {
        name = 'Salt', --name of card
        text = { --text of card
            'Converts up to',
            '{C:attention}#1#{} selected cards',
			'to {C:hearts}Hearts{} or {C:diamonds}Diamonds{}'
        }
    },
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    config = {
        extra = {
            cards = 4, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 0.85 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        local _suit = pseudorandom_element({'H','D'}, pseudoseed('salt'))
            for i=1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({func = function()
                    local card = G.hand.highlighted[i]
                    local suit_prefix = _suit..'_'
                    local rank_suffix = card.base.id < 10 and tostring(card.base.id) or
                                        card.base.id == 10 and 'T' or card.base.id == 11 and 'J' or
                                        card.base.id == 12 and 'Q' or card.base.id == 13 and 'K' or
                                        card.base.id == 14 and 'A'
                    card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                return true end }))
            end
		delay(0.2)
		for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))

    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end,
}

SMODS.Consumable{ --Pepper
    key = 'pepper', --key
    set = 'Tarot', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 1, y = 0}, --position in atlas
    loc_txt = {
        name = 'Pepper', --name of card
        text = { --text of card
            'Converts up to',
            '{C:attention}#1#{} selected cards',
			'to {C:clubs}Clubs{} or {C:spades}Spades{}'
        }
    },
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    config = {
        extra = {
            cards = 4, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 0.85 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        local _suit = pseudorandom_element({'S','C'}, pseudoseed('pepp'))
            for i=1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({func = function()
                    local card = G.hand.highlighted[i]
                    local suit_prefix = _suit..'_'
                    local rank_suffix = card.base.id < 10 and tostring(card.base.id) or
                                        card.base.id == 10 and 'T' or card.base.id == 11 and 'J' or
                                        card.base.id == 12 and 'Q' or card.base.id == 13 and 'K' or
                                        card.base.id == 14 and 'A'
                    card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                return true end }))
            end
		delay(0.2)
		for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))

    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end,
}

SMODS.Consumable{ --Paprika
    key = 'paprika', --key
    set = 'Tarot', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 2, y = 0}, --position in atlas
    loc_txt = {
        name = 'Paprika', --name of card
        text = { --text of card
            'Select {C:attention}#1#{} cards, copy',
            '{C:attention}Enhancement{} of {C:attention}left card{}',
			'to the {C:attention}right card{}',
			'{C:inactive}(Drag to rearrange){}'
        }
    },
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    config = {
        extra = {
            cards = 2, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 0.85 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        local rightmost = G.hand.highlighted[1]
		local leftmost = G.hand.highlighted[1]
            for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
			for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x < leftmost.T.x then leftmost = G.hand.highlighted[i] end end
            for i=1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    if G.hand.highlighted[i] ~= rightmost then
                        rightmost:set_ability(G.P_CENTERS[leftmost.config.center.key],nil,true)
                    end
                    return true end }))
            end
		delay(0.2)
		for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))

    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end,
}

SMODS.Consumable{ --Sage
    key = 'sage', --key
    set = 'Tarot', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 3, y = 0}, --position in atlas
    loc_txt = {
        name = 'Sage', --name of card
        text = { --text of card
            'Decreases rank',
            'of {C:attention}#1#{} selected',
			'card by {C:attention}2{}'
        }
    },
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 0.85 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    local card = G.hand.highlighted[i]
                    local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                    local rank_suffix = card.base.id == 3 and 14 or card.base.id == 2 and 13 or math.max(card.base.id-2, 2)
                    if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                    elseif rank_suffix == 10 then rank_suffix = 'T'
                    elseif rank_suffix == 11 then rank_suffix = 'J'
                    elseif rank_suffix == 12 then rank_suffix = 'Q'
                    elseif rank_suffix == 13 then rank_suffix = 'K'
                    elseif rank_suffix == 14 then rank_suffix = 'A'
                    end
                    card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                return true end }))
            end  
		delay(0.2)
		for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))

    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end,
}

SMODS.Consumable{ --Cinnamon
    key = 'cinnamon', --key
    set = 'Tarot', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 0, y = 1}, --position in atlas
    loc_txt = {
        name = 'Cinnamon', --name of card
        text = { --text of card
            'Add {C:gold}$3{} of',
            '{C:attention}sell value{} to a',
			'random {C:attention}Joker{}'
        }
    },
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and #G.jokers.cards >= 1 then
                return true
        end
        return false
    end,
    use = function(self,card,area,copier)
		local jokers = {}
                for i=1, #G.jokers.cards do 
                    if G.jokers.cards[i] ~= self then
                        jokers[#jokers+1] = G.jokers.cards[i]
                    end
                end
                if #jokers > 0 then
                        local chosen_joker = pseudorandom_element(jokers, pseudoseed('cinn'))
                        chosen_joker.ability.extra_value = (chosen_joker.ability.extra_value or 0) + 3
                            chosen_joker:set_cost()
                            chosen_joker:juice_up(0.3, 0.5)
                    end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end,
}

SMODS.Consumable{ --Nutmeg
    key = 'nutmeg', --key
    set = 'Tarot', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 1, y = 1}, --position in atlas
    loc_txt = {
        name = 'Nutmeg', --name of card
        text = { --text of card
            'Destroy {C:attention}#1#{}',
            'selected card',
			'and earn {C:money}$2{}'
        }
    },
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)
		ease_dollars(2)
		G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function() 
                    for i=#G.hand.highlighted, 1, -1 do
                        local card = G.hand.highlighted[i]
                        --card:start_dissolve(nil, i == #G.hand.highlighted)
                        SMODS.destroy_cards(card)
                    end
                    return true end }))
                return {
                    message = '$2',
                    colour = G.C.MONEY,
                    delay = 0.45, 
                    remove = true,
                    card = card
                }
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end,
}

SMODS.Consumable{ --Tumeric
    key = 'tumeric', --key
    set = 'Tarot', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 2, y = 1}, --position in atlas
    loc_txt = {
        name = 'Tumeric', --name of card
        text = { --text of card
            'Gives up to',
			'{C:attention}#1#{} selected cards',
			'random {C:attention}Enhancements{}'
        }
    },
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    config = {
        extra = {
            cards = 2, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 0.85 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
		local random_ability = pseudorandom_element({'m_bonus','m_mult','m_wild','m_glass','m_steel','m_stone','m_gold','m_lucky'}, pseudoseed('tume'))
		for i=1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
					local card = G.hand.highlighted[i]
                    card:set_ability(G.P_CENTERS[random_ability],nil,true)
                    return true end }))
					end
		delay(0.2)
		for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))

    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end,
}

SMODS.Consumable{ --Saffron
    key = 'saffron', --key
    set = 'Tarot', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 3, y = 1}, --position in atlas
    loc_txt = {
        name = 'Saffron', --name of card
        text = { --text of card
            'Gives {C:money}$2{} for every',
            '{C:money}$5{} you have',
			'{C:inactive}(Max of{} {C:money}$50{}{C:inactive}){}',
			'{C:inactive}(Currently{} {C:money}$#2#{}{C:inactive}){}'
        }
    },
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.cards, math.min((math.floor(G.GAME.dollars/5) or 0), 20)}} --di0splays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.GAME.dollars >= 5 then
                return true
        end
        return false
    end,
    use = function(self,card,area,copier)
		local gain = math.min((math.floor((G.GAME.dollars*2)/5) or 0), 50)
		ease_dollars(gain)
                return {
                    message = '$' .. gain,
                    colour = G.C.MONEY,
                    delay = 0.45,
                    card = card
                }
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end,
}

SMODS.Seal { --Seafoam Seal
    key = 'Seafoam',
    atlas = 'Jokers',
    pos = { x = 4, y = 3 },
    badge_colour = HEX('5acf95'),
    loc_txt = {
        label = 'Seafoam Seal',
        name = 'Seafoam Seal',
        text = {
            'Creates a common {C:attention}Joker{}',
            'at end of round',
            'if {C:attention}held{} in hand',
            '{C:inactive}(Must have room){}'
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { (G.GAME.probabilities.normal or 1) } }
    end,
    calculate = function(self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    local new_card = SMODS.add_card({ set = 'Joker', area = G.jokers, key_append = 'ocean', rarity = 'Common' })
                    if new_card then
                        new_card:juice_up(0.3, 0.5)
                        play_sound('card1')
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            return { message = '+1 Joker', colour = G.C.ATTENTION }
        end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end
}

SMODS.Seal { --Copper Seal
    key = 'Copper',
    atlas = 'Jokers', --atlas
    pos = { x = 5, y = 3 },
    badge_colour = HEX('e28152'),
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'Copper Seal',
        -- Tooltip description
        name = 'Copper Seal',
        text = {
            '{C:green}#1# in 10{} chance to',
            'create a {C:spectral}Spectral{} card',
            'when {C:attention}discarded{}',
            '{C:inactive}(Must have room){}'
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { (G.GAME.probabilities.normal or 1) } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if pseudorandom('oxidise') < G.GAME.probabilities.normal/10 then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    SMODS.add_card({ set = 'Spectral' })
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return { message = localize('k_plus_spectral'), colour = G.C.SPECTRAL }
        end
    end
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end
}

SMODS.Consumable { --Cure
    key = 'cure', --key
    set = 'Spectral', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 0, y = 3}, --position in atlas
    loc_txt = {
        name = 'Cure', --name of card
        text = { --text of card
            'Add a {C:planet}Seafoam Seal{}',
			'to {C:attention}#1#{} selected',
			'card in your hand'
        }
    },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
	hidden = false,
    config = {
        extra = {
            cards = 1, --configurable value
            seal = 'salt_Seafoam'
        }
    },
    loc_vars = function(self,info_queue, center)
		info_queue[#info_queue+1] = {key = "s_salt_Seafoam", set = "Other"}
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end
}

SMODS.Consumable { --Aero
    key = 'aero', --key
    set = 'Spectral', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 1, y = 3}, --position in atlas
    loc_txt = {
        name = 'Aero', --name of card
        text = { --text of card
            'Add a {C:attention}Copper Seal{}',
			'to {C:attention}#1#{} selected',
			'card in your hand'
        }
    },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
	hidden = false,
    config = {
        extra = {
            cards = 1, --configurable value
            seal = 'salt_Copper'
        }
    },
    loc_vars = function(self,info_queue, center)
		info_queue[#info_queue+1] = {key = "s_salt_Copper", set = "Other"}
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end
}

SMODS.Consumable{ --Holy
    key = 'holy', --key
    set = 'Spectral', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 1, y = 2}, --position in atlas
    loc_txt = {
        name = 'Holy', --name of card
        text = { --text of card
            'Create {C:attention}3{}',
			'{C:attention} Double Tags{}, sets',
			'money to {C:money}$0{}'
        }
    },
    cost = 4, --cost
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
	hidden = false,
    config = {
        extra = {
            destroy = 3, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
		info_queue[#info_queue+1] = G.P_TAGS.tag_double
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.GAME.dollars ~= 0 then
                    ease_dollars(-G.GAME.dollars, true)
                end
                return true
            end
        }))
        delay(0.5)
        add_tag(Tag('tag_double'))
        add_tag(Tag('tag_double'))
        add_tag(Tag('tag_double'))
        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        delay(0.3)
    end,
    can_use = function(self, card)
        return true
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end
}

SMODS.Consumable{ --Banish
    key = 'banish', --key
    set = 'Spectral', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 2, y = 2}, --position in atlas
    loc_txt = {
        name = 'Banish', --name of card
        text = { --text of card
            'Destroy {C:attention}3{} random cards',
			'in hand and create',
			'a free {C:attention}Voucher Tag{}'
        }
    },
    cost = 4, --cost
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
	hidden = false,
    config = {
        extra = {
            destroy = 3, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
		info_queue[#info_queue+1] = G.P_TAGS.tag_voucher
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}

        for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )

        pseudoshuffle(temp_hand, 'holy')

        for i = 1, card.ability.extra.destroy do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        SMODS.destroy_cards(destroyed_cards)

        delay(0.5)
        add_tag(Tag('tag_voucher'))
        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        delay(0.3)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end
}

SMODS.Consumable{ --Dia
    key = 'Dia', --key
    set = 'Spectral', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 3, y = 2}, --position in atlas
    loc_txt = {
        name = 'Dia', --name of card
        text = { --text of card
            'Destroys {C:attention}all{}',
			'cards in hand'
        }
    },
    cost = 4, --cost
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
	hidden = false,
    config = {
        extra = {
            destroy = 1, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}

        for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )

        pseudoshuffle(temp_hand, 'holy')

        for i = 1, #G.hand.cards do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        SMODS.destroy_cards(destroyed_cards)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end
}

SMODS.Consumable{ --Geode
    key = 'geode', --key
    set = 'Spectral', --the set of the card: corresponds to a consumable type
    atlas = 'Spices', --atlas
    pos = {x = 0, y = 2}, --position in atlas
    loc_txt = {
        name = 'Geode', --name of card
        text = { --text of card
            'Make {C:attention}1{} selected',
			'card {C:dark_edition}Polychrome{}',
			'with a {C:red}Red Seal{}'
        }
    },
    cost = 4, --cost
	unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
	hidden = true,
	soul_set = 'Tarot',
	soul_rate = 0.003,
    config = {
        extra = {
            cards = 1, --configurable value
        }
    },
    loc_vars = function(self,info_queue, center)
		info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
		info_queue[#info_queue+1] = G.P_SEALS.Red
        return {vars = {center.ability.extra.cards}} --displays configurable value: the #1# in the description is replaced with the configurable value
    end,
    can_use = function(self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                return true
            end
        end
        return false
    end,
    use = function(self,card,area,copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 0.85 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
		for i=1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
					local card = G.hand.highlighted[i]
                    card:set_edition('e_polychrome',true)
					card:set_seal('Red',true)
                    return true end }))
					end
		delay(0.2)
		for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))

    end,
    in_pool = function(self,args)
         
        return not saltconfig.disable_spices
    end,
}

SMODS.Back{ --Sourdough Deck
    name = "Sourdough Deck",
    key = "sourdough",
    atlas = 'Decks',
    pos = {x = 1, y = 0},
    loc_txt = {
        name = "Sourdough Deck",
        text ={
            "{C:chips}-3{} hands and",
            "{C:mult}+3{} discards",
            "every round"
        },
    },
    apply = function(self)
    G.E_MANAGER:add_event(Event({
        func = function()
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 3
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 3
        ease_hands_played(-3)
        ease_discard(3)
        return true
    end
    }))
end
}

SMODS.Back{ --True Eclipse Deck
    name = "Eclipse Deck",
    key = "eclipse",
    atlas = 'Decks',
    pos = {x = 2, y = 0},
    loc_txt = {
        name = "Eclipse Deck",
        text ={
            "{C:planet}Celestial Packs{}",
            "and {C:planet}Planet Cards{}",
            "no longer appear",
            "in the shop"
        },
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
        func = function()
        G.GAME.planet_rate = 0
        SMODS.Booster:take_ownership_by_kind('Celestial',
    {
        weight = 0
        }, true)
        return true end }))
end
}

SMODS.Back{ --Ruined Deck
    name = "Ruined Deck",
    key = "ruined",
    atlas = 'Decks',
    pos = {x = 3, y = 0},
    loc_txt = {
        name = "Ruined Deck",
        text ={
            "Start run with the",
            "{C:blue}Magic Trick{} voucher",
            "and {C:attention}52{} {C:tarot}Stone{} cards",
            "in your deck"
        },
    },
    config = {vouchers = {'v_magic_trick'}},
    apply = function(self)
    G.E_MANAGER:add_event(Event({
        func = function()
        local cards = {}
        for i, card in ipairs(G.playing_cards) do
            cards[#cards+1] = card
        end
        for i = 1, #cards do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
					local card = cards[i]
                    card:set_ability(G.P_CENTERS["m_stone"],nil,true)
                    return true end }))
		end
        return true
    end
    }))
end
}

SMODS.Back{ --White Deck
    name = "White Deck",
    key = "white",
    atlas = 'Decks',
    pos = {x = 4, y = 0},
    loc_txt = {
        name = "White Deck",
        text ={
            "After defeating each",
            "{C:attention}Boss Blind{}, gain a",
            "{C:spectral}Spectral{} card"
        },
    },
     calculate = function(self, back, context)
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({set = 'Spectral', area = G.consumeables, key_append = 'whit'})
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
        end
    end
}

SMODS.Back{ --Royal Deck
    name = "Royal Deck",
    key = "Royal",
    atlas = 'Decks',
    pos = {x = 5, y = 0},
    loc_txt = {
        name = "Royal Deck",
        text ={
            "Start with {C:money}$15{}",
            "{C:attention}Interest{} cap equals",
            "{C:attention}sell value{} of Jokers"
        },
    },
    config = {vouchers = {'v_seed_money', 'v_money_tree'}},
    apply = function(self,back)
        G.GAME.starting_params.dollars = 15
    end,
    calculate = function(self,back,context)
        if context.round_eval then
        intcap = function(func)
            local bonus = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    bonus = bonus + G.jokers.cards[i].sell_cost
                end
            end
            return bonus * 5
        end
        G.GAME.interest_cap = intcap()
    end
end
}

function SMODS.current_mod.reset_game_globals(run_start)
    reset_vremade_idol_card()    -- See Rockstar
end


----------------------------------------------
------------MOD CODE END----------------------
