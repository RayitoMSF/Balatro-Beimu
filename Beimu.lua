sendDebugMessage("Launching Torashiro Beimu", "Beimu")

--JOKERS
SMODS.Atlas {
	key = "BeimuJoker",
	path = "BeimuJoker.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = 'Beimu',
	loc_txt = {
		name = 'Torashiro Beimu',
		text = {
      		"{C:chips}+#1#{} Chips when",
      		"{C:attention}0{} discards",
      		"remaining",
		}
	},
	config = { extra = { chips = 80 } },
	rarity = 1,
	atlas = 'BeimuJoker',
	pos = { x = 0, y = 0 },
	cost = 5,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.discards_left == 0 then
			return {
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
        		chip_mod = card.ability.extra.chips,
        		colour = G.C.CHIPS
			}
    end
  end
}

SMODS.Joker {
	key = 'Toranogetsu',
	loc_txt = {
		name = 'Toranogetsu',
		text = {
				"{C:purple}The Moon{} cards in",
                "your {C:attention}consumable{} area",
                "give {X:red,C:white} X#1# {} Mult"
		}
	},
	config = { extra = { Xmult = 1.5 } },
	rarity = 2,
	atlas = 'BeimuJoker',
	pos = { x = 1, y = 0 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		local final_mult = 1
		if context.joker_main then
			for i = 1, #G.consumeables.cards do
				if G.consumeables.cards[i].ability.name == 'The Moon' then
					final_mult = final_mult * card.ability.extra.Xmult
				end
			end
			if final_mult > 1 then
				return {
					message = localize { type = 'variable', key = 'a_xmult', vars = { final_mult } },
					Xmult_mod = final_mult
				}
			end
		end
  	end
}