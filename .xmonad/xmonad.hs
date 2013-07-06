import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.ThreeColumns

windowExpandRate = (3/100)
mainWindowPercentage = (37/100)
myLayout = ThreeColMid 1 windowExpandRate mainWindowPercentage ||| Tall 1 windowExpandRate (1/2)
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
myBar = "xmobar"
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
myConfig = defaultConfig {
    terminal = "xterm",
    manageHook = manageDocks <+> manageHook defaultConfig,
    layoutHook = avoidStruts  $  layoutHook defaultConfig { layoutHook = myLayout },
    modMask = mod4Mask,    -- Rebind Mod to the Windows key
    focusedBorderColor = "#2aa198",
    normalBorderColor = "#839496"
}
