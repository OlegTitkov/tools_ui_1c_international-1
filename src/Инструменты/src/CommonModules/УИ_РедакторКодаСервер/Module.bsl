#Область ПрограммныйИнтерфейс

#Область СозданиеЭлементовФормы

Процедура ФормаПриСозданииНаСервере(Форма, ВидРедактора = Неопределено) Экспорт
	Если ВидРедактора = Неопределено Тогда
		ВидРедактора = ТекущийВариантРедактораКода1С();
	КонецЕсли;
	ВариантыРедактора = УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода();
	
	ПараметрыСеансаВХранилище = УИ_ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючОбъектаВХранилищеНастроек(),
		УИ_ОбщегоНазначенияКлиентСервер.КлючНастроекПараметровСеанса());
	Если Тип(ПараметрыСеансаВХранилище) = Тип("Структура") Тогда
		Если ПараметрыСеансаВХранилище.Свойство("ПолеHTMLПостроеноНаWebkit") Тогда
			Если Не ПараметрыСеансаВХранилище.ПолеHTMLПостроеноНаWebkit Тогда
				ВидРедактора = ВариантыРедактора.Текст;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ИмяРеквизитаВидРедактора=УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаВидРедактора();
	ИмяРеквизитаАдресБиблиотеки=УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаАдресБиблиотеки();
	ИмяРеквизитаРедактораКодаСписокРедакторовФормы = УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаСписокРедакторовФормы();
	
	МассивРеквизитов=Новый Массив;
	МассивРеквизитов.Добавить(Новый РеквизитФормы(ИмяРеквизитаВидРедактора, Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(20,
		ДопустимаяДлина.Переменная)), "", "", Истина));
	МассивРеквизитов.Добавить(Новый РеквизитФормы(ИмяРеквизитаАдресБиблиотеки, Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0,
		ДопустимаяДлина.Переменная)), "", "", Истина));
	МассивРеквизитов.Добавить(Новый РеквизитФормы(ИмяРеквизитаРедактораКодаСписокРедакторовФормы, Новый ОписаниеТипов, "", "", Истина));
		
	Форма.ИзменитьРеквизиты(МассивРеквизитов);
	
	Форма[ИмяРеквизитаВидРедактора]=ВидРедактора;
	Форма[ИмяРеквизитаАдресБиблиотеки] = ПоместитьБиблиотекуВоВременноеХранилище(Форма.УникальныйИдентификатор, ВидРедактора);
	Форма[ИмяРеквизитаРедактораКодаСписокРедакторовФормы] = Новый Структура;
КонецПроцедуры

Процедура СоздатьЭлементыРедактораКода(Форма, ИдентификаторРедактора, ПолеРедактора, ЯзыкРедактора = "bsl") Экспорт
	ИмяРеквизитаВидРедактора=УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаВидРедактора();
	
	ВидРедактора = Форма[ИмяРеквизитаВидРедактора];
	
	ДанныеРедактора = Новый Структура;

	Если УИ_РедакторКодаКлиентСервер.РедакторКодаИспользуетПолеHTML(ВидРедактора) Тогда
		Если ПолеРедактора.Вид <> ВидПоляФормы.ПолеHTMLДокумента Тогда
			ПолеРедактора.Вид = ВидПоляФормы.ПолеHTMLДокумента;
		КонецЕсли;
		ПолеРедактора.УстановитьДействие("ДокументСформирован", "Подключаемый_ПолеРедактораДокументСформирован");
		ПолеРедактора.УстановитьДействие("ПриНажатии", "Подключаемый_ПолеРедактораПриНажатии");

		ДанныеРедактора.Вставить("Инициализирован", Ложь);

	Иначе
		ПолеРедактора.Вид = ВидПоляФормы.ПолеТекстовогоДокумента;
		ДанныеРедактора.Вставить("Инициализирован", Истина);
	КонецЕсли;

	ДанныеРедактора.Вставить("Язык", ЯзыкРедактора);
	ДанныеРедактора.Вставить("ПолеРедактора", ПолеРедактора.Имя);
	ДанныеРедактора.Вставить("ИмяРеквизита", ПолеРедактора.ПутьКДанным);
	
	ВариантыРедактора = УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода();

	Если ВидРедактора = ВариантыРедактора.Monaco Тогда
		ПараметрыРедактораМонако = УИ_РедакторКодаСервер.ТекущиеПараметрыРедактораMonaco();
		
		ДанныеРедактора.Вставить("Тема", ПараметрыРедактораМонако.Тема);
		ДанныеРедактора.Вставить("ЯзыкСинтаксиса", ПараметрыРедактораМонако.ЯзыкСинтаксиса);
		ДанныеРедактора.Вставить("ИспользоватьКартуКода", ПараметрыРедактораМонако.ИспользоватьКартуКода);
	КонецЕсли;
	
	Форма[УИ_РедакторКодаКлиентСервер.ИмяРеквизитаРедактораКодаСписокРедакторовФормы()].Вставить(ИдентификаторРедактора,  ДанныеРедактора);	
КонецПроцедуры

#КонецОбласти

Функция ПоместитьБиблиотекуВоВременноеХранилище(ИдентификаторФормы, ВидРедактора=Неопределено) Экспорт
	Если ВидРедактора = Неопределено Тогда
		ВидРедактора = ТекущийВариантРедактораКода1С();
	КонецЕсли;
	ВариантыРедактора = УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода();
	
	Если ВидРедактора = ВариантыРедактора.Monaco Тогда
		ДвоичныеДанныеБиблиотеки=ПолучитьОбщийМакет("УИ_MonacoEditor");
	ИначеЕсли ВидРедактора = ВариантыРедактора.Ace Тогда
		ДвоичныеДанныеБиблиотеки=ПолучитьОбщийМакет("УИ_Ace");
	Иначе
		Возврат Неопределено;
	КонецЕсли;

	КаталогНаСервере=ПолучитьИмяВременногоФайла();
	СоздатьКаталог(КаталогНаСервере);

	Поток=ДвоичныеДанныеБиблиотеки.ОткрытьПотокДляЧтения();

	ЧтениеZIP=Новый ЧтениеZipФайла(Поток);
	ЧтениеZIP.ИзвлечьВсе(КаталогНаСервере, РежимВосстановленияПутейФайловZIP.Восстанавливать);

	СтруктураБиблиотеки=Новый Соответствие;

	ФайлыАрхива=НайтиФайлы(КаталогНаСервере, "*", Истина);
	Для Каждого ФайлБиблиотеки Из ФайлыАрхива Цикл
		КлючФайла=СтрЗаменить(ФайлБиблиотеки.ПолноеИмя, КаталогНаСервере + ПолучитьРазделительПути(), "");
		Если ФайлБиблиотеки.ЭтоКаталог() Тогда
			Продолжить;
		КонецЕсли;

		СтруктураБиблиотеки.Вставить(КлючФайла, Новый ДвоичныеДанные(ФайлБиблиотеки.ПолноеИмя));
	КонецЦикла;

	АдресБиблиотеки=ПоместитьВоВременноеХранилище(СтруктураБиблиотеки, ИдентификаторФормы);

	Попытка
		УдалитьФайлы(КаталогНаСервере);
	Исключение
		// TODO:
	КонецПопытки;

	Возврат АдресБиблиотеки;
КонецФункции

#Область НастройкиИнструментов

Функция ТекущийВариантРедактораКода1С() Экспорт
	РедакторКода = УИ_ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючДанныхНастроекВХранилищеНастроек(), "РедакторКода1С",
		УИ_РедакторКодаКлиентСервер.ВариантРедактораПоУмолчанию());
		
	УИ_ПараметрыСеанса = УИ_ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючОбъектаВХранилищеНастроек(),
		УИ_ОбщегоНазначенияКлиентСервер.КлючНастроекПараметровСеанса());
		
	Если Тип(УИ_ПараметрыСеанса) = Тип("Структура") Тогда
		Если УИ_ПараметрыСеанса.ПолеHTMLПостроеноНаWebkit<>Истина Тогда
			РедакторКода = УИ_РедакторКодаКлиентСервер.ВариантыРедактораКода().Текст;
		КонецЕсли;
	КонецЕсли;
	
	Возврат РедакторКода;
КонецФункции

// Установить вариант редактора кода 1С.
// 
// Параметры:
//  НовыйВариант - Строка - Устанавливаемый вариант редактора
Процедура УстановитьВариантРедактораКода1С(НовыйВариант) Экспорт
	УИ_ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючДанныхНастроекВХранилищеНастроек(), "РедакторКода1С", НовыйВариант);
КонецПроцедуры
#КонецОбласти

#Область Метаданные

Функция ЯзыкСинтаксисаКонфигурации() Экспорт
	Если Метаданные.ВариантВстроенногоЯзыка = Метаданные.СвойстваОбъектов.ВариантВстроенногоЯзыка.Английский Тогда
		Возврат "Английский";
	Иначе
		Возврат "Русский";
	КонецЕсли;
КонецФункции

Функция ОбъектМетаданныхИмеетПредопределенные(ИмяТипаМетаданного)
	
	Объекты = Новый Массив();
	Объекты.Добавить("Справочник");
	Объекты.Добавить("ПланСчетов");	
	Объекты.Добавить("ПланВидовХарактеристик");
	Объекты.Добавить("ПланВидовРасчета");
	
	Возврат Объекты.Найти(ИмяТипаМетаданного) <> Неопределено;
	
КонецФункции

Функция ОбъектМетаданныхИмеетВиртуальныеТаблицы(ИмяТипаМетаданного)
	
	Объекты = Новый Массив();
	Объекты.Добавить("РегистрыСведений");
	Объекты.Добавить("РегистрыНакопления");	
	Объекты.Добавить("РегистрыРасчета");
	Объекты.Добавить("РегистрыБухгалтерии");
	
	Возврат Объекты.Найти(ИмяТипаМетаданного) <> Неопределено;
	
КонецФункции


Функция ОписаниеРеквизитаОбъектаМетаданных(Реквизит,ТипВсеСсылки)
	Описание = Новый Структура;
	Описание.Вставить("Имя", Реквизит.Имя);
	Описание.Вставить("Синоним", Реквизит.Синоним);
	Описание.Вставить("Комментарий", Реквизит.Комментарий);
	
	СсылочныеТипы = Новый Массив;
	Для каждого ТекТ Из Реквизит.Тип.Типы() Цикл
		Если ТипВсеСсылки.СодержитТип(ТекТ) Тогда
			СсылочныеТипы.Добавить(ТекТ);
		КонецЕсли;
	КонецЦикла;
	Описание.Вставить("СсылочныйТип", Новый ОписаниеТипов(СсылочныеТипы));
	
	Возврат Описание;
КонецФункции

Функция ОписаниеОбъектаМетаданныхКонфигурацииПоИмени(ВидОбъекта, ИмяОбъекта) Экспорт
	ТипВсеСсылки = УИ_ОбщегоНазначения.ОписаниеТипаВсеСсылки();

	Возврат ОписаниеОбъектаМетаданныхКонфигурации(Метаданные[ВидОбъекта][ИмяОбъекта], ВидОбъекта, ТипВсеСсылки);	
КонецФункции

Функция ОписаниеОбъектаМетаданныхКонфигурации(ОбъектМетаданных, ВидОбъекта, ТипВсеСсылки) Экспорт
	ОписаниеЭлемента = Новый Структура;
	ОписаниеЭлемента.Вставить("ВидОбъекта", ВидОбъекта);
	ОписаниеЭлемента.Вставить("Имя", ОбъектМетаданных.Имя);
	ОписаниеЭлемента.Вставить("Синоним", ОбъектМетаданных.Синоним);
	ОписаниеЭлемента.Вставить("Комментарий", ОбъектМетаданных.Комментарий);

	КоллекцииРеквизитов = Новый Структура("Реквизиты, СтандартныеРеквизиты, Измерения, Ресурсы, РеквизитыАдресации, ПризнакиУчета");
	КоллекцииТЧ = Новый Структура("ТабличныеЧасти, СтандартныеТабличныеЧасти");
	ЗаполнитьЗначенияСвойств(КоллекцииРеквизитов, ОбъектМетаданных);
	ЗаполнитьЗначенияСвойств(КоллекцииТЧ, ОбъектМетаданных);

	Для Каждого КлючЗначение Из КоллекцииРеквизитов Цикл
		Если КлючЗначение.Значение = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		ОписаниеКоллекцииРеквизитов= Новый Структура;

		Для Каждого ТекРеквизит Из КлючЗначение.Значение Цикл
			ОписаниеКоллекцииРеквизитов.Вставить(ТекРеквизит.Имя, ОписаниеРеквизитаОбъектаМетаданных(ТекРеквизит,
				ТипВсеСсылки));
		КонецЦикла;

		ОписаниеЭлемента.Вставить(КлючЗначение.Ключ, ОписаниеКоллекцииРеквизитов);
	КонецЦикла;

	Для Каждого КлючЗначение Из КоллекцииТЧ Цикл
		Если КлючЗначение.Значение = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		ОписаниеКоллекцииТЧ = Новый Структура;

		Для Каждого ТЧ Из КлючЗначение.Значение Цикл
			ОписаниеТЧ = Новый Структура;
			ОписаниеТЧ.Вставить("Имя", ТЧ.Имя);
			ОписаниеТЧ.Вставить("Синоним", ТЧ.Синоним);
			ОписаниеТЧ.Вставить("Комментарий", ТЧ.Комментарий);

			КоллекцииРеквизитовТЧ = Новый Структура("Реквизиты, СтандартныеРеквизиты");
			ЗаполнитьЗначенияСвойств(КоллекцииРеквизитовТЧ, ТЧ);
			Для Каждого ТекКоллекцияРеквизитовТЧ Из КоллекцииРеквизитовТЧ Цикл
				Если ТекКоллекцияРеквизитовТЧ.Значение = Неопределено Тогда
					Продолжить;
				КонецЕсли;

				ОписаниеКоллекцииРеквизитовТЧ = Новый Структура;

				Для Каждого ТекРеквизит Из ТекКоллекцияРеквизитовТЧ.Значение Цикл
					ОписаниеКоллекцииРеквизитовТЧ.Вставить(ТекРеквизит.Имя, ОписаниеРеквизитаОбъектаМетаданных(
						ТекРеквизит, ТипВсеСсылки));
				КонецЦикла;

				ОписаниеТЧ.Вставить(ТекКоллекцияРеквизитовТЧ.Ключ, ОписаниеКоллекцииРеквизитовТЧ);
			КонецЦикла;
			ОписаниеКоллекцииТЧ.Вставить(ТЧ.Имя, ОписаниеТЧ);
		КонецЦикла;

		ОписаниеЭлемента.Вставить(КлючЗначение.Ключ, ОписаниеКоллекцииТЧ);
	КонецЦикла;
	Расширение = ОбъектМетаданных.РасширениеКонфигурации();
	Если Расширение <> Неопределено Тогда
		ОписаниеЭлемента.Вставить("Расширение", Расширение.Имя);
	Иначе
		ОписаниеЭлемента.Вставить("Расширение", Неопределено);
	КонецЕсли;

	Если ВидОбъекта = "Константа" Тогда
		ОписаниеЭлемента.Вставить("Тип", ОбъектМетаданных.Тип);
	ИначеЕсли ВидОбъекта = "Перечисление" Тогда
		ЗначенияПеречисления = Новый Структура;

		Для Каждого ТекЗнч Из ОбъектМетаданных.ЗначенияПеречисления Цикл
			ЗначенияПеречисления.Вставить(ТекЗнч.Имя, ТекЗнч.Синоним);
		КонецЦикла;

		ОписаниеЭлемента.Вставить("ЗначенияПеречисления", ЗначенияПеречисления);
	КонецЕсли;

	Если ОбъектМетаданныхИмеетПредопределенные(ВидОбъекта) Тогда

		Предопределенные = ОбъектМетаданных.ПолучитьИменаПредопределенных();

		ОписаниеПредопределенных = Новый Структура;
		Для Каждого Имя Из Предопределенные Цикл
			ОписаниеПредопределенных.Вставить(Имя, "");
		КонецЦикла;

		ОписаниеЭлемента.Вставить("Предопределенные", ОписаниеПредопределенных);
	КонецЕсли;
	
	Возврат ОписаниеЭлемента;
КонецФункции

Функция ОписаниеКоллекцииМетаданныхКонфигурации(Коллекция, ВидОбъекта, СоответствиеТипов, ТипВсеСсылки) 
	ОписаниеКоллекции = Новый Структура();

	Для Каждого ОбъектМетаданных Из Коллекция Цикл
		ОписаниеЭлемента = ОписаниеОбъектаМетаданныхКонфигурации(ОбъектМетаданных, ВидОбъекта, ТипВсеСсылки);
			
		ОписаниеКоллекции.Вставить(ОбъектМетаданных.Имя, ОписаниеЭлемента);
		
		Если УИ_ОбщегоНазначения.ЭтоОбъектСсылочногоТипа(ОбъектМетаданных) Тогда
			СоответствиеТипов.Вставить(Тип(ВидОбъекта+"Ссылка."+ОписаниеЭлемента.Имя), ОписаниеЭлемента);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ОписаниеКоллекции;
КонецФункции

Функция ОписаниеОбщихМодулейКонфигурации() Экспорт
	Возврат ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ОбщиеМодули, "ОбщийМодуль", Новый Соответствие,
		УИ_ОбщегоНазначения.ОписаниеТипаВсеСсылки());
КонецФункции

Функция ОписнаиеМетаданныйДляИнициализацииРедактораMonaco() Экспорт
	СоответствиеТипов = Новый Соответствие;
	ТипВсеСсылки = УИ_ОбщегоНазначения.ОписаниеТипаВсеСсылки();

	ОписаниеМетаданных = Новый Структура;
	ОписаниеМетаданных.Вставить("ОбщиеМодули", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ОбщиеМодули, "ОбщийМодуль", СоответствиеТипов, ТипВсеСсылки));
//	ОписаниеМетаданных.Вставить("Роли", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Роли, "Роль", СоответствиеТипов, ТипВсеСсылки));
//	ОписаниеМетаданных.Вставить("ОбщиеФормы", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ОбщиеФормы, "ОбщаяФорма", СоответствиеТипов, ТипВсеСсылки));

	Возврат ОписаниеМетаданных;	
КонецФункции

Функция ОписаниеМетаданныхКонфигурации() Экспорт
	ТипВсеСсылки = УИ_ОбщегоНазначения.ОписаниеТипаВсеСсылки();
	
	ОписаниеМетаданных = Новый Структура;
	
	СоответствиеТипов = Новый Соответствие;
	
	ОписаниеМетаданных.Вставить("Имя", Метаданные.Имя);
	ОписаниеМетаданных.Вставить("Версия", Метаданные.Версия);
	ОписаниеМетаданных.Вставить("ТипВсеСсылки", ТипВсеСсылки);
	
	ОписаниеМетаданных.Вставить("Справочники", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Справочники, "Справочник", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("Документы", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Документы, "Документ", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("РегистрыСведений", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.РегистрыСведений, "РегистрСведений", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("РегистрыНакопления", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.РегистрыНакопления, "РегистрНакопления", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("РегистрыБухгалтерии", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.РегистрыБухгалтерии, "РегистрБухгалтерии", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("РегистрыРасчета", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.РегистрыРасчета, "РегистрРасчета", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("Обработки", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Обработки, "Обработка", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("Отчеты", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Отчеты, "Отчет", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("Перечисления", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Перечисления, "Перечисление", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("ОбщиеМодули", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ОбщиеМодули, "ОбщийМодуль", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("ПланыСчетов", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПланыСчетов, "ПланСчетов", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("БизнесПроцессы", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.БизнесПроцессы, "БизнесПроцесс", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("Задачи", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Задачи, "Задача", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("ПланыСчетов", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПланыСчетов, "ПланСчетов", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("ПланыОбмена", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПланыОбмена, "ПланОбмена", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("ПланыВидовХарактеристик", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПланыВидовХарактеристик, "ПланВидовХарактеристик", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("ПланыВидовРасчета", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПланыВидовРасчета, "ПланВидовРасчета", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("Константы", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.Константы, "Константа", СоответствиеТипов, ТипВсеСсылки));
	ОписаниеМетаданных.Вставить("ПараметрыСеанса", ОписаниеКоллекцииМетаданныхКонфигурации(Метаданные.ПараметрыСеанса, "ПараметрСеанса", СоответствиеТипов, ТипВсеСсылки));
	
	ОписаниеМетаданных.Вставить("СоответствиеСсылочныхТипов", СоответствиеТипов);
	
	Возврат ОписаниеМетаданных;
КонецФункции

Функция АдресОписанияМетаданныхКонфигурации() Экспорт
	ОПисание = ОписаниеМетаданныхКонфигурации();
	
	Возврат ПоместитьВоВременноеХранилище(ОПисание, Новый УникальныйИдентификатор);
КонецФункции

Функция СписокМетаданныхПоВиду(ВидМетаданных) Экспорт
	КоллекцияМетаданных = Метаданные[ВидМетаданных];
	
	МассивИмен = Новый Массив;
	Для Каждого ОбъектМетаданных Из КоллекцияМетаданных Цикл
		МассивИмен.Добавить(ОбъектМетаданных.Имя);
	КонецЦикла;
	
	Возврат МассивИмен;
КонецФункции

Процедура ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(СоответствиеТипов, Коллекция, ВидОбъекта)
	Для Каждого ОбъектМетаданных Из Коллекция Цикл
		ОписаниеЭлемента = Новый Структура;
		ОписаниеЭлемента.Вставить("Имя", ОбъектМетаданных.Имя);
		ОписаниеЭлемента.Вставить("ВидОбъекта", ВидОбъекта);
			
		СоответствиеТипов.Вставить(Тип(ВидОбъекта+"Ссылка."+ОбъектМетаданных.Имя), ОписаниеЭлемента);
	КонецЦикла;
	
КонецПроцедуры

Функция СоответствиеСсылочныхТипов() Экспорт
	Соответствие = Новый Соответствие;
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.Справочники, "Справочник");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.Документы, "Документ");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.Перечисления, "Перечисление");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыСчетов, "ПланСчетов");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.БизнесПроцессы, "БизнесПроцесс");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.Задачи, "Задача");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыСчетов, "ПланСчетов");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыОбмена, "ПланОбмена");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыВидовХарактеристик, "ПланВидовХарактеристик");
	ДобавитьКоллекциюМетаданныхВСоответствиеСсылочныхТипов(Соответствие, Метаданные.ПланыВидовРасчета, "ПланВидовРасчета");

	Возврат Соответствие;
КонецФункции

#КонецОбласти


#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ТекущиеПараметрыРедактораMonaco() Экспорт
	ПараметрыИзХранилища =  УИ_ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючДанныхНастроекВХранилищеНастроек(), "ПараметрыРедактораMonaco",
		УИ_РедакторКодаКлиентСервер.ПараметрыРедактораMonacoПоУмолчанию());

	ПараметрыПоУмолчанию = УИ_РедакторКодаКлиентСервер.ПараметрыРедактораMonacoПоУмолчанию();
	ЗаполнитьЗначенияСвойств(ПараметрыПоУмолчанию, ПараметрыИзХранилища);

	Возврат ПараметрыПоУмолчанию;
КонецФункции

Процедура УстановитьНовыеПараметрыРедактораMonaco(НовыеПараметры) Экспорт
	УИ_ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючДанныхНастроекВХранилищеНастроек(), "ПараметрыРедактораMonaco", НовыеПараметры);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти