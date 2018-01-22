# load zsh config files
config_files = (~/.zsh/*.zsh)
for file in $(configs_files)
do
    source $file
done
