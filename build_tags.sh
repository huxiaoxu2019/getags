#!/bin/bash

# Generate the tags file in the current sub-dirs.
#
# @author genialx <admin@ihuxu.com>

#
# DECLARE
#

tagsFilePathBuffer=""

function generateTags() {
    for file in `ls $1`
    do
        if [ -d $1"/"$file ]
        then
            cd $1"/"$file
            tagFilePath=`pwd`
            echo -e "\033[34mGenerating the tags file in $tagFilePath/tags...\033[0m"
            #ctagsResult=""
            ctagsResult=`ctags --languages=PHP -R --fields=+aimS  * $tagFilePath`
            if [[ $ctagsResult = "" ]]
            then
                echo -e "\033[32mThe tags file has been generated.\033[0m"
                tagsFilePathBuffer=$tagsFilePathBuffer"\nset tags+="$tagFilePath"/tags"
            else 
                echo -e "\033[31mThe tags file has not been generated.\033[0m"
            fi
            cd ..
        fi
    done
    echo -e "\033[33mThe tags file path configure are:$tagsFilePathBuffer\nPlease add these to the ~/.vimrc manually.\033[0m"
}

#
# RUN
#

generateTags $1 
