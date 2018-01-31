// Имя параметра команды
// первая строка из массива строк, переданных при создании
Перем Имя экспорт; // Строка

// Описание параметра команды
// Используется при выводе справки
Перем Описание Экспорт; // Строка

// Подробное описание параметра команды
// Используется при выводе справки (запланировано)
Перем ПодробноеОписаниеПараметра Экспорт; // Строка

// Содержит имя переменной окружения, откуда получать значение
// допустимо использование нескольких переменных окружения через пробел
// Используется при выводе справки
Перем ПеременнаяОкружения Экспорт; // Строка

// Содержит синонимов параметра команды
Перем Синонимы Экспорт; // Массив

// Содержит нормализованные наименования параметров
// для опций ("f force"):
//     "-f", "--force"
// для аргументов ("ARG"):
//     "ARG"
Перем НаименованияПараметров Экспорт; // Массив

// Определяет необходимость показа значения по умолчанию параметра в справке.
// Значение "Истина" скрывает в справке, по умолчанию "Ложь"
Перем СкрытьЗначение Экспорт; // булево

// Содержит признак истина, если значение получено из переменной окружения
Перем УстановленаИзПеременнойОкружения Экспорт; // булево

// Содержит признак истина, если значение установлено пользователем в строке использования
Перем УстановленаПользователем Экспорт; // булево

// Признак обязательности установки значения пользователем в строке использования
// при "истина", если значение не передано явно, будет вызывать исключение
Перем ТребоватьУстановкиПользователем Экспорт;

// Содержит значение параметра
// В том числе установленное значение по умолчанию
Перем Значение Экспорт; // Произвольный

// Содержит тип параметра
Перем ТипОпции Экспорт; // Тип

Перем ПутьКФайлу; // ПутьКФайлу 
Перем МестоВФайле; // Место в файле формата "section.force"

Перем ТипЭлементаОпции; // Тип, для элементов, если ТипОпции = Тип("Массив")
Перем НеОбязательныйПараметр; // Булево
Перем ТипПараметра; // Опция и аргумент
Перем ТипЗначенияПараметра; // Произвольный класс реализуемые несколько обязательных методов
Перем РазделительМассива; // Строка
Перем ОшибкиУстановкиЗначения; // Соответствия Ключ = значение устанавливаемое, Значение = Строка ошибки

Процедура ПриСозданииОбъекта(ВходящийТипПараметра, ПолноеИмя, ЗначениеПоУмолчанию = "", ОписаниеПараметра = "", ПеременнаяОкруженияПараметра = "")

	Синонимы = СтрРазделить(ПолноеИмя, " ", Ложь);
	Имя = Синонимы[0];
	Значение = ЗначениеПоУмолчанию;
	Описание = ОписаниеПараметра;
	ПеременнаяОкружения = ПеременнаяОкруженияПараметра;
	СкрытьЗначение = Ложь;
	ТипОпции = ТипЗнч(ЗначениеПоУмолчанию);
	ТипЭлементаОпции = ТипОпции;

	Если ТипОпции = Тип("Булево")
		ИЛИ НЕ ВходящийТипПараметра = "опция"Тогда
		СкрытьЗначение = Истина;
	КонецЕсли;

	ТипЗначенияПоУмолчанию = ТипЗнч(ЗначениеПоУмолчанию);
	ВстроенныеТипы = ВстроенныеТипЗначенийПараметров();

	ОпределенныйТип = ВстроенныеТипы[Строка(ТипЗначенияПоУмолчанию)];

	ТипЗначенияПараметра = ?(ОпределенныйТип = Неопределено, Новый ТипСтрока, Новый (ОпределенныйТип));

	УстановленаПользователем = Ложь;
	УстановленаИзПеременнойОкружения = Ложь;

	НеОбязательныйПараметр = Истина;

	Если ВходящийТипПараметра = "аргумент" Тогда
		НеОбязательныйПараметр = Ложь;
	КонецЕсли;

	ТипПараметра = ВходящийТипПараметра;

	РазделительМассива = Неопределено;
	ПодробноеОписаниеПараметра = "";
	ПодготовитьНаименованияПараметров();
	
	ОшибкиУстановкиЗначения = Новый Соответствие;

КонецПроцедуры

// Возвращает истина, если тип параметра Массив
//
// Возвращаемое значение:
//   булево
Функция ЭтоМассив() Экспорт

	Возврат ТипОпции = Тип("Массив");

КонецФункции

// Процедура очищает, Значение параметра, для типа Массив
//
Процедура Очистить() Экспорт

	Если Не ЭтоМассив() Тогда
		Возврат;
	КонецЕсли;

	Значение.Очистить();

КонецПроцедуры

// Возвращает строковое представление значения параметра
//
// Возвращаемое значение:
//   строка
Функция ЗначениеВСтроку() Экспорт

	Возврат ТипЗначенияПараметра.ВСтроку(Значение);

КонецФункции

// Возвращает подробное описание для справки
//
// Возвращаемое значение:
//   строка
Функция ПолучитьПодробноеОписание() Экспорт

	ВстроенныеТипы = ВстроенныеТипЗначенийПараметров();
	ОпределенныйТип = ВстроенныеТипы[Строка(ТипЗнч(ТипЗначенияПараметра))];
	Если ОпределенныйТип = Неопределено 
		Или Тип("ТипПеречисление") = ОпределенныйТип Тогда
		ПодробноеОписаниеПараметра = ТипЗначенияПараметра.ПодробноеОписание();
	КонецЕсли;

	Возврат ПодробноеОписаниеПараметра;

КонецФункции

// Возвращает истина, если данный параметр обязателен для указания
//
// Возвращаемое значение:
//   булево
Функция ПолучитьОбязательностьВвода() Экспорт

	Возврат НЕ НеОбязательныйПараметр;

КонецФункции

// Процедура устанавливает значение параметра из входящего значения
// приводить к необходимому типу
//
// Параметры:
//   ВходящееЗначение - строка - полученная строка при парсинге строки использования
Процедура УстановитьЗначение(ВходящееЗначение) Экспорт

	Если ЭтоМассив()
		И Не РазделительМассива = Неопределено Тогда

		МассивСтрок = СтрРазделить(ВходящееЗначение, РазделительМассива);
		Для каждого ЭлементМассива Из МассивСтрок Цикл
			Значение = ТипЗначенияПараметра.УстановитьЗначение(ВходящееЗначение, Значение);
		КонецЦикла;

	Иначе
		Значение = ТипЗначенияПараметра.УстановитьЗначение(ВходящееЗначение, Значение);
	КонецЕсли;

	УстановленаПользователем = Истина;

КонецПроцедуры

// Процедура устанавливает значение параметра из переменной окружения
//
Процедура ИзПеременнойОкружения() Экспорт

	Если ПустаяСтрока(ПеременнаяОкружения) Тогда
		Возврат;
	КонецЕсли;

	МассивПеременныхОК = СтрРазделить(ПеременнаяОкружения, " ");

	Для каждого ПеременнаяО Из МассивПеременныхОК Цикл

		ЗначениеИзПеременнойОкружения = ПолучитьПеременнуюСреды(ПеременнаяО);

		Если ЗначениеЗаполнено(ЗначениеИзПеременнойОкружения) Тогда

			УстановленаИзПеременнойОкружения = Истина;
			УстановитьЗначение(ЗначениеИзПеременнойОкружения);

		КонецЕсли;

	КонецЦикла;

	УстановленаПользователем = Ложь;

КонецПроцедуры

// Процедура устанавливает значение параметра из файла параметров
//
Процедура ИзФайла() Экспорт

	Если Не ЗначениеЗаполнено(ПутьКФайлу) 
		И НЕ ЗначениеЗаполнено(МестоВФайле) Тогда
		Возврат;
	КонецЕсли;

	Если ЗначениеЗаполнено(ПутьКФайлу) Тогда
		ЗначениеИзФайла = КешЧтенияФайловПараметров.ПолучитьЗначениеПараметра(ПутьКФайлу, МестоВФайле);
	Иначе
		ЗначениеИзФайла = ВнутреннийМенеджерПараметров.ПолучитьЗначениеПараметра(МестоВФайле);
	КонецЕсли;
	
	Если ЗначениеИзФайла = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если ЭтоМассив() Тогда

		Если Не ТипЗнч(ЗначениеИзФайла) = Тип("Массив") Тогда
			Возврат;
		КонецЕсли;

		Очистить();

		Для каждого ЭлементМассива Из ЗначениеИзФайла Цикл
		
			УстановленаИзПеременнойОкружения = Истина;
			УстановитьЗначение(ЭлементМассива);

		КонецЦикла;
		
	Иначе

		УстановленаИзПеременнойОкружения = Истина;
		УстановитьЗначение(ЗначениеИзФайла);
	
	КонецЕсли;

	УстановленаПользователем = Ложь;

КонецПроцедуры

#Область Текучих функций

// Функция устанавливает переменную окружения для параметра команды
// возвращает текущий параметр команды
//
// Параметры:
//   СтрокаПеременнаяОкружения - строка - имя переменной окружения, откуда получать значение
//                                        допустимо использование нескольких переменных окружения через пробел
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция ВОкружении(Знач СтрокаПеременнаяОкружения) Экспорт

	ПеременнаяОкружения = СтрокаПеременнаяОкружения;

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает признак скрытости значения по умолчанию в справке
// возвращает текущий параметр команды
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция СкрытьВСправке() Экспорт

	СкрытьЗначение = Истина;

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает значение по умолчанию
// возвращает текущий параметр команды
//
// Параметры:
//   ВходящееЗначение - произвольный - значение параметра по умолчанию
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция ПоУмолчанию(ВходящееЗначение) Экспорт

	Значение = ВходящееЗначение;

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает тип параметра "Булево"
// возвращает текущий параметр команды
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
// Вызов необязателен, автоматически определяется при создании параметра,
// если передано значение по умолчанию
Функция Флаговый() Экспорт

	Возврат ТБулево();

КонецФункции

// Функция устанавливает тип параметра "Булево"
// возвращает текущий параметр команды
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
// Вызов необязателен, автоматически определяется при создании параметра,
// если передано значение по умолчанию
Функция Флаг() Экспорт

	Возврат ТБулево();

КонецФункции

// Функция устанавливает тип параметра "Булево"
// возвращает текущий параметр команды
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
// Вызов необязателен, автоматически определяется при создании параметра,
// если передано значение по умолчанию
Функция ТБулево() Экспорт

	ТипОпции = Тип("Булево");
	ТипЭлементаОпции = Тип("Булево");
	СкрытьЗначение = Истина;
	ТипЗначенияПараметра = Новый ТипБулево();
	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает тип параметра "Дата"
// возвращает текущий параметр команды
//
// Параметры:
//   ФорматДаты - Строка - формат даты, при приведении к дате из строки параметра по умолчанию (yyyy-MM-dd_HH:mm:ss)
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
// Вызов необязателен, автоматически определяется при создании параметра,
// если передано значение по умолчанию
Функция ТДата(Знач ФорматДаты = "yyyy-MM-dd_HH:mm:ss" ) Экспорт

	ТипОпции = Тип("Дата");
	ТипЭлементаОпции = Тип("Дата");
	ТипЗначенияПараметра = Новый ТипДатаВремя(ФорматДаты);

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает тип параметра "Число"
// возвращает текущий параметр команды
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
// Вызов необязателен, автоматически определяется при создании параметра,
// если передано значение по умолчанию
Функция ТЧисло() Экспорт

	ТипОпции = Тип("Число");
	ТипЭлементаОпции = ТипОпции;
	ТипЗначенияПараметра = Новый ТипЧисло();
	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает тип параметра "Строка"
// возвращает текущий параметр команды
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
// Вызов необязателен, автоматически определяется при создании параметра,
// если передано значение по умолчанию
Функция ТСтрока() Экспорт

	ТипОпции = Тип("Строка");
	ТипЭлементаОпции = ТипОпции;
	ТипЗначенияПараметра = Новый ТипСтрока();
	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает тип параметра "Массив" элементы "Дата"
// возвращает текущий параметр команды
//
// Параметры:
//   ФорматДаты - Строка - формат даты, при приведении к дате из строки параметра по умолчанию (yyyy-MM-dd_HH:mm:ss)
//   ВходящийРазделительМассива - символ - используется для разделения параметров при парсинге строки
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция ТМассивДат(Знач ФорматДаты = "yyyy-MM-dd_HH:mm:ss", Знач ВходящийРазделительМассива = Неопределено) Экспорт

	ТипОпции = Тип("Массив");
	ТипЭлементаОпции = Тип("Дата");
	ТипЗначенияПараметра = Новый ТипМассивДат(ФорматДаты);
	Значение = Новый Массив;
	Если Не ВходящийРазделительМассива = Неопределено Тогда
		РазделительМассива = ВходящийРазделительМассива;
	КонецЕсли;
	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает тип параметра "Массив" элементы "Число"
// возвращает текущий параметр команды
//
// Параметры:
//   ВходящийРазделительМассива - символ - используется для разделения параметров при парсинге строки
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция ТМассивЧисел(Знач ВходящийРазделительМассива = Неопределено) Экспорт

	ТипОпции = Тип("Массив");
	ТипЭлементаОпции = Тип("Число");
	ТипЗначенияПараметра = Новый ТипМассивЧисел();
	Значение = Новый Массив;
	Если Не ВходящийРазделительМассива = Неопределено Тогда
		РазделительМассива = ВходящийРазделительМассива;
	КонецЕсли;
	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает тип параметра "Массив" элементы "Строки"
// возвращает текущий параметр команды
//
// Параметры:
//   ВходящийРазделительМассива - символ - используется для разделения параметров при парсинге строки
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция ТМассивСтрок(Знач ВходящийРазделительМассива = Неопределено) Экспорт

	ТипОпции = Тип("Массив");
	ТипЭлементаОпции = Тип("Строка");
	ТипЗначенияПараметра = Новый ТипМассивСтрок();
	Значение = Новый Массив;
	Если Не ВходящийРазделительМассива = Неопределено Тогда
		РазделительМассива = ВходящийРазделительМассива;
	КонецЕсли;
	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает описание параметра для справки
// возвращает текущий параметр команды
//
// Параметры:
//   НовыеОписание - строка - строка с новым описанием, отличным от переданного в момент создания
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция Описание(Знач НовыеОписание) Экспорт

	Описание = Описание;

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает дополнительный синоним/псевдоним параметра для справки
// возвращает текущий параметр команды
//
// Параметры:
//   СтрокаПсевдонима - строка - строка с новым псевдонимом, отличным от переданного в момент создания
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция Псевдоним(СтрокаПсевдонима) Экспорт

	Если Синонимы.Найти(СтрокаПсевдонима) = Неопределено Тогда
		Синонимы.Добавить(СтрокаПсевдонима);
		ПодготовитьНаименованияПараметров();
	КонецЕсли;

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает признак обязательности указания данного параметра
// возвращает текущий параметр команды
//
// Параметры:
//   Признак - булево - признак обязательности указания данного параметра (по умолчанию Истина)
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция Обязательный(Знач Признак = Истина) Экспорт

	ТребоватьУстановкиПользователем = Признак;
	НеОбязательныйПараметр = Не Признак;
	Возврат ЭтотОбъект;

КонецФункции

// (ЗАГОТОВКА) Функция устанавливает путь и место в файле при получении настроек
// возвращает текущий параметр команды
//
// Параметры:
//   МестоВФайле - строка - путь в файле, в формате "general.force"
//   ПутьКФайлу -  строка - путь к произвольному файлу для чтения
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция ВФайле(Знач ЗначениеМестоВФайле, Знач ЗначениеПутьКФайлу = "") Экспорт

	МестоВФайле = ЗначениеМестоВФайле;
	ПутьКФайлу = ЗначениеПутьКФайлу;

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает произвольный тип параметра
// возвращает текущий параметр команды
//
// Параметры:
//   ВходящийКлассЗначенияПараметра - класс - Произвольный класс, реализующий ряд обязательных функций
//   ВходящийТипПараметра           - тип   - тип значения параметра
//   ВходящийТипЭлементаПараметра   - Тип   - тип элементов значения параметра, если тип Массив
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция ПроизвольныйТип(Знач ВходящийКлассЗначенияПараметра, Знач ВходящийТипПараметра,  ВходящийТипЭлементаПараметра = Неопределено) Экспорт

	ТипОпции = ВходящийТипПараметра;
	ТипЭлементаОпции = ТипЭлементаОпции;
	ТипЗначенияПараметра = ВходящийКлассЗначенияПараметра;

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает тип параметра "Перечисление"
// возвращает текущий параметр команды
//
// Параметры:
//   ДоступныеПеречисления - Соответсвие 
//							 Ключ - Строка 
//							 Значение - Структура ("Наименование, Значение, ДополнительнаяСправка")
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
// Вызов необязателен, автоматически определяется при создании параметра,
// если передано значение по умолчанию
Функция ТПеречисление(Знач ДоступныеПеречисления = Неопределено) Экспорт

	ТипОпции = ТипЗнч(Неопределено);
	ТипЭлементаОпции = ТипОпции;
	ТипЗначенияПараметра = Новый ТипПеречисление();

	Если Не ДоступныеПеречисления = Неопределено Тогда
		ТипЗначенияПараметра.УстановитьПеречисления(ДоступныеПеречисления);
	КонецЕсли;

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает произвольный тип параметра
// возвращает текущий параметр команды
//
// Параметры:
//   НаименованиеПеречисления          - строка - пользовательное значение перечисления
//   ЗначениеПеречисления              - произвольный - системное значение перечисления
//   ДополнительнаяСправкаПеречисления - строка - дополнительная строка для справки
//
Функция Перечисление(Знач НаименованиеПеречисления, Знач ЗначениеПеречисления = Неопределено, Знач ДополнительнаяСправкаПеречисления = "") Экспорт
	
	Если Не ТипЗнч(ТипЗначенияПараметра) = Тип("ТипПеречисление") Тогда
		ВызватьИсключение "Указание перечисления допустимо только для типа параметра перечисление";
	КонецЕсли;

	Если ЗначениеПеречисления = Неопределено Тогда
		ЗначениеПеречисления = НаименованиеПеречисления;
	КонецЕсли;

	ТипЗначенияПараметра.ДобавитьПеречисление(НаименованиеПеречисления, ЗначениеПеречисления, ДополнительнаяСправкаПеречисления);

	Возврат ЭтотОбъект;

КонецФункции

// Функция устанавливает признак обязательности указания данного параметра
// возвращает текущий параметр команды
//
// Параметры:
//   Признак - булево - признак обязательности указания данного параметра (по умолчанию Истина)
//
// Возвращаемое значение:
//   ЭтотОбъект - класс ПараметрКоманды
Функция ПодробноеОписание(Знач ВходящееПодробноеОписание) Экспорт

	ПодробноеОписаниеПараметра = ВходящееПодробноеОписание;

	Возврат ЭтотОбъект;

КонецФункции

#КонецОбласти

Функция ВстроенныеТипЗначенийПараметров()

	ВстроенныеТипы = Новый Соответствие;

	ВстроенныеТипы.Вставить("Булево", Тип("ТипБулево"));
	ВстроенныеТипы.Вставить("Число", Тип("ТипЧисло"));
	ВстроенныеТипы.Вставить("Строка", Тип("ТипСтрока"));
	
	ВстроенныеТипы.Вставить("ТипБулево", Тип("ТипБулево"));
	ВстроенныеТипы.Вставить("ТипЧисло", Тип("ТипЧисло"));
	ВстроенныеТипы.Вставить("ТипДатаВремя", Тип("ТипДатаВремя"));
	//ВстроенныеТипы.Вставить("Длительность", Новый ТипДлительность);
	ВстроенныеТипы.Вставить("ТипСтрока", Тип("ТипСтрока"));
	//ВстроенныеТипы.Вставить("МассивДлительностей", Новый ТипМассивДлительностей);
	ВстроенныеТипы.Вставить("ТипМассивЧисел", Тип("ТипМассивЧисел"));
	ВстроенныеТипы.Вставить("ТипМассивСтрок", Тип("ТипМассивСтрок"));
	ВстроенныеТипы.Вставить("ТипМассивДат", Тип("ТипМассивДат"));
	ВстроенныеТипы.Вставить("ТипПеречисление", Тип("ТипПеречисление"));

	Возврат ВстроенныеТипы;

КонецФункции

Функция ПодготовитьНаименованияПараметров()

	НаименованияПараметров = Новый Массив;

	Для каждого ИмяСинонима Из Синонимы Цикл
		Префикс = "";
		Если ТипПараметра = "опция" Тогда
			Префикс = "-";
			Если СтрДлина(ИмяСинонима) > 1 Тогда
				Префикс = "--";
			КонецЕсли;
		КонецЕсли;
		НаименованияПараметров.Добавить(Префикс+ИмяСинонима);

	КонецЦикла;

КонецФункции