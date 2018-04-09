module Logic where

import Graphics.Rendering.OpenGL
import Input
import Data.Time
import Graphics.UI.GLUT

speed = 50.0


data Transforms = Transforms{rotationX::GLfloat
                            ,rotationY::GLfloat
                            ,rotationZ::GLfloat
                            }


initTransforms = Transforms {rotationX=0
                            ,rotationY=0
                            ,rotationZ=0
                            }


updRotationX f x = x{rotationX = (f (rotationX x))}
updRotationY f x = x{rotationY = (f (rotationY x))}
updRotationZ f x = x{rotationZ = (f (rotationZ x))}



idle input transform time = do
    s <- get time
    e <- getCurrentTime
    i <- get input
    t <- get transform
    let delta = ((realToFrac ((diffUTCTime  e s))))
    time $= e

    if (up i) then do
        transform $~! updRotationX (+ (speed * delta))
    else do return ()

    if (down i) then do
        transform $~! updRotationX (+ (-speed * delta))
    else do return ()

    if (left i) then do
        transform $~! updRotationY (+ (-speed * delta))
    else do return ()

    if (right i) then do
        transform $~! updRotationY (+ (speed * delta))
    else do return ()

    postRedisplay Nothing

keyboard input key Down _ _ = case key of
    (SpecialKey KeyUp) -> input $~! (setUp True)
    (SpecialKey KeyDown) -> input $~! (setDown True)
    (SpecialKey KeyLeft) -> input $~! (setLeft True)
    (SpecialKey KeyRight) -> input $~! (setRight True)
    _ -> return ()

keyboard input key Up _ _ = case key of
    (SpecialKey KeyUp) -> input $~! (setUp False)
    (SpecialKey KeyDown) -> input $~! (setDown False)
    (SpecialKey KeyLeft) -> input $~! (setLeft False)
    (SpecialKey KeyRight) -> input $~! (setRight False)
    _ -> return ()


