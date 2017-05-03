#!/bin/bash
#finalversion
#1
#==============================================================================

IFS=$'\n'

check_dir=`pwd`
declare -a a=(`ls`)
declare -a sorted_arr=()

var=0

echo "=== print file information ==="
echo "current directory : $check_dir"

while [ -n "${a[$var]}" ]
do
	var=`expr $var + 1`
done

echo "the number of elements : $var"






#============================file sorting (directory << normal file << special file)===========================================

sort_arr(){

declare -a arr=($@)

var=0

while [ -n "${arr[$var]}" ]
do
	var=`expr $var + 1`
done

temp=""

for((j = 0; j < var; j++))
do
	if [ "`stat -c %F ${arr[$j]}`" != "디렉토리" ]
	then
		for((k = `expr $j + 1`; k < var; k++))
			do
		 		if [ "`stat -c %F ${arr[$k]}`" = "디렉토리" ]
				then
					temp=${arr[$j]}
					arr[$j]=${arr[$k]}
					arr[$k]=$temp
				fi
						
			done
	fi
done

lastdir=0

while [ "`stat -c %F ${arr[$lastdir]}`" = "디렉토리" ]
do
	lastdir=`expr $lastdir + 1`
done

for((m=lastdir; m < var; m++))
do
	if [ "`stat -c %F ${arr[$m]}`" != "디렉토리" ] && [ "`stat -c %F ${arr[$m]}`" != "일반 파일" ] && [ "`stat -c %F ${arr[$m]}`" != "일반 빈 파일" ]
	then
		for((n = `expr $m + 1`; n < var; n++))
		do
			if [ "`stat -c %F ${arr[$n]}`" = "일반 파일" ] || [ "`stat -c %F ${arr[$n]}`" = "일반 빈 파일" ]
			then
				temp=${arr[$m]}
				arr[$m]=${arr[$n]}
				arr[$n]=$temp
			fi
		done
	fi
done


lastnorfile=0

for((index=lastdir; index < var; index++))
do
	if [ "`stat -c %F ${arr[$index]}`" = "일반 파일" ] || [ "`stat -c %F ${arr[$index]}`" = "일반 빈 파일" ]
	then
		lastnorfile=`expr $lastnorfile + 1`
	fi	
done

lastnorfile=`expr $lastnorfile + $lastdir`

declare -a b=()

for((index_b = 0; index_b < lastdir; index_b++))
do
	b[$index_b]=${arr[$index_b]}
done

b=( $(for el_b in "${b[@]}"
	do
		echo $el_b
	done | sort
))

declare -a c=()
index_cc=0

for((index_c = lastdir; index_c < lastnorfile; index_c++))
do
	c[$index_cc]=${arr[$index_c]}
	index_cc=`expr $index_cc + 1`
done

c=( $(for el_c in "${c[@]}"
	do
		echo $el_c
	done | sort
))

declare -a d=()
index_dd=0

for((index_d = lastnorfile; index_d < var; index_d++))
do
	d[$index_dd]=${arr[$index_d]}
	index_dd=`expr $index_dd + 1`
done

d=( $(for el_d in "${d[@]}"
	do
		echo $el_d
	done | sort
))
#결합하는 부분

index_a=0

for((index_BtoA = 0; index_BtoA < index_b; index_BtoA++))
do
	arr[$index_a]=${b[$index_BtoA]}
	index_a=`expr $index_a + 1`
done

for((index_CtoA = 0; index_CtoA < index_cc; index_CtoA++))
do
	arr[$index_a]=${c[$index_CtoA]}
	index_a=`expr $index_a + 1`
done

for((index_DtoA = 0; index_DtoA < index_dd; index_DtoA++))
do
	arr[$index_a]=${d[$index_DtoA]}
	index_a=`expr $index_a + 1`
done

sorted_arr=()

for((index_sorted = 0; index_sorted < var; index_sorted++))
do
	sorted_arr[$index_sorted]=${arr[$index_sorted]}
done

}
#==============================================================================

sort_indir(){

declare -a arr=($@)

var=0

while [ -n "${arr[$var]}" ]
do
	var=`expr $var + 1`
done

temp=""

for((j = 0; j < var; j++))
do
	if [ "`stat -c %F ${a[$i]}/${arr[$j]}`" != "디렉토리" ]
	then
		for((k = `expr $j + 1`; k < var; k++))
			do
		 		if [ "`stat -c %F ${a[$i]}/${arr[$k]}`" = "디렉토리" ]
				then
					temp=${arr[$j]}
					arr[$j]=${arr[$k]}
					arr[$k]=$temp
				fi
						
			done
	fi
done

lastdir=0

while [ "`stat -c %F ${a[$i]}/${arr[$lastdir]}`" = "디렉토리" ]
do
	lastdir=`expr $lastdir + 1`
done

for((m=lastdir; m < var; m++))
do
	if [ "`stat -c %F ${a[$i]}/${arr[$m]}`" != "디렉토리" ] && [ "`stat -c %F ${a[$i]}/${arr[$m]}`" != "일반 파일" ] && [ "`stat -c %F ${a[$i]}/${arr[$m]}`" != "일반 빈 파일" ]
	then
		for((n = `expr $m + 1`; n < var; n++))
		do
			if [ "`stat -c %F ${a[$i]}/${arr[$n]}`" = "일반 파일" ] || [ "`stat -c %F ${a[$i]}/${arr[$n]}`" = "일반 빈 파일" ]
			then
				temp=${arr[$m]}
				arr[$m]=${arr[$n]}
				arr[$n]=$temp
			fi
		done
	fi
done


lastnorfile=0

for((index=lastdir; index < var; index++))
do
	if [ "`stat -c %F ${a[$i]}/${arr[$index]}`" = "일반 파일" ] || [ "`stat -c %F ${a[$i]}/${arr[$index]}`" = "일반 빈 파일" ]
	then
		lastnorfile=`expr $lastnorfile + 1`
	fi	
done

lastnorfile=`expr $lastnorfile + $lastdir`

declare -a b=()

for((index_b = 0; index_b < lastdir; index_b++))
do
	b[$index_b]=${arr[$index_b]}
done

b=( $(for el_b in "${b[@]}"
	do
		echo $el_b
	done | sort
))

declare -a c=()
index_cc=0

for((index_c = lastdir; index_c < lastnorfile; index_c++))
do
	c[$index_cc]=${arr[$index_c]}
	index_cc=`expr $index_cc + 1`
done

c=( $(for el_c in "${c[@]}"
	do
		echo $el_c
	done | sort
))

declare -a d=()
index_dd=0

for((index_d = lastnorfile; index_d < var; index_d++))
do
	d[$index_dd]=${arr[$index_d]}
	index_dd=`expr $index_dd + 1`
done

d=( $(for el_d in "${d[@]}"
	do
		echo $el_d
	done | sort
))
#결합하는 부분

index_a=0

for((index_BtoA = 0; index_BtoA < index_b; index_BtoA++))
do
	arr[$index_a]=${b[$index_BtoA]}
	index_a=`expr $index_a + 1`
done

for((index_CtoA = 0; index_CtoA < index_cc; index_CtoA++))
do
	arr[$index_a]=${c[$index_CtoA]}
	index_a=`expr $index_a + 1`
done

for((index_DtoA = 0; index_DtoA < index_dd; index_DtoA++))
do
	arr[$index_a]=${d[$index_DtoA]}
	index_a=`expr $index_a + 1`
done

sorted_arr=()

for((index_sorted = 0; index_sorted < var; index_sorted++))
do
	sorted_arr[$index_sorted]=${arr[$index_sorted]}
done

}

#=========================================================================
sort_arr ${a[@]}

for((index_a = 0; index_a < var; index_a++))
do
	a[$index_a]=${sorted_arr[$index_a]}
done
#===============================================file print==========================================================================
for((i = 0; i < ${#a[@]}; i++))
do
	#파일번호
		echo "[`expr $i + 1`] ${a[$i]}"
	echo "====================INFORMATION======================="
	#파일 타입
		if [ "`stat -c %F ${a[$i]}`" = "디렉토리" ]
		then
			echo [34m "file type : 디 렉 토 리"
		elif [ "`stat -c %F ${a[$i]}`" = "일반 파일" ]
		then
			echo [0m "file type : 일 반 파 일"
		elif [ "`stat -c %F ${a[$i]}`" = "일반 빈 파일" ]
		then
			echo [0m "file type : 일반 빈 파일"
		else
			echo [32m "file type : 특 수 파 일"
		fi
	
	#파일크기
		echo [0m "file size : `stat -c %s ${a[$i]}`"
	#마지막 수정 시간
		echo [0m "last change time : `stat -c %y ${a[$i]}`"
	#권한
		echo [0m "permission : `stat -c %a ${a[$i]}`"
	#절대경로
		echo [0m "absolute path : `pwd`/${a[$i]}"
	#상대경로
		echo [0m "relative path : ./${a[$i]}"
	echo [0m"======================================================"
	echo " "
	if [ "`stat -c %F ${a[$i]}`" = "디렉토리" ]
	then	
		
		indir=(`ls ${a[$i]}`)
		if [ "${#indir[@]}" -gt 0 ]
		then
			sort_indir ${indir[@]}

			for((index_sort_indir =0; index_sort_indir < ${#indir[@]}; index_sort_indir++))
			do
				indir[$index_sort_indir]=${sorted_arr[$index_sort_indir]}
			done

			for((index_indir = 0; index_indir < ${#indir[@]}; index_indir++))
			do
	#파일번호
		echo -e "\t[`expr $index_indir + 1`] ${indir[$index_indir]}"
	echo -e "\t====================INFORMATION======================="
	#파일 타입
		if [ "`stat -c %F ${a[$i]}/${indir[$index_indir]}`" = "디렉토리" ]
		then
			echo -e [34m "\tfile type : 디 렉 토 리"
		elif [ "`stat -c %F ${a[$i]}/${indir[$index_indir]}`" = "일반 파일" ]
		then
			echo -e [0m "\tfile type : 일 반 파 일"
		elif [ "`stat -c %F ${a[$i]}/${indir[$index_indir]}`" = "일반 빈 파일" ]
		then
			echo -e [0m "\tfile type : 일반 빈 파일"
		else
			echo -e [32m "\tfile type : 특 수 파 일"
		fi
	#파일크기
		echo -e [0m "\tfile size : `stat -c %s ${a[$i]}/${indir[$index_indir]}`"
	#마지막 수정 시간
		echo -e [0m "\tlast change time : `stat -c %y ${a[$i]}/${indir[$index_indir]}`"
	#권한
		echo -e [0m "\tpermission : `stat -c %a ${a[$i]}/${indir[$index_indir]}`"
	#절대경로
		echo -e [0m "\tabsolute path : `pwd`/${a[$i]}/${indir[$index_indir]}"
	#상대경로
		echo -e [0m "\trelative path : ./${a[$i]}/${indir[$index_indir]}"
	echo -e [0m"\t======================================================"
	echo " "
	
			done
		fi
	fi	
done



