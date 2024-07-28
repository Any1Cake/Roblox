local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheAbsolutionism/Wally-GUI-Library-V2-Remastered/main/Library%20Code", true))()

    library.options.underlinecolor = 'rainbow' -- makes the underline of each "window" rainbow
    library.options.toggledisplay = 'Fill' or 'Check' -- Applies to all toggles, [Fill] OFF = RED, ON = GREEN [CHECK] OFF = BLANK,ON = CHECKMARK

    local Window = library:CreateWindow('Example-Window') -- 1st Arg = name of window

    local Label = Window:Label('Label',(true or false or nil)) -- 1st Arg = Text Displayer, 2nd Arg = want TextColor to be rainbow, TRUE = yes, FALSE or NIL = NO
        -- Returns the label itself to manually mess with
        -- Label.Text, Label.TextColor3, Label.Visible, etc

    local Section = Window:Section('Section',(true or false or nil)) -- 1st Arg = Text Displayer, 2nd Arg = want TextColor to be rainbow, TRUE = yes, FALSE or NIL = NO
        -- Returns the section label itself to manually mess with
        -- Section.Text, Section.TextColor3, Section.Visible, etc

    local Button = Window:Button('Button',function() -- 1st Arg = Text Displayer, 2nd Arg = callback function when button is clicked
    
    end)
        -- Returns Fire function, to fire function connected to button without clicking
        -- Button.Fire()

    local Toggle = Window:Toggle('Toggle',{ -- 1st Arg = Text Display
        ['default'] = (true or false or nil); -- Arg if you want to manually set it to be Active or not when created
        ['flag'] = 'AnyStringName'; -- Name to be called upon when applied to specified table or default table of library
        ['location'] = {}; -- Can be edited for any table or will be placed in Window.flags
    },function() -- callback function when toggle is turned on or off
    
    end)
        -- Returns function to turn toggle on or off through script instead of click
        -- Toggle.Set(true or false)
        -- if Window.flags['AnyStringName'] == true then etc.

    local Box = Window:Box('Box',{ -- 1st Arg = Name of Box Displayed
        ['default'] = 'string' or 0; -- Arg to manually set it when created can be string or number
        ['type'] = 'number' or nil; -- If want to Box to only be numbers keep 'number', if want other characters for such as saving names put nil
        ['min'] = 0; -- if type = 'number' this will set how low can the number be set in the box
        ['max'] = math.huge; -- if type = 'number' this will set how high can the number be set in the box
        ['flag'] = 'AnyStringName'; -- Name to be called upon when applied to specified table or default table of library
        ['location'] = {}; -- Can be edited for any table or will be placed in Window.flags
    },function()-- callback function when box context is changed // set
    
    end)
        -- Returns a table of Box and function to manually set the box to something else
        -- Box.Box.Text, Box.Box.TextColor3, Box.Box.Visible, etc
        -- Box.SetNew('string' or 0)
        -- if Window.flags['AnyStringName'] == 1 then -- if number
        -- if Window.flags['AnyStringName'] == 'Absolutionism' then -- if string

    local Bind = Window:Bind('Bind',{ -- 1st Arg = Name of Bind Displayed
        ['default'] = Enum.KeyCode.KeypadOne or nil; -- Arg to manually set Bind when created
        ['kbonly'] = (true or false); -- Arg to when changing Bind, if true can only be keyboard bind // keys or if false then mouse click for example
        ['flag'] = 'AnyStringName'; -- Name to be called upon when applied to specified table or default table of library
        ['location'] = {}; -- Can be edited for any table or will be placed in Window.flags
    },function()-- callback function when keybind pressed // not when being changed
    
    end)
    
    local Slider = Window:Slider('Slider',{ -- 1st Arg = Name of Slider Displayed
        ['default'] = 0; -- Arg to manually set Slider location when created, if not set, will set to min
        ['min'] = 0; -- Sets how low the slider can go
        ['max'] = 10; -- sets hoe high the slider can go
        ['precise'] = (true or false); -- when true only does whole numbers (0,1,2), when flase does decimals (0.1,0.2,0.3)
        ['flag'] = 'AnyStringName'; -- Name to be called upon when applied to specified table or default table of library
        ['location'] = {}; -- Can be edited for any table or will be placed in Window.flags
    },function()-- callback function when slider is changed
    
    end)
        -- Returns function to manually set something new
        -- Slider.Set(7)

    local SearchBox = Window:SearchBox('SearchBox',{ -- 1st Arg = Name of SearchBox Displayed
        ['list'] = {'A','B','C'}; -- List that can be found when searching; only strings
        ['flag'] = 'AnyStringName'; -- Name to be called upon when applied to specified table or default table of library
        ['location'] = {}; -- Can be edited for any table or will be placed in Window.flags
    },function()-- callback function when User clicks on available selection from List
    
    end)
        -- Returns table of Box and function to change the list
        -- SearchBox.Box.Text, SearchBox.Box.TextColor3, SearchBox.Box.Visible, etc
        -- SearchBox.Reload({'D','E','F'})

    local Dropdown = Window:Dropdown('Dropdown',{ -- 1st Arg = Name of Dropdown Displayed
        ['default'] = '' or nil; -- Manually set the current selection to blank, if nil then will choose first selection in list provided
        ['list'] = {'A','B','C'}; -- List that will be shown when dropdown is opened; only strings
        ['colors'] = {['A'] = Color3.fromRGB(255,0,0);['B'] = Color3.fromRGB(0,255,0);['C'] = Color3.fromRGB(0,0,255)}; -- ColorList corresponding with all selection in List to show color when dropped
        ['flag'] = 'AnyStringName'; -- Name to be called upon when applied to specified table or default table of library
        ['location'] = {}; -- Can be edited for any table or will be placed in Window.flags
    },function()-- callback function when User clicks on available selection from List
    
    end)
        -- Returns table of function to change the list and or current selection
        -- Dropdown.Refresh({'C','D','E'},'D' or nil)

    -- I Made this one and i can say im kind of happy with it
    local DropSection = Window:DropSection('DropSection') -- 1st Arg = Name of DropSection Displayed
    DropSection:Toggle('Toggle')
    DropSection:Dropdown('Dropdown')
    DropSection:SearchBox('SearchBox')
    DropSection:Slider('Slider')
    DropSection:Bind('Bind')
    DropSection:Box('Box')
    DropSection:Button('Button')
    DropSection:Section('Section')
    DropSection:Label('Label')
