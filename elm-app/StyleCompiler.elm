port module StyleCompiler exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import String exposing (append)
import Models exposing (Animations(..))
import Style
import Animation

port files : CssFileStructure -> Cmd msg

fileStructure : CssFileStructure
fileStructure =
  Css.File.toFileStructure [ ( "app.bundle.css", modifiedFile (Css.File.compile [ Style.css ] ) ) ]

type alias File =
  { css : String
  , warnings : List String
  }

modifiedFile : File -> File
modifiedFile file =
  File (append (Animation.keyframes Pulse pulseFrames) file.css) file.warnings

pulseFrames : List Animation.Keyframe
pulseFrames =
  [ Animation.Keyframe 0 [ Animation.Property "transform" "(scale 0.5)", Animation.Property "opacity" "0" ]
  , Animation.Keyframe 50 [ Animation.Property "opacity" "0.2" ]
  , Animation.Keyframe 70 [ Animation.Property "opacity" "0.15" ]
  , Animation.Keyframe 0 [ Animation.Property "transform" "(scale 3)", Animation.Property "opacity" "0" ]
  ]

main : CssCompilerProgram
main =
  Css.File.compiler files fileStructure
