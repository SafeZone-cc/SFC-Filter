# SFC Filter

## Что делает

Фильтрует строки лога SFC, убирая успешные операции проверки.
Оставляет только информацию о повреждениях или успешно исправленных записях.
Отчет получается в виде файла **CBS_Clear.log** (основной),
а также файла **CBS_Permissions.log** (ошибки, связанные с привилегиями)

## Использование

1) Для стороннего лога:
- перетянуть лог на скрипт.
или
- перетянуть папку с логом на скрипт.
или
- правой кнопкой мыши по логу, Отправить, "SFC - фильтрация лога" (если Вы использовали скрипт установки).

2) Для своей системы:
- просто запустить скрипт.

Отчет будет открыт в программе по-умолчанию.
___________________
Для создания отчета Вы можете вопрользоваться скриптом [Проверка целостности системных файлов утилитой SFC от Koza Nozdri](http://safezone.cc/resources/proverka-celostnosti-sistemnyx-fajlov-utilitoj-sfc.55/)