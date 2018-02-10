#!/bin/bash
#Program:
#       創建/清空 vscode cmake 需要的 目錄
#History:
#       2018-02-07 king first release
#Email:
#       zuiwuchang@gmail.com
 
# 獲取 項目路徑作爲 項目 名稱
appName=`pwd`
appName=${appName##*/}
echo create project [ $appName ]
 
# 定義的 各種 輔助 函數
MkDir(){
	mkdir -p "$1"
	if [ "$?" != 0 ] ;then
		exit 1
	fi
}
MkOrClear(){
	if test -d "$1";then
		declare path="$1"
		path+="/*"
		rm "$path" -rf
		if [ "$?" != 0 ] ;then
			exit 1
		fi
	else
		MkDir $1
	fi
}
NewFile(){
	echo "$2" > "$1"
	if [ "$?" != 0 ] ;then
		exit 1
	fi
}
WriteFile(){
	echo "$2" >> "$1"
	if [ "$?" != 0 ] ;then
		exit 1
	fi
}
 
# 創建 bin 目錄
MkDir build/bin
 
# 創建/清空 debug release 目錄
MkOrClear build/debug
MkOrClear build/release
 
 
# 創建 cmake 檔案
fileName=CMakeLists.txt
if ! test -f $fileName ;then
	NewFile $fileName	'cmake_minimum_required(VERSION 3.0)'
	WriteFile $fileName	"project($appName)"
	WriteFile $fileName	'add_compile_options(-std=gnu++17)'
	WriteFile $fileName	"add_executable($appName main.cpp)"
fi
 
 
#創建 vscode 配置目錄
MkDir .vscode
 
# 創建 vscode tasks.json 檔案
fileName=.vscode/tasks.json
if ! test -f $fileName ;then
	NewFile $fileName	'{'
	WriteFile $fileName	'	"version": "2.0.0",'
	WriteFile $fileName	'	"type": "shell",'
	WriteFile $fileName	'	"tasks": ['
	WriteFile $fileName	'		/***    設置 cmake 任務    ***/'
	WriteFile $fileName	'		{'
	WriteFile $fileName	'			"label": "cmake debug",'
	WriteFile $fileName	'			"command": "cmake -DCMAKE_BUILD_TYPE=Debug ${workspaceRoot}",'
	WriteFile $fileName	'			"problemMatcher":"$gcc",'
	WriteFile $fileName	'			"group": {'
	WriteFile $fileName	'				"kind": "build",'
	WriteFile $fileName	'				"isDefault": true'
	WriteFile $fileName	'			},'
	WriteFile $fileName	'			"options": { "cwd": "${workspaceRoot}/build/debug" }'
	WriteFile $fileName	'		},'
	WriteFile $fileName	'		{'
	WriteFile $fileName	'			"label": "cmake release",'
	WriteFile $fileName	'			"command": "cmake -DCMAKE_BUILD_TYPE=Release ${workspaceRoot}",'
	WriteFile $fileName	'			"problemMatcher":"$gcc",'
	WriteFile $fileName	'			"group": {'
	WriteFile $fileName	'				"kind": "build",'
	WriteFile $fileName	'				"isDefault": true'
	WriteFile $fileName	'			},'
	WriteFile $fileName	'			"options": { "cwd": "${workspaceRoot}/build/release" }'
	WriteFile $fileName	'		},'
	WriteFile $fileName	'		/***    設置 make 任務    ***/'
	WriteFile $fileName	'		{'
	WriteFile $fileName	'			"label": "make debug",'
	WriteFile $fileName	'			"command": "make",'
	WriteFile $fileName	'			"problemMatcher":"$gcc",'
	WriteFile $fileName	'			"group": {'
	WriteFile $fileName	'				"kind": "build",'
	WriteFile $fileName	'				"isDefault": true'
	WriteFile $fileName	'			},'
	WriteFile $fileName	'			"options": { "cwd": "${workspaceRoot}/build/debug" }'
	WriteFile $fileName	'		},'
	WriteFile $fileName	'		{'
	WriteFile $fileName	'			"label": "make release",'
	WriteFile $fileName	'			"command": "make",'
	WriteFile $fileName	'			"problemMatcher":"$gcc",'
	WriteFile $fileName	'			"group": {'
	WriteFile $fileName	'				"kind": "build",'
	WriteFile $fileName	'				"isDefault": true'
	WriteFile $fileName	'			},'
	WriteFile $fileName	'			"options": { "cwd": "${workspaceRoot}/build/release" }'
	WriteFile $fileName	'		},'
	WriteFile $fileName	'		/***    設置 run 任務    ***/'
	WriteFile $fileName	'		{'
	WriteFile $fileName	'			"label": "run debug",'
	WriteFile $fileName	'			"command": "${workspaceRoot}/build/debug/'"${appName}"'",'
	WriteFile $fileName	'			"windows": {'
	WriteFile $fileName	'				"command": "${workspaceRoot}/build/debug/'"${appName}"'.exe",'
	WriteFile $fileName	'			},'
	WriteFile $fileName	'			"problemMatcher":"$gcc",'
	WriteFile $fileName	'			"options": { "cwd": "${workspaceRoot}/build/bin" }'
	WriteFile $fileName	'		},'
	WriteFile $fileName	'		{'
	WriteFile $fileName	'			"label": "run release",'
	WriteFile $fileName	'			"command": "${workspaceRoot}/build/release/'"${appName}"'",'
	WriteFile $fileName	'			"windows": {'
	WriteFile $fileName	'				"command": "${workspaceRoot}/build/release/'"${appName}"'.exe",'
	WriteFile $fileName	'			},'
	WriteFile $fileName	'			"problemMatcher":"$gcc",'
	WriteFile $fileName	'			"options": { "cwd": "${workspaceRoot}/build/bin" }'
	WriteFile $fileName	'		},'
	WriteFile $fileName	'	]'
	WriteFile $fileName	'}'
fi
# 創建 vscode launch.json 檔案
fileName=.vscode/launch.json
if ! test -f $fileName ;then
	NewFile $fileName	'{'
	WriteFile $fileName	'	"version": "0.2.0",'
	WriteFile $fileName	'	"configurations": ['
	WriteFile $fileName	'		{'
	WriteFile $fileName	'			"name": "(gdb) Launch",'
	WriteFile $fileName	'			"type": "cppdbg",'
	WriteFile $fileName	'			"request": "launch",'
	WriteFile $fileName	'			"program": "${workspaceRoot}/build/debug/'"$appName"'",'
	WriteFile $fileName	'			"windows": {'
	WriteFile $fileName	'				"program": "${workspaceRoot}/build/debug/'"$appName"'.exe",'
	WriteFile $fileName	'			},'
	WriteFile $fileName	'			"args": [],'
	WriteFile $fileName	'			"stopAtEntry": false,'
	WriteFile $fileName	'			"cwd": "${workspaceRoot}/build/bin",'
	WriteFile $fileName	'			"environment": [],'
	WriteFile $fileName	'			"externalConsole": true,'
	WriteFile $fileName	'			"MIMode": "gdb",'
	WriteFile $fileName	'			"setupCommands": ['
	WriteFile $fileName	'				{'
	WriteFile $fileName	'					"description": "Enable pretty-printing for gdb",'
	WriteFile $fileName	'					"text": "-enable-pretty-printing",'
	WriteFile $fileName	'					"ignoreFailures": true'
	WriteFile $fileName	'				}'
	WriteFile $fileName	'			]'
	WriteFile $fileName	'		}'
	WriteFile $fileName	'	]'
	WriteFile $fileName	'}'
fi
# 創建 vscode c_cpp_properties.json
fileName=.vscode/c_cpp_properties.json
if ! test -f $fileName ;then
	NewFile $fileName	'{'
	WriteFile $fileName	'	"configurations": ['
	WriteFile $fileName	'		{'
	WriteFile $fileName	'			"name": "Linux",'
	WriteFile $fileName	'			"intelliSenseMode": "clang-x64",'
	WriteFile $fileName	'			"includePath": ['
	WriteFile $fileName	'				"/usr/include/c++/5",'
	WriteFile $fileName	'				"/usr/include/x86_64-linux-gnu/c++/5",'
	WriteFile $fileName	'				"/usr/include/c++/5/backward",'
	WriteFile $fileName	'				"/usr/lib/gcc/x86_64-linux-gnu/5/include",'
	WriteFile $fileName	'				"/usr/local/include",'
	WriteFile $fileName	'				"/usr/lib/gcc/x86_64-linux-gnu/5/include-fixed",'
	WriteFile $fileName	'				"/usr/include/x86_64-linux-gnu",'
	WriteFile $fileName	'				"/usr/include",'
	WriteFile $fileName	'				"${workspaceRoot}"'
	WriteFile $fileName	'			]'
	WriteFile $fileName	'		}'
	WriteFile $fileName	'	]'
	WriteFile $fileName	'}'
fi
 
# 創建 vscode settings.json
fileName=.vscode/settings.json
if ! test -f $fileName ;then
	NewFile $fileName	'{'
	WriteFile $fileName	'	"files.exclude": {'
	WriteFile $fileName	'		"**/init-cpp-cmake.sh": true,'
	WriteFile $fileName	'		"**/build/release": true,'
	WriteFile $fileName	'		"**/build/release": true,'
	WriteFile $fileName	'	}'
	WriteFile $fileName	'}'
fi