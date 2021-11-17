import XMonad
import XMonad.Config.Desktop
import XMonad.Prompt.ConfirmPrompt

myTeminal :: String
myTeminal = "st"

myModMask :: KeyMask
myModMask = mod4Mask

myBorderWidth :: Dimension
myBorderWidth = 1

main :: IO ()
main = xmonad def
    { terminal    = myTeminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    }
