Перем Опции Экспорт;
Перем ОпцииИндекс Экспорт;

Перем Лог;

Функция ПриСозданииОбъекта(ВходящиеОпции, Индекс)
	Опция = ВходящиеОпции;
	ОпцииИндекс = Индекс;
КонецФункции

Функция Поиск(Знач Аргументы, КонтекстПоиска) Экспорт

	Результат  = Новый Структура("РезультатПоиска, Аргументы", Ложь, Аргументы);

	РезультатПопыткиПоиска = ПопыткаПоиска(Аргументы, КонтекстПоиска);

	Если НЕ РезультатПопыткиПоиска.Найдено Тогда
		Возврат Результат;
	КонецЕсли;

	АргументыДляЦикла = РезультатПопыткиПоиска.Аргументы;
	Пока Истина Цикл

		РезультатПопыткиПоискаВЦикле = ПопыткаПоиска(АргументыДляЦикла, КонтекстПоиска);
		
		Если НЕ РезультатПопыткиПоискаВЦикле.Найдено Тогда
			Результат.РезультатПоиска = Истина;
			Результат.Аргументы = РезультатПопыткиПоискаВЦикле.Аргументы;
			Возврат Результат;
		КонецЕсли;
		
		АргументыДляЦикла = РезультатПопыткиПоискаВЦикле.Аргументы;

	КонецЦикла;
	
	Возврат Результат;

КонецФункции

Функция ПопыткаПоиска(Знач Аргументы, КонтекстПоиска)

	Результат  = Новый Структура("РезультатПоиска, Аргументы", Ложь, Аргументы);
	
	Если Аргументы.Количество() = 0 
		ИЛИ КонтекстПоиска.СбросОпций Тогда
	
		Возврат Результат;

	КонецЕсли;

	Для каждого ОпцияПоиска Из Опции Цикл
		
		Если КонтекстПоиска.НеВключенныеОпции[ОпцияПоиска] = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		КлассПоиска = Новый ОпцияПарсера(ОпцияПоиска, ОпцииИндекс);
		РезультатПоиска = КлассПоиска.Найти(Аргументы, КонтекстПоиска);
		
		Если РезультатПоиска.РезультатПоиска Тогда
			Если ОпцияПоиска.УстановленаИзПеременнойОкружения Тогда
				
				КонтекстПоиска.НеВключенныеОпции.Вставить(ОпцияПоиска, Истина);
	
			КонецЕсли;
			
			Возврат Новый Структура("РезультатПоиска, Аргументы", Истина, РезультатПоиска.Аргументы);
		КонецЕсли;

	КонецЦикла;


	Возврат Результат;


КонецФункции



Функция Приоритет() Экспорт
	Возврат 2;
КонецФункции

Функция ВСтроку() Экспорт
	Представление = "-";

	Для каждого Опция Из Опции Цикл

		ИмяОпции = Опция.Синонимы[0];
		Если СтрНачинаетсяС(ИмяОпции, "-") Тогда
			ИмяОпции = Сред(ИмяОпции,2);
		КонецЕсли;
			
		Представление = Представление + ИмяОпции;
			
	КонецЦикла;

	Возврат Представление;
КонецФункции

Лог = Логирование.ПолучитьЛог("oscript.lib.1cli_class_options");
//Лог.УстановитьУровень(УровниЛога.Отладка);