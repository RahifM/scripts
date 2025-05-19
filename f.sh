set -e

sudo apt update && sudo apt install ffmpeg -y

echo -e "\nPlease set input and input! (only 720p encodes supported as of now)\n"
read -e -p "Input: " i
read -e -p "Output: " o

if [ -z "$i" -o -z "$o" ]; then
       echo -e "\nNo input or output found\n"
       exit 1
fi

echo -e "\n"

low() {
time ffmpeg -i  "${i}" -s 1280x720 -c copy -map 0 -c:v libx265 -x265-params crf=28 -pix_fmt yuv420p -preset slow  "${o}"
}

up() {
[ -f "github-release-2.0.0.2-ubuntu" ] && echo "gh rel already exists" || ( echo "gh rel not found" && wget https://github.com/tfausak/github-release/releases/download/2.0.0.2/github-release-2.0.0.2-ubuntu && chmod +x github-release-2.0.0.2-ubuntu )

./gi* upload --token $ghsecret --owner 'zmzu' --repo 'dump' --tag '1.0' --file ${o} --name ${o}
}

low

[ -f ${o} ] && echo "File found" && up && echo "Uploading done" || echo "Failed upload"
