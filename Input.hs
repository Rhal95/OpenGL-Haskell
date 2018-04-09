module Input where

data Inputs = Inputs {up::Bool
                     ,down::Bool
                     ,left::Bool
                     ,right::Bool
                     }
                     
                     
initInputs = Inputs {up=False
                    ,down=False
                    ,left=False
                    ,right=False
                    }
                    
setUp val x  = x {up= val}
setDown val x  = x {down= val}
setLeft val x  = x {left= val}
setRight val x  = x {right= val}



