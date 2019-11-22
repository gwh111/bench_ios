
dir_path=${1:-'./Application/'}

cp -a $dir_path /Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project\ Templates/Base/bench_ios\ Application/

dir_path=${2:-'./Class/'}

cp -a $dir_path /Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File\ Templates/bench_ios\ Class/
