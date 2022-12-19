#include "StatBoostMgr.h"

StatBoostMgr::StatType StatBoostMgr::GetStatTypeFromSubClass(Item* item)
{
    if (item->GetTemplate()->Class == ITEM_CLASS_WEAPON)
    {
        switch (item->GetTemplate()->SubClass)
        {
        case ITEM_SUBCLASS_WEAPON_MACE2:
        case ITEM_SUBCLASS_WEAPON_POLEARM:
        case ITEM_SUBCLASS_WEAPON_SPEAR:
        case ITEM_SUBCLASS_WEAPON_GUN:
        case ITEM_SUBCLASS_WEAPON_BOW:
        case ITEM_SUBCLASS_WEAPON_CROSSBOW:
            switch (urand(0, 2))
            {
            case 0:
                return STAT_TYPE_TANK;

            case 1:
                return STAT_TYPE_PHYS;

            case 2:
                return STAT_TYPE_HYBRID;
            }

        case ITEM_SUBCLASS_WEAPON_THROWN:
            return STAT_TYPE_PHYS;

        case ITEM_SUBCLASS_WEAPON_DAGGER:
            switch (urand(0, 2))
            {
            case 0:
                return STAT_TYPE_PHYS;

            case 1:
                return STAT_TYPE_HYBRID;

            case 2:
                return STAT_TYPE_SPELL;
            }

        case ITEM_SUBCLASS_WEAPON_STAFF:
            switch (urand(0, 3))
            {
            case 0:
                return STAT_TYPE_TANK;

            case 1:
                return STAT_TYPE_PHYS;

            case 2:
                return STAT_TYPE_HYBRID;

            case 3:
                return STAT_TYPE_SPELL;
            }

        case ITEM_SUBCLASS_WEAPON_AXE:
        case ITEM_SUBCLASS_WEAPON_AXE2:
        case ITEM_SUBCLASS_WEAPON_MACE:
        case ITEM_SUBCLASS_WEAPON_SWORD:
        case ITEM_SUBCLASS_WEAPON_SWORD2:
        case ITEM_SUBCLASS_WEAPON_FIST:
            switch (urand(0, 1))
            {
            case 0:
                return STAT_TYPE_TANK;

            case 1:
                return STAT_TYPE_PHYS;
            }

        case ITEM_SUBCLASS_WEAPON_WAND:
            return STAT_TYPE_SPELL;
        }
    }
    else if (item->GetTemplate()->Class == ITEM_CLASS_ARMOR)
    {
        switch (item->GetTemplate()->SubClass)
        {
        case ITEM_SUBCLASS_ARMOR_CLOTH:
            switch (item->GetTemplate()->InventoryType)
            {
            case INVTYPE_CLOAK:
                switch (urand(0, 3))
                {
                case 0:
                    return STAT_TYPE_TANK;

                case 1:
                    return STAT_TYPE_PHYS;

                case 2:
                    return STAT_TYPE_HYBRID;

                case 3:
                    return STAT_TYPE_SPELL;
                }

            default:
                return STAT_TYPE_SPELL;
            }
            break;

        case ITEM_SUBCLASS_ARMOR_LEATHER:
        case ITEM_SUBCLASS_ARMOR_MAIL:
        case ITEM_SUBCLASS_ARMOR_PLATE:
            switch (urand(0, 3))
            {
            case 0:
                return STAT_TYPE_TANK;

            case 1:
                return STAT_TYPE_PHYS;

            case 2:
                return STAT_TYPE_HYBRID;

            case 3:
                return STAT_TYPE_SPELL;
            }

        case ITEM_SUBCLASS_ARMOR_BUCKLER:
        case ITEM_SUBCLASS_ARMOR_SHIELD:
            switch (urand(0, 1))
            {
            case 0:
                return STAT_TYPE_TANK;
            case 1:
                return STAT_TYPE_SPELL;
            }
        }
    }

    return STAT_TYPE_NONE;
}   

StatBoostMgr::StatType StatBoostMgr::ScoreItem(Item* item, bool hasAdditionalSpells)
{
    ScoreData tankScore { STAT_TYPE_TANK, 0 },
        physScore { STAT_TYPE_PHYS, 0 },
        hybridScore { STAT_TYPE_HYBRID, 0 },
        spellScore { STAT_TYPE_SPELL, 0 };

    //Store the scores in a vector so I can order by highest for a winner.
    std::vector<ScoreData*> scores;
    scores.push_back(&tankScore);
    scores.push_back(&physScore);
    scores.push_back(&hybridScore);
    scores.push_back(&spellScore);

    //TODO: IMPLEMENT SCORING
    auto itemTemplate = item->GetTemplate();
    auto subClass = itemTemplate->SubClass;

    for (uint32 i = 0; i < itemTemplate->StatsCount; i++)
    {
        auto stat = itemTemplate->ItemStat[i];
        uint32 statType = stat.ItemStatType;

        sBoostConfigMgr->EnchantScores.Evaluate(0, statType, subClass, tankScore.Score, physScore.Score, spellScore.Score, hybridScore.Score);
    }

    //Sometimes stats are stored as additional spell effects and also need to be checked.
    if (hasAdditionalSpells)
    {
        auto scores = sBoostConfigMgr->EnchantScores.Get();

        for (_Spell const &spell : itemTemplate->Spells)
        {
            if (spell.SpellId)
            {
                auto spellInfo = sSpellMgr->GetSpellInfo(spell.SpellId);
                
                if (!spellInfo || !scores)
                {
                    continue;
                }

                for (auto const &score : *scores)
                {
                    if (score.modType == 1)
                    {
                        if (spellInfo->HasAura(static_cast<AuraType>(score.modId)))
                        {
                            sBoostConfigMgr->EnchantScores.Evaluate(1, score.modId, subClass, tankScore.Score, physScore.Score, spellScore.Score, hybridScore.Score);

                        }
                    }
                }
            }
        }
    }

    //Tally up the results, the highest score is picked.
    auto winningScore = scores[0];

    if (!winningScore)
    {
        return STAT_TYPE_NONE;
    }

    for (auto score : scores)
    {
        if (score->Score > winningScore->Score)
        {
            winningScore = score;
        }
    }

    //No stats on the items could be scored.
    if (winningScore->Score < 1)
    {
        return STAT_TYPE_NONE;
    }

    return winningScore->StatType;
}

void StatBoostMgr::MakeSoulbound(Item* item, Player* player)
{
    auto itemTemplate = item->GetTemplate();

    if (itemTemplate->Bonding == BIND_WHEN_EQUIPED)
    {
        item->SetState(ITEM_CHANGED, player);
        item->SetBinding(true);
    }
}

StatBoostMgr::StatType StatBoostMgr::AnalyzeItem(Item* item)
{
    auto itemTemplate = item->GetTemplate();

    //The spellids need to be checked because the Spells array is always allocated to a fixed size.
    //Thus we need to count how many VALID spells are in the array.
    uint32 spellsCount = 0;
    for (const auto& spell : itemTemplate->Spells)
    {
        if (spell.SpellId)
        {
            spellsCount++;
        }
    }

    if (itemTemplate->StatsCount < 1 && spellsCount < 1)
    {
        return GetStatTypeFromSubClass(item);
    }

    return ScoreItem(item, spellsCount);
}

bool StatBoostMgr::BoostItem(Player* player, Item* item, uint32 chance)
{
    //Is not weapon or armor.
    if (!IsEquipment(item))
    {
        return false;
    }

    if (sBoostConfigMgr->VerboseEnable)
    {
        ChatHandler(player->GetSession()).SendSysMessage("Passed Equipment Check");
    }

    if (item->GetTemplate()->Quality < sBoostConfigMgr->MinQuality ||
        item->GetTemplate()->Quality > sBoostConfigMgr->MaxQuality)
    {
        return false;
    }

    if (sBoostConfigMgr->VerboseEnable)
    {
        ChatHandler(player->GetSession()).SendSysMessage("Passed Quality Check");
    }

    //Roll for the chance to upgrade.
    uint32 roll = urand(0, 100);

    if (roll > chance)
    {
        return false;
    }

    if (sBoostConfigMgr->VerboseEnable)
    {
        ChatHandler(player->GetSession()).SendSysMessage("Passed Roll Check");
    }

    //Fetch the type of stats that should be applied to the piece.
    StatType statType = AnalyzeItem(item);

    //Failed to find a stat type.
    if (statType == STAT_TYPE_NONE)
    {
        statType = GetStatTypeFromSubClass(item);
    }

    if (sBoostConfigMgr->VerboseEnable)
    {
        ChatHandler(player->GetSession()).SendSysMessage("Passed Analyze Check");
    }

    uint32 itemClass = item->GetTemplate()->Class;
    uint32 itemSubClass = item->GetTemplate()->SubClass;
    uint32 itemLevel = item->GetTemplate()->ItemLevel;

    uint32 itemClassMask = 1 << itemClass;

    if (!itemClassMask)
    {
        return false;
    }

    if (sBoostConfigMgr->VerboseEnable)
    {
        ChatHandler(player->GetSession()).SendSysMessage("Passed ItemClass Check");
    }

    uint32 itemSubClassMask = 1 << itemSubClass;

    if (!itemSubClassMask)
    {
        return false;
    }

    if (sBoostConfigMgr->VerboseEnable)
    {
        ChatHandler(player->GetSession()).SendSysMessage("Passed ItemSubClass Check");
    }

    if (sBoostConfigMgr->VerboseEnable)
    {
        LOG_INFO("module", ">> Trying to get enchant with role mask {}, class {}, subClass {}, and itemlevel {} from pool.", statType, itemClassMask, itemSubClassMask, itemLevel);
    }

    //Fetch an enchant from the enchant pool.
    auto enchant = sBoostConfigMgr->EnchantPool.Get(statType, itemClassMask, itemSubClassMask, itemLevel);

    //Failed to find a valid enchant.
    if (!enchant)
    {              
        return false;
    }

    if (sBoostConfigMgr->VerboseEnable)
    {
        ChatHandler(player->GetSession()).SendSysMessage("Passed Enchant Check");
    }

    
    if (itemClass != ITEM_CLASS_WEAPON)
    {
        return EnchantItem(player, item, TEMP_ENCHANTMENT_SLOT, enchant->Id, sBoostConfigMgr->OverwriteEnchantEnable);
    }
    else
    {
        EnchantmentSlot enchantSlot = GetEnchantSlotForItem(item);

        if (enchantSlot != MAX_ENCHANTMENT_SLOT)
        {
            return EnchantItem(player, item, enchantSlot, enchant->Id, sBoostConfigMgr->OverwriteEnchantEnable) &&
                EnchantItem(player, item, PRISMATIC_ENCHANTMENT_SLOT, 2814, sBoostConfigMgr->OverwriteEnchantEnable);
        }
    }

    return false;
}

EnchantmentSlot StatBoostMgr::GetEnchantSlotForItem(Item* item)
{
    auto itemTemplate = item->GetTemplate();

    if (!itemTemplate->Socket[0].Color)
    {
        return SOCK_ENCHANTMENT_SLOT;
    }
    if (!itemTemplate->Socket[1].Color)
    {
        return SOCK_ENCHANTMENT_SLOT_2;
    }
    if (!itemTemplate->Socket[2].Color)
    {
        return SOCK_ENCHANTMENT_SLOT_3;
    }

    return MAX_ENCHANTMENT_SLOT;
}

bool StatBoostMgr::IsEquipment(Item* item)
{
    auto itemTemplate = item->GetTemplate();

    if (itemTemplate->Class != ITEM_CLASS_WEAPON &&
        itemTemplate->Class != ITEM_CLASS_ARMOR)
    {
        return false;
    }

    return true;
}

bool StatBoostMgr::EnchantItem(Player* player, Item* item, EnchantmentSlot slot, uint32 enchantId, bool overwrite)
{
    if (item->GetEnchantmentId(slot) && !overwrite)
    {
        return false;
    }

    player->ApplyEnchantment(item, false);
    item->SetEnchantment(EnchantmentSlot(slot), enchantId, 0, 0);
    player->ApplyEnchantment(item, true);

    return true;
}
