module Main where


--Imports
import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL

import Data.Time
import Shapes
import Input
import Renderer
import HelperFunctions
import Logic

main = do
    getArgsAndInitialize
    initialDisplayMode $= [WithDepthBuffer, DoubleBuffered]
    createWindow "Hello Window"
    depthFunc $= Just Less
    input <- new initInputs
    transform <- new initTransforms
    starttime <- getCurrentTime
    time <- new starttime
    keyboardMouseCallback $= Just (keyboard input)
    idleCallback $= Just (idle input transform time)
    displayCallback $= display transform
    mainLoop


