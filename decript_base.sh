# файл расшифровывает все файлы базы - по пути dir_to_decript_base
# и переносит файлы сохраняя структуру каталогов в каталог - dir_to_decript_base

dir_to_base="/home/stepan/.password-store"
dir_to_decript_base="/home/stepan/temp/pass/test_base"

for file_i in $(find . -type f -name "*.gpg"); do
  echo "origin path ${file_i}"
  file_name_txt=${file_i/%.gpg/.txt}
  echo "file_name_txt ${file_name_txt}"

  realpath_file=$(realpath ${file_name_txt})
  echo "realpath file ${realpath_file}"
  # путь к файлу внутри dir_to_base, отрезаем левую часть пути чтобы позже заменить ее на новый путь
  inner_path_to_file=${realpath_file##${dir_to_base}}

  echo "inner path ${inner_path_to_file}"
  # создаем новый файл, но сначала проверим сущестует ли дерево каталогов для резервной копии базы
  # переменная temp_path_file нужна только чтобы получить новый путь каталогов - для утилиты dirname и
  # далее для создания дерева каталогов через вызов mkdir -p "$(dirname "$temp_path_file")"
  temp_path_file="${dir_to_decript_base}""${inner_path_to_file}"
  echo "new path to file ${temp_path_file}"

  dir_name_for_file="$(dirname "$temp_path_file")"
  echo "path to decript file $dir_name_for_file"
  if [[ ! -d $dir_name_for_file ]]; then
    # если каталога(вложенных каталогов) не сущестует - создаем дерево -
    # со всеми родительскими каталогами
    mkdir -p ${dir_name_for_file}
    # echo "not exist $dir_name_for_file"
  fi
  gpg --decrypt --output ${temp_path_file} ${file_i}
  echo " "

done
