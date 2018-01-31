// Класс ПараметрКоманды, для доступа к установленному значению из вне
Перем ФлагВерсия Экспорт;
// Строковое представление версии приложения
Перем ВерсияПриложения Экспорт;

Перем Команда; 
Перем НаименованиеПриложения;
Перем ОписаниеПриложения;


// Процедура добавляет версию приложения,
// при вызове данной опции, показывается установленная версия и 
// завершается выполнение с кодом (0)
//
// Параметры:
//   Наименование - строка - имя опции, в строке допустимо задавать синоним через пробел, например "v version"
//   СтрокаВерсии - строка - версия, приложения
Процедура Версия(Наименование, СтрокаВерсии) Экспорт
	
	ВерсияПриложения = СтрокаВерсии;
	ФлагВерсия = Команда.Опция(Наименование, Ложь, "показать версию и выйти");
	
КонецПроцедуры

// Процедура позволяет переопределить стандартную строку использования приложения
//
// Параметры:
//   СтрокаСпек - строка - переопределенная строка использования приложения
Процедура УстановитьСпек(Знач СтрокаСпек) Экспорт

	Команда.Спек = СтрокаСпек;
	
КонецПроцедуры

// Возвращает основную команду приложения
//
// Возвращаемое значение:
//   Команда - класс КомандаПриложения
Функция ПолучитьКоманду() Экспорт

	Возврат Команда;
	
КонецФункции

// Основная процедура запуска приложения
//
// Параметры:
//   АргументыКоманднойСтрокиВходящие - Массив - Элементы <Строка>, необзательный,
//                                               Если, не передано считывает из АргументыКоманднойСтроки
Процедура Запустить(АргументыКоманднойСтрокиВходящие = Неопределено) Экспорт

	Аргументы = АргументыКоманднойСтроки;

	Если Не АргументыКоманднойСтрокиВходящие = Неопределено Тогда
		Аргументы = АргументыКоманднойСтрокиВходящие;
	КонецЕсли;
	
	Команда.НачалоЗапуска();
	Команда.Запуск(Аргументы);
	
КонецПроцедуры

// Функция добавляет команду приложение и возвращает экземпляр данной команды 
//
// Параметры:
//   ИмяКоманды - строка - в строке допустимо задавать синоним через пробел, например "exec e"
//   ОписаниеКоманды - строка - описание команды для справки
//   КлассРеализацииКоманды - объект - класс, объект реализующий функции выполнения команды.
//                                     Так же используется, для автоматической настройки опций и параметров команды
//
// Возвращаемое значение:
//   Команда - класс КомандаПриложения
Функция ДобавитьКоманду(ИмяКоманды, ОписаниеКоманды, КлассРеализацииКоманды) Экспорт
	
	Возврат Команда.ДобавитьПодкоманду(ИмяКоманды, ОписаниеКоманды, КлассРеализацииКоманды);
	
КонецФункции

// Процедура устанавливает процедуру "ВыполнитьКоманду" выполнения для приложения
//
// Параметры:
//   КлассРеализации - объект - класс, объект реализующий процедуру выполнения команды.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ВыполнитьКоманду"
//
Процедура УстановитьОсновноеДействие(КлассРеализации, ИмяПроцедуры = "ВыполнитьКоманду") Экспорт
	
	Команда.УстановитьДействиеВыполнения(КлассРеализации, ИмяПроцедуры);

КонецПроцедуры

// Процедура устанавливает процедуру "ПередВыполнениемКоманды" выполнения для приложения
// запускаемую перед выполнением "ВыполнитьКоманду"
//
// Параметры:
//   КлассРеализации - объект - класс, объект реализующий процедуру выполнения команды.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ПередВыполнениемКоманды"
//
Процедура УстановитьДействиеПередВыполнением(КлассРеализации, ИмяПроцедуры = "ПередВыполнениемКоманды") Экспорт
	
	Команда.УстановитьДействиеПередВыполнением(КлассРеализации, ИмяПроцедуры);

КонецПроцедуры

// Процедура устанавливает процедуру "ПослеВыполненияКоманды" выполнения для приложения
// запускаемую после выполнением "ВыполнитьКоманду"
//
// Параметры:
//   КлассРеализации - объект - класс, объект реализующий процедуру выполнения команды.
//   ИмяПроцедуры - строка - имя процедуры, отличное от стандартного "ПослеВыполненияКоманды"
//
Процедура УстановитьДействиеПослеВыполнения(КлассРеализации, ИмяПроцедуры = "ПослеВыполненияКоманды") Экспорт
	
	Команда.УстановитьДействиеПослеВыполнения(КлассРеализации, ИмяПроцедуры);

КонецПроцедуры

// Функция добавляет опцию приложения и возвращает экземпляр данной опции 
//
// Параметры:
//   Имя      - строка - имя опции, в строке допустимо задавать синоним через пробел, например "s some-opt"
//   Значение - строка - значение опции по умолчанию
//   Описание - объект - описание опции для справки.
//
// Возвращаемое значение:
//   Команда - класс ПараметрКоманды
// 
// Дополнительно смотри справку по классу ПараметрКоманды
Функция Опция(Имя, Значение = "", Описание = "") Экспорт
	
	Возврат Команда.Опция(Имя, Значение, Описание);

КонецФункции

// Функция добавляет аргумент приложения и возвращает экземпляр данной аргумента 
//
// Параметры:
//   Имя      - строка - имя аргумента, в строке допустимо использование только из БОЛЬШИХ латинских букв, например "ARG"
//   Значение - строка - значение аргумента по умолчанию
//   Описание - объект - описание аргумента для справки.
//
// Возвращаемое значение:
//   Команда - класс ПараметрКоманды
// 
// Дополнительно смотри справку по классу ПараметрКоманды
Функция Аргумент(Имя, Значение = "", Описание = "") Экспорт
	
	Возврат Команда.Аргумент(Имя, Значение, Описание);

КонецФункции

Процедура УстановитьФайлПараметров(Знач ПутьКФайлу) Экспорт
	
	ВнутреннийМенеджерПараметров.УстановитьФайлПараметров(ПутьКФайлу);

КонецПроцедуры

Процедура УстановитьМенеджерПараметров(НовыйМенеджерПараметров) Экспорт
	
	ВнутреннийМенеджерПараметров.УстановитьМенеджерПараметров(НовыйМенеджерПараметров);

КонецПроцедуры

Функция ПолучитьМенеджерПараметров() Экспорт

	Возврат ВнутреннийМенеджерПараметров.ПолучитьМенеджерПараметров();

КонецФункции

Процедура НастроитьМенеджерПараметров(ИмяФайлаПараметров, КаталогПоиска = "", РасширениеФайла = "") Экспорт
	
	ВнутреннийМенеджерПараметров.НастроитьМенеджерПараметров(ИмяФайлаПараметров, КаталогПоиска, РасширениеФайла);

КонецПроцедуры

Функция МенеджерПараметровНастроен() Экспорт
	ВнутреннийМенеджерПараметров.Настроен();
КонецФункции

// Предопределенная процедура выполнения приложения, если не задана процедура в классе. 
// Выводит справку, по работе с приложением и завершает работу с кодом "1"
// Переопределяется, процедурой "УстановитьОсновноеДействие"
//
// Параметры:
//   Команда  - класс КомандаПриложения - инстанс класс, для доступа к опция и аргументам выполняемой команды
//
Процедура ВыполнитьКоманду(Знач Команда) Экспорт

	Сообщить("Не корректное использование. Команда ""ВыполнитьКоманду"" не найдена"+ Символы.ПС);
	Команда.ВывестиСправку();
	ЗавершитьРаботу(1);

КонецПроцедуры

Процедура ПриСозданииОбъекта(Знач Наименование, Знач Описание, Знач КлассРеализацииОсновныйКоманды = Неопределено)

	НаименованиеПриложения = Наименование;
	ОписаниеПриложения = Описание;

	Если КлассРеализацииОсновныйКоманды = Неопределено Тогда
		КлассРеализацииОсновныйКоманды = ЭтотОбъект;
	КонецЕсли;
	
	Команда = Новый КомандаПриложения(Наименование, Описание, КлассРеализацииОсновныйКоманды, ЭтотОбъект);

КонецПроцедуры