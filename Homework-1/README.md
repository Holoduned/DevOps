# Задание
Написать bash скрипт который создаст для всех пользователей системы отдельную директорию в корневой директории
с именем пользователя и установит для нее права 755. При этом владельцем директории должен быть соответствующий пользователь.
Путь до корневого каталога создания директорий, должен определяться через ключ "-d"  или если ключ не задан то должен быть "диалог" для определения пути пользователем.
Лог должен писаться и в stdout и в файл.

# Запуск
1. Запуск: `.../Task1.sh`
2. Запуск с ключом: `-d` `.../Task1.sh -d .../path`

# Описание
1. log() для вывода логов в `stdout` и файл `Task1.log`.
2. process_arguments() обрабатывает аргументы командной строки, задающие корневую директорию
   и проводит соответствующие проверки.
3. get_user_list() получает список пользователей системы, исключая системные учетные записи.
4. create_user_directories() создает директории для каждого пользователя и устанавливает соответствующие права и владельца.