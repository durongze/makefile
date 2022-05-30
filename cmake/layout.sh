#!/bin/bash
set -e 

HdrKey=" gsi.h gsiObject.h "

function IsComment()
{
	local LineCtx=$1
	if [[ $LineCtx == //* ]];then
		return
	else
		echo -e "\033[32m LineCtx:$LineCtx \033[0m"
		return
	fi
}

function ReplaceHeader()
{
	local Hdr=$1
	local Dir=$2
	pushd $Dir
		SrcFiles=$(grep -l $Hdr *.*)
		for src in $SrcFiles 
		do
			#IsC=$(IsComment "$(grep $Hdr $src)")
			if [[ $(grep $Hdr $src) == //* ]];then
				echo -e "\033[31mIsComment $Hdr $src\033[0m"
				echo "sed -e 's!\/\/ #include \"$Hdr\"!#include \"$Hdr\"!g' -i $src"
				sed -e 's!\/\/ #include '\"$Hdr\"'!#include '\"$Hdr\"'!g' -i $src
			else
				echo -e "\033[32mNoComment $Hdr $src\033[0m"
				echo "sed -e 's/#include \"$Hdr\"/\/\/ #include \"$Hdr\"/g' -i $src"
				sed -e 's/#include '\"$Hdr\"'/\/\/ #include '\"$Hdr\"'/g' -i $src
			fi
		done
	popd
}

function ProcAllHeader()
{
	local Key=$1
	local Dir=$2
	for k in $Key
	do
		ReplaceHeader "$k" "$Dir"
	done
}

ProcAllHeader "$HdrKey" "src/db/db"
