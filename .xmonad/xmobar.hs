Config
    { position = Bottom
    , commands =
        [ Run StdinReader
        , Run Date "%A %e %B %Y - %H:%M" "date" 10
        , Run MultiCpu  ["-t", "CPU <autototal>"] 10
        , Run Memory ["-t", "RAM <usedratio>"] 10
        , Run Swap ["-t", "SWP <usedratio>"] 10
        , Run BatteryP ["BAT0", "BAT1"]
            [ "-t", "BAT <left> <acstatus> (<timeleft>)"
            , "--"
            , "-O", "Charging"
            , "-i", "Charged"
            , "-o", "Discharging"
            ] 10

            , Run Brightness
            [ "-t", "LCD <percent>"
            , "--"
            , "-D", "intel_backlight"
            ] 1
        -- , Run Volume "default" "Master" [] 1
        -- , Run Volume "default" "Master" ["-t", "VOL <volume> <status>"] 1
        ]
    -- , template = "%StdinReader% } %date% { %bright% | %default:Master% | %multicpu% | %memory% | %swap% | %battery% "
    , template = "%StdinReader% } %date% { %bright% | %multicpu% | %memory% | %swap% | %battery% "
    , hideOnStart = False
    , overrideRedirect = True
    , persistent = True
    }
