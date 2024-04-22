                                                      # Скрипт запускается и принимает два параметра
input_directory="$1"
output_directory="$2"

file_list=$(ls -p "$input_directory" | grep -v '/$') # Реализовано получение списка файлов, находящихся непосредственно во входной директории (не во вложенных в нее директориях)
directory_list=$(ls -d "$input_directory"/*/)        # Реализовано получение списка директорий, находящихся во входной директории

for file in $file_list; do
  if ! [ -e "$output_directory/$file" ]; then        # Решена проблема с файлами, имеющими одинаковое название
    cp "$input_directory/$file" "$output_directory"
  fi
done

all_files_list=()                                    #  Реализовано получение списка всех файлов, вложенных во входную директорию
for dir in $directory_list; do
  dir_files_list=$(ls -p "$dir" | grep -v '/$')
  for dir_file in $dir_files_list; do
    all_files_list+=("$dir/$dir_file")
  done
done

for file in "${all_files_list[@]}"; do
  if ! [ -e "$output_directory/$file" ]; then        # Решена проблема с файлами, имеющими одинаковое название
    cp "$file" "$output_directory"                   # Реализовано копирование всех файлов, вложенных во входную директорию в выходную директорию
  fi
done
