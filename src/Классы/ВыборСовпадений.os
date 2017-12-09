

Функция НовоеСостояние() Экспорт

	Возврат Новый Структура("Завершено, МассивСоединений", Ложь, Новый Массив);
		
КонецФункции


Функция НовоеСоединениеСостояний(Парсер, СледующееСостояние)Экспорт

	Возврат Новый Структура("Парсер, СледующееСостояние",Парсер, СледующееСостояние);
	
КонецФункции

Функция Т(ТекущееСостояние, Парсер ,СледующееСостояние) Экспорт
	
	ТекущееСостояние.МассивСоединений.Добавить(НовоеСоединениеСостояний(Парсер, СледующееСостояние));
	Возврат СледующееСостояние;

КонецФункции


Процедура Подготовить(Состояние) Экспорт

	ПосетилиСостояниеСортировки = Новый Соответствие;
	ПосетилиСостояниеУпрощения = Новый Соответствие;
	
	СортировкаСоединений(Состояние, ПосетилиСостояниеСортировки);
	УпроститьСоединения(Состояние, Состояние, ПосетилиСостояниеУпрощения);

КонецПроцедуры

Процедура УпроститьСоединения(Знач НачальноеСостояние, Состояние, ПосетилиСостояние);

	Если ПосетилиСостояние[Состояние] = Истина Тогда
		Возврат;
	КонецЕсли;

	ПосетилиСостояние.Вставить(Состояние, Истина);

	Для каждого Соединение Из Состояние.МассивСоединений Цикл
		
		УпроститьСоединения(НачальноеСостояние, Соединение.СледующееСостояние, ПосетилиСостояние);

	КонецЦикла;
	
	УпроститьСвоиСоединения(Состояние, НачальноеСостояние);

КонецПроцедуры

Процедура УпроститьСвоиСоединения(Состояние, НачальноеСостояние);

	Индекс = -1;
	Для каждого Соединение Из Состояние.МассивСоединений Цикл
		Индекс = Индекс + 1;
		Если ТипЗнч(Соединение.Парсер) = Тип("ЛюбойСимвол") Тогда
			
			СледующееСостояние = Соединение.СледующееСостояние;

			Состояние.МассивСоединений.Удалить(Индекс);

			Для каждого СоединениеСледующего Из СледующееСостояние.МассивСоединений Цикл

				Если СостояниеСодержитСоединения(Состояние, СоединениеСледующего) Тогда

					Состояние.МассивСоединений.Добавить(СоединениеСледующего);

				КонецЕсли;

			КонецЦикла;

			Если СледующееСостояние.Завершено Тогда
				Состояние.Завершено = Истина;
			КонецЕсли;
			
			Возврат;

		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция СостояниеСодержитСоединения(Состояние, СоединениеПроверки)

	Для каждого Соединение Из Состояние.МассивСоединений Цикл
		
		Если Соединение.СледующееСостояние = СоединениеПроверки.СледующееСостояние
			И Соединение.Парсер = СоединениеПроверки.Парсер Тогда
			Возврат Истина;
		КонецЕсли;

		
	КонецЦикла;

	Возврат Ложь
	
КонецФункции

Процедура СортировкаСоединений(Состояние, ПосетилиСостояние)
	
	Если ПосетилиСостояние[Состояние] = Истина Тогда
		Возврат;
	КонецЕсли;

	ПосетилиСостояние.Вставить(Состояние, Истина);
	
	СортироватьМассив(Состояние.МассивСоединений);

	Для каждого Соединение Из Состояние.МассивСоединений Цикл
		СортировкаСоединений(Соединение.СледующееСостояние, ПосетилиСостояние);

	КонецЦикла;


КонецПроцедуры

Процедура СортироватьМассив(МассивСоединений)
	//Написать....
КонецПроцедуры