module Renderer where

import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL
import Shapes
import Logic

renderCube s = renderAs Quads (cubeQuads s)
renderCubeFrame s = renderAs Lines (cubeFrame s)

renderPyramid s = renderAs Triangles (pyramidTris s)
renderPyramidFrame s = renderAs Lines (pyramidFrame s)

renderAs figure ps = renderPrimitive figure$makeVertexes ps

makeVertexes = mapM_ (\ (x,y,z) -> vertex$Vertex3 x y z)

rotx a = rotate a $Vector3 1 0 (0::GLfloat)
roty a = rotate a $Vector3 0 1 (0::GLfloat)
rotz a = rotate a $Vector3 0 0 (1::GLfloat)


shear f = do
     m <- (newMatrix RowMajor [1,f,0,0,0,1,0,0,0,0,1,0,0,0,0,1])
     multMatrix (m:: GLmatrix GLfloat)

display transform = do
    clearColor $= Color4 0.3 0.3 0.3 1
    clear [ColorBuffer, DepthBuffer]
    loadIdentity
    currentColor $= Color4 0 0 1 1
    x <- get transform
    rotx (rotationX x)
    roty (rotationY x)
    rotz (rotationZ x)
    let s = 0.5
    --translate $Vector3 (-s/2) (-s/2) (-s/2)
    renderCube s
    currentColor $= Color4 0 0 0 1
    renderCubeFrame s
   
    currentColor $= Color4 1 0 0 1
    translate $Vector3 (s/2) (s/2) (s/2)
    translate $Vector3 (0.0) (0.0) ((s/2)::GLfloat)
    renderPyramid (s/2)
    currentColor $= Color4 0 0 0 1
    renderPyramidFrame (s/2)
    
    swapBuffers
    
