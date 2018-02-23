#!/bin/bash
#Program:
#       auto go install go lib
#History:
#       2017-12-2 king first release
#Email:
#       zuiwuchang@gmail.com

function GoInstall(){
	echo "go install $1"
	go install $1
	if [ $? -ne 0 ];then
		exit 1
	fi
}
function GoInstalls(){
	name=$1
	echo "***	begin : $name	***"
	declare -i i
	i=0
	for v in $@
	do
		if [ $i -ne 0 ] ; then
			GoInstall $v
			echo ""
		fi
		i=i+1
	done
	echo "***	success : $name	***"
	echo ""
	echo ""
}
GoInstalls Protocol-Buffers	\
	github.com/golang/protobuf/protoc-gen-go	\

GoInstalls grpc	\
	google.golang.org/grpc	\


GoInstalls revel	\
	github.com/revel/cmd/revel	\

GoInstalls vscode	\
	github.com/nsf/gocode	\
	github.com/uudashr/gopkgs/cmd/gopkgs	\
	github.com/ramya-rao-a/go-outline	\
	github.com/acroca/go-symbols	\
	golang.org/x/tools/cmd/guru	\
	golang.org/x/tools/cmd/gorename	\
	github.com/fatih/gomodifytags	\
	github.com/haya14busa/goplay/cmd/goplay	\
	github.com/josharian/impl	\
	github.com/rogpeppe/godef	\
	github.com/golang/lint/golint	\
	github.com/cweill/gotests/...	\
	github.com/derekparker/delve/cmd/dlv	\

GoInstalls qt	\
	github.com/therecipe/qt/cmd/...	\

echo "***	all success	***"
