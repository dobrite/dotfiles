import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.ThreeColumns
import XMonad.Actions.SpawnOn
import XMonad.Hooks.ManageHelpers
import XMonad.Config.Xfce

myManageHook = composeAll [
    className =? "MPlayer" --> doFloat,
    className =? "Gimp" --> doFloat,
    className =? "Xfce4-appfinder" --> doFloat,
    className =? "Xfce4-whiskermenu" --> doFloat,
    className =? "Xfrun4" --> doFloat,
    resource =? "desktop_window" --> doIgnore,
    resource =? "kdesktop" --> doIgnore
    ]

myWorkspaces = ["main", "web", "misc" ] ++ map show [4..9]
windowExpandRate = (3/100)
mainWindowPercentage = (37/100)
myLayout = ThreeColMid 1 windowExpandRate mainWindowPercentage |||
           Tall 2 windowExpandRate (1/3) |||
           Tall 1 windowExpandRate (2/3)
main = xmonad myConfig
myConfig = xfceConfig {
    workspaces = myWorkspaces,
    terminal = "xfce4-terminal",
    manageHook = manageSpawn <+> ( isFullscreen --> doFullFloat ) <+> manageDocks <+> myManageHook,
    layoutHook = avoidStruts  $  layoutHook xfceConfig { layoutHook = myLayout },
    modMask = mod4Mask,    -- Rebind Mod to the Windows key
    focusedBorderColor = "#073642",
    normalBorderColor = "#073642"
}
