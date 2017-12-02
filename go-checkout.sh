#!/bin/bash
#Program:
#       auto golib git checkout version
#History:
#       2017-12-2 king first release
#Email:
#       zuiwuchang@gmail.com

# go get base directory 
IFS=: BASE=($GOPATH)
BASE=${BASE[0]}/src

function GoVersion(){
	echo $1 $2
	path="$BASE"/$1

	if [ ! -d $path ];then
		echo directory not found : $path 
		exit 1
	fi
	path=${path}
	cd $path
	if [ $? -ne 0 ];then
		exit 1
	fi
	git checkout $2
	if [ $? -ne 0 ];then
		exit 1
	fi
}
function GoVersions(){
	name=$1
	echo "***	begin : $name	***"

	IFS= args=($*)
	for ((i=1;i<$#;i=i+2))
	do
		path=${args[$i]}
		tag=${args[i+1]}
		GoVersion $path $tag
		echo ""
	done

	echo "***	success : $name	***"
	echo ""
	echo ""
}

GoVersions revel	\
	github.com/revel/cmd		v0.17	\
	github.com/revel/config	v0.17	\
	github.com/revel/modules	v0.17	\
	github.com/revel/revel		v0.17.1	\

echo "***	all success	***"