#!/bin/bash
#Program:
#       auto down some go lib
#History:
#       2017-12-1 king first release
#Email:
#       zuiwuchang@gmail.com

function GoGet(){
	echo "go get -u -d $1"
	go get -u -d $1
	if [ $? -ne 0 ];then
		exit 1
	fi
}
function GoGets(){
	name=$1
	echo "***	begin : $name	***"
	declare -i i
	i=0
	for v in $@
	do
		if [ $i -ne 0 ] ; then
			GoGet $v
			echo ""
		fi
		i=i+1
	done
	echo "***	success : $name	***"
	echo ""
	echo ""
}

GoGets golang.org/x	\
	golang.org/x/blog/...	\
	golang.org/x/crypto/...	\
	golang.org/x/exp/...	\
	golang.org/x/image/...	\
	golang.org/x/mobile/...	\
	golang.org/x/net/...	\
	golang.org/x/sys/...	\
	golang.org/x/talks/...	\
	golang.org/x/text	\
	golang.org/x/tools/...	\

GoGets Protocol-Buffers	\
	github.com/golang/protobuf/protoc-gen-go	\

GoGets vscode	\
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

GoGets revel	\
	github.com/golang/dep/cmd/dep	\
	github.com/revel/cmd/revel@v0.17.1	\

GoGets SQL \
	github.com/go-xorm/xorm	\
	github.com/mattn/go-sqlite3	\
	github.com/go-sql-driver/mysql	\
	github.com/lib/pq	\
	github.com/denisenkom/go-mssqldb	\

GoGets Scripts	\
	github.com/yuin/gopher-lua	\
	gopkg.in/olebedev/go-duktape.v3 \

GoGets Other	\
	github.com/chai2010/gettext-go/gettext	\
	github.com/axgle/mahonia	\
	github.com/boombuler/barcode	\
	github.com/tealeg/xlsx	\
	github.com/satori/go.uuid	\

echo "***	all success	***"
