
    local _G = getfenv(0)

    local TEXTURE = [[Interface\AddOns\modui\statusbar\texture\sb.tga]]
    local BACKDROP = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],}

    local container = CreateFrame('Frame', 'moddkp_container', UIParent)
    container:SetWidth(345) container:SetHeight(380)
    container:SetPoint('TOP', UIParent, 0, -20)
    container:SetBackdrop(BACKDROP)
    container:SetBackdropColor(0, 0, 0, 1)
    container:SetMovable(true) container:SetUserPlaced(true)
    container:RegisterForDrag'LeftButton' container:EnableMouse(true)
    container:SetScript('OnDragStart', function() container:StartMoving() end)
    container:SetScript('OnDragStop', function() container:StopMovingOrSizing() end)
    container:Hide()

    container.guild = CreateFrame('Button', 'moddkp_guild', container)
    container.guild:SetHeight(15)
    container.guild:SetPoint('TOPLEFT', 22, -10)

    container.guild.text = container.guild:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    container.guild.text:SetPoint('CENTER', container.guild)
    container.guild.text:SetText'Guild'
    container.guild.text:SetTextColor(64/255, 251/255, 64/255)
    container.guild:SetWidth(container.guild.text:GetStringWidth())

    container.raid = CreateFrame('Button', 'moddkp_raid', container)
    container.raid:SetWidth(100) container.raid:SetHeight(15)
    container.raid:SetPoint('TOPLEFT', container.guild, 'TOPRIGHT', 30, 0)

    container.raid.text = container.raid:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    container.raid.text:SetPoint('CENTER', container.raid)
    container.raid.text:SetText'Raid'
    container.raid.text:SetTextColor(255/255, 125/255, 0)
    container.raid:SetWidth(container.raid.text:GetStringWidth())

    for i = 1, 8 do
        local class = i == 1 and 'Druid' or i == 2 and 'Hunter' or i == 3 and 'Mage' or i == 4 and 'Paladin' or i == 5 and 'Priest' or i == 6 and 'Rogue' or i == 7 and 'Warlock' or 'Warrior'
        local colour = RAID_CLASS_COLORS[string.upper(class)]

        container.class = CreateFrame('Button', 'moddkp_class'..i, container)
        container.class:SetHeight(15)

        if i == 1 then
            container.class:SetPoint('TOPLEFT', container.raid, 'TOPRIGHT', 30, 0)
        elseif i == 4 then
            container.class:SetPoint('TOPLEFT', container.guild, 'BOTTOMLEFT', 0, -2)
        elseif i == 5 then
            container.class:SetPoint('TOPLEFT', _G['moddkp_class'..(i - 1)], 'TOPRIGHT', 19, 0)
        elseif i == 6 then
            container.class:SetPoint('TOPLEFT', _G['moddkp_class'..(i - 1)], 'TOPRIGHT', 20, 0)
        elseif i == 7 then
            container.class:SetPoint('TOPLEFT', _G['moddkp_class'..(i - 1)], 'TOPRIGHT', 26, 0)
        elseif i == 8 then
            container.class:SetPoint('TOPLEFT', _G['moddkp_class'..(i - 1)], 'TOPRIGHT', 22, 0)
        else
            container.class:SetPoint('TOPLEFT', _G['moddkp_class'..(i - 1)], 'TOPRIGHT', 30, 0)
        end

        container.class.text = container.class:CreateFontString('moddkp_class'..i..'text', 'OVERLAY', 'GameFontNormal')
        container.class.text:SetPoint('CENTER', container.class)
        container.class.text:SetText(class)
        container.class.text:SetTextColor(colour.r, colour.g, colour.b)
        container.class:SetWidth(container.class.text:GetStringWidth())
    end

    local scrollframe = CreateFrame('ScrollFrame', 'moddkp_scrollframe', container, 'UIPanelScrollFrameTemplate')
    scrollframe:SetFrameLevel(3)
    scrollframe:SetPoint('TOPLEFT', container, 16, -50)
    scrollframe:SetPoint('BOTTOMRIGHT', container, -32, 36)
    scrollframe:Raise()
    scrollframe:SetToplevel()

    local body = CreateFrame('Frame', 'moddkp_body', scrollframe)
    body:SetWidth(300) body:SetHeight(300)
    body:EnableMouse(true)
    body:EnableMouseWheel(true)

    container.add = CreateFrame('Button', 'moddkp_add', container)
    container.add:SetHeight(15)
    container.add:SetPoint('BOTTOMLEFT', 15, 15)

    container.add.text = container.add:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
    container.add.text:SetPoint('CENTER', container.add)
    container.add.text:SetText'+'
    container.add:SetWidth(container.add.text:GetStringWidth())

    container.subtract = CreateFrame('Button', 'moddkp_subtract', container)
    container.subtract:SetHeight(15)
    container.subtract:SetPoint('LEFT', container.add, 'RIGHT', 15, 0)

    container.subtract.text = container.subtract:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
    container.subtract.text:SetPoint('CENTER', container.subtract)
    container.subtract.text:SetText'-'
    container.subtract:SetWidth(container.subtract.text:GetStringWidth())

    container.percentadd = CreateFrame('Button', 'moddkp_percentadd', container)
    container.percentadd:SetHeight(15)
    container.percentadd:SetPoint('LEFT', container.subtract, 'RIGHT', 15, -1)

    container.percentadd.text = container.percentadd:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    container.percentadd.text:SetFont(STANDARD_TEXT_FONT, 13)
    container.percentadd.text:SetPoint('CENTER', container.percentadd)
    container.percentadd.text:SetText'%'
    container.percentadd:SetWidth(container.percentadd.text:GetStringWidth())

    scrollframe.content = body
    scrollframe:SetScrollChild(body)

    --
