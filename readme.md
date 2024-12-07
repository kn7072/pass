### Подготовительные дейстивия для работы с pass:

1. вызвать команду `pass init` (будет создан каталог ~/.password-store)
2. перейти в каталог `cd ~/.password-store`
3. склонировать репозиторий `git clone git@github.com:kn7072/pass.git ./`
    - расшифровать файл с ключами, лежащими в **kp.tar.gz.gpg**. Чтобы произвести расшифровку и распаковку файла необходимо подготовить пароль для расшифровки. 
        
        Для этого со строкой Q8RUVnGwMaSqUZGj1uDNivVbLgRm7sQiFsPWXh5st4aapia5ZzWtap4LUuujMmu3285zVb необходимо выполнить ряд действий:

        1. выволнить обычную процедуру как и для всех паролей
        2. после каждой цыфры, входящей в номер дачи, добавить имя кошки
        3. выполнить команду gpg -d -o kp.tar.gz kp.tar.gz.gpg и вставить подготовленный пароль
    - Имрортировать ключи, выполнив команды:
        1. импортируем публичный ключ `gpg --import public.key`
        2. импортируем приватный ключ `gpg --import private.key`
        3. если при использовании ключей возникает ошибка - There is no assurance this key belongs to the named user
            необходимо выполнить ряд комамнд для определения степени доверия к ключу
            a. определяем идентификатор ключа коммандой `gpg -k` и получаем запись вида
            ```bash
            -------------------------------
            pub   rsa4096 2024-09-17 [SC]
                  546CD7A2DCD9CBC5F8D5CD36A7D77778786F56AB
            uid           [ xxxx ] xxxx (xxxx) <xxxxx.ru>
            sub   rsa4096 2024-09-17 [E]

            ```
            b. вводим комманды, использую идентификатор ключа из предыдущего пункта
                ```bash
                gpg --edit-key 546CD7A2DCD9CBC5F8D5CD36A7D77778786F56AB
                gpg> trust
                
                You will be asked to select the trust level from the following:

                1 = I don't know or won't say
                2 = I do NOT trust
                3 = I trust marginally
                4 = I trust fully
                5 = I trust ultimately
                m = back to the main menu

                I selected 5 since I created the key so of course I trust it ultimately
                Your decision? 5
                Do you really want to set this key to ultimate trust? (y/N) y
                gpg> quit
                ```
        
4. расшифровать базу pass, запустив скрипт  `./dectipt.sh`
5. зашифровываем базу обратно, запустив скрипт `./encript.sh параметр_фингерпринт_вашего_ключа`

#### Мини справка по tar
- -c Создание нового архивного файла.
- -f file Вывести результат в файл (или на устройство) file
- -z Перенаправить вывод в команду gzip
- -v Выводить подробную информацию процесс
