sudo add-apt-repository ppa:strukturag/libheif && sudo apt-get update && sudo apt-get install libheif-examples
cd $1
for f in *.HEIC
do
echo "Working on file $f"
heif-convert $f $f.jpg
done
