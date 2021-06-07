set PATH $PATH /opt/anaconda/bin
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/anaconda/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

#opam configuration
source /home/imgomez/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set -U fish_greeting
eval "conda deactivate"

thefuck --alias | source

alias checkgpu="watch cat /proc/acpi/bbswitch"

export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/intel_icd.x86_64.json:/usr/share/vulkan/icd.d/primus_vk_wrapper.json

export EZPOST_TEST_KEY="RVpUS2ZmNzEwMmNlMTJkYTQzYjI5OGYyOWE4M2E1YzljMGViWHU0ZGNvNmtqMDh4T1ZzWWxPWURrZw=="

alias remacs="emacs & disown & exit"
alias dmacs="emacs & disown"
alias mcmt="make clean && make test"

set -U fish_user_paths ~/.emacs.d/bin $fish_user_paths

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/imgomez/google-cloud-sdk/path.fish.inc' ]; . '/home/imgomez/google-cloud-sdk/path.fish.inc'; end
