return {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Other = {
            -- this should be the full key of your object, including any prefixes
            s_salt_Seafoam = {
                name = 'Seafoam Seal',
                text = {
                    'Creates a common {C:attention}Joker{}',
                    'at end of round',
                    'if {C:attention}held{} in hand',
                    '{C:inactive}(Must have room){}'
                },
            },
            s_salt_Copper = {
                name = 'Copper Seal',
                text = {
                    '{C:green}1 in 10{} chance to',
                    'create a {C:spectral}Spectral{} card',
                    'when {C:attention}discarded{}',
                    '{C:inactive}(Must have room){}'
                },
            },
        },
    },
}