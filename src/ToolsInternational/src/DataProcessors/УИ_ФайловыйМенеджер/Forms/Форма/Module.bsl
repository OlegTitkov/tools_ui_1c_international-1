#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	WindowsКлиент=UT_CommonClientServer.IsWindows();

	ОбновитьКлиент();
	ОбновитьСервер();

	Элементы.ТекущийКаталогСервер.СписокВыбора.ЗагрузитьЗначения(ИсторияВыбораСервер.ВыгрузитьЗначения());
	Элементы.ТекущийКаталогКлиент.СписокВыбора.ЗагрузитьЗначения(ИсторияВыбораКлиент.ВыгрузитьЗначения());
	
	УстановитьРамкуТекущейПанели();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	WindowsСервер=UT_CommonClientServer.IsWindows();
	РазделительПутиКлиент=ПолучитьРазделительПутиКлиента();
	РазделительПутиСервер=ПолучитьРазделительПутиСервера();
	ТекущаяТаблицаФайлов="ФайлыЛеваяПанель";

	ЗаполнитьПодменюСортировок();

	UT_Common.ФормаИнструментаПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка,
		Элементы.ГруппаНижняяПанель);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТекущийКаталогСерверПриИзменении(Элемент)
	Если Не ПустаяСтрока(ТекущийКаталогСервер) И Не Прав(ТекущийКаталогСервер, 1) = РазделительПутиСервер Тогда
		ТекущийКаталогСервер = ТекущийКаталогСервер + РазделительПутиСервер;
	КонецЕсли;
	ОбновитьСервер();
	ОбновитьИсториюСервер();
КонецПроцедуры

&НаКлиенте
Процедура ТекущийКаталогКлиентПриИзменении(Элемент)
	Если Не ПустаяСтрока(ТекущийКаталогКлиент) И Не Прав(ТекущийКаталогКлиент, 1) = РазделительПутиКлиент Тогда
		ТекущийКаталогКлиент = ТекущийКаталогКлиент + РазделительПутиКлиент;
	КонецЕсли;
	ОбновитьКлиент();
	ОбновитьИсториюКлиент();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыЛевойПанели

&НаКлиенте
Процедура ФайлыЛеваяПанельВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ТаблицаФайловВыбор(Истина, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ФайлыЛеваяПанельПриАктивизацииЯчейки(Элемент)
	ТекущаяТаблицаФайлов=Элемент.Имя;
	УстановитьРамкуТекущейПанели();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыПравойПанели
&НаКлиенте
Процедура ФайлыПраваяПанельВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ТаблицаФайловВыбор(Ложь, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка);
КонецПроцедуры
&НаКлиенте
Процедура ФайлыПраваяПанельПриАктивизацииЯчейки(Элемент)
	ТекущаяТаблицаФайлов=Элемент.Имя;
	УстановитьРамкуТекущейПанели();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ТаблицаФайловВыбор(ЭтоЛеваяТаблица, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;

	Если ЭтоЛеваяТаблица Тогда
		ТекущийКаталог=ТекущийКаталогКлиент;
		ТаблицаФайлов=ФайлыЛеваяПанель;
	Иначе
		ТекущийКаталог=ТекущийКаталогСервер;
		ТаблицаФайлов=ФайлыПраваяПанель;
	КонецЕсли;

	ТекущиеДанные=ТаблицаФайлов.НайтиПоИдентификатору(ВыбраннаяСтрока);
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если ТекущиеДанные.ЭтоКаталог Тогда
		ПерейтиВКаталог(ФайлыЛеваяПанель, ТекущиеДанные.ПолноеИмя, ЭтоЛеваяТаблица);
	Иначе
		НачатьЗапускПриложения(UT_CommonClient.ПустоеОписаниеОповещенияДляЗапускаПриложения(),
			ТекущиеДанные.ПолноеИмя, ТекущийКаталог);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСервер(Команда = Неопределено)
	Если Не WindowsСервер И Не ЗначениеЗаполнено(ТекущийКаталогСервер) Тогда
		ТекущийКаталогСервер="/";
	КонецЕсли;

	ОбновитьДеревоФайлов(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьКлиент(Команда = Неопределено)
	Если Не WindowsКлиент И Не ЗначениеЗаполнено(ТекущийКаталогКлиент) Тогда
		ТекущийКаталогКлиент="/";
	КонецЕсли;

	ОбновитьДеревоФайлов(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиСервер(Команда)
	ИмяКаталога = СтрПолучитьСтроку(СтрЗаменить(Команда.Имя, "_", Символы.ПС), 2);
	ТекущийКаталогСервер = ИмяКаталонаНаСервере(ИмяКаталога);
	ОбновитьСервер();
	ОбновитьИсториюСервер();
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиКлиент(Команда)
	ИмяКаталога = СтрПолучитьСтроку(СтрЗаменить(Команда.Имя, "_", Символы.ПС), 2);
	ТекущийКаталогКлиент = Вычислить(ИмяКаталога + "()");
	ОбновитьКлиент();
	ОбновитьИсториюКлиент();
КонецПроцедуры

&НаКлиенте
Процедура Перейти_РабочийСтол_Клиент(Команда)
	МассивКаталогов = СтрРазделить(КаталогДокументов(), РазделительПутиКлиент);
	Если ПустаяСтрока(МассивКаталогов[МассивКаталогов.ВГраница()]) Тогда
		МассивКаталогов.Удалить(МассивКаталогов.ВГраница());
	КонецЕсли;
	МассивКаталогов[МассивКаталогов.ВГраница()] = "Desktop";
	Путь = "";
	Для Каждого ИмяКаталога Из МассивКаталогов Цикл
		Путь = Путь + ИмяКаталога + РазделительПутиКлиент;
	КонецЦикла;
	ТекущийКаталогКлиент = Путь;
	ОбновитьКлиент();
	ОбновитьИсториюКлиент();
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьНаСервер(Команда)

	КаталогИсточник = ТекущийКаталогКлиент;
	КаталогПриемник = ТекущийКаталогСервер;
	Если ПустаяСтрока(КаталогПриемник) Тогда
		Возврат;
	КонецЕсли;

	ЭлементТаблицы= Элементы.ФайлыЛеваяПанель;
	ТаблицаПанели = ФайлыЛеваяПанель;
	ТекущиеДанные = ЭлементТаблицы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	МассивФайлов = Новый Массив;
	Для Каждого ИдентификаторСтроки Из ЭлементТаблицы.ВыделенныеСтроки Цикл
		СтрокаДерева = ТаблицаПанели.НайтиПоИдентификатору(ИдентификаторСтроки);
		Если СтрДлина(СтрокаДерева.ПолноеИмя) <= СтрДлина(КаталогИсточник) Тогда
			Возврат;
		КонецЕсли;

		СтрокаСтруктура = Новый Структура("ПолноеИмя,ЭтоКаталог", СтрокаДерева.ПолноеИмя, СтрокаДерева.ЭтоКаталог);
		СтрокаСтруктура.Вставить("АдресВХранилище", ПоместитьВоВременноеХранилище(
			Новый ДвоичныеДанные(СтрокаСтруктура.ПолноеИмя), УникальныйИдентификатор));

		МассивФайлов.Добавить(СтрокаСтруктура);
		Если Не СтрокаСтруктура.ЭтоКаталог Тогда
			Продолжить;
		КонецЕсли;

		Результат = НайтиВсеФайлыНаКлиенте(СтрокаДерева.ПолноеИмя, РазделительПутиКлиент, УникальныйИдентификатор);
		Для Каждого СтрокаСтруктура Из Результат Цикл
			МассивФайлов.Добавить(СтрокаСтруктура);
		КонецЦикла;
	КонецЦикла;

	Для сч = 0 По МассивФайлов.ВГраница() Цикл
		СтрокаСтруктура = МассивФайлов[сч];
		Состояние("Копирование " + (сч + 1) + " из " + МассивФайлов.Количество() + " : " + СтрокаСтруктура.ПолноеИмя);

		КонечноеИмяФайла = КаталогПриемник + Сред(СтрокаСтруктура.ПолноеИмя, СтрДлина(КаталогИсточник) + 1);

		Если СтрокаСтруктура.ЭтоКаталог Тогда
			Файл = Новый Файл(КонечноеИмяФайла);
			Если Не Файл.Существует() Тогда
				СоздатьКаталогНаСервере(КонечноеИмяФайла);
			КонецЕсли;
		Иначе
//			ДвоичныеДанные = Новый ДвоичныеДанные(СтрокаСтруктура.ПолноеИмя);
//			АдресВХранилище = ПоместитьВоВременноеХранилище(ДвоичныеДанные, ЭтаФорма.УникальныйИдентификатор);
			РазвернутьФайлНаСервере(СтрокаСтруктура.АдресВХранилище, КонечноеИмяФайла);
		КонецЕсли;

	КонецЦикла;

	ОбновитьСервер();

КонецПроцедуры

&НаКлиенте
Процедура СкопироватьНаКлиент(Команда)

	КаталогИсточник = ТекущийКаталогСервер;
	КаталогПриемник = ТекущийКаталогКлиент;
	Если ПустаяСтрока(КаталогПриемник) Тогда
		Возврат;
	КонецЕсли;

	ЭлементТаблицы = Элементы.ФайлыПраваяПанель;
	ТаблицаПанели = ФайлыПраваяПанель;
	ТекущиеДанные = ЭлементТаблицы.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	МассивФайлов = Новый Массив;
	Для Каждого ИдентификаторСтроки Из ЭлементТаблицы.ВыделенныеСтроки Цикл
		СтрокаДерева = ТаблицаПанели.НайтиПоИдентификатору(ИдентификаторСтроки);
		Если СтрДлина(СтрокаДерева.ПолноеИмя) <= СтрДлина(КаталогИсточник) Тогда
			Возврат;
		КонецЕсли;

		СтрокаСтруктура = Новый Структура("ПолноеИмя,ЭтоКаталог", СтрокаДерева.ПолноеИмя, СтрокаДерева.ЭтоКаталог);
		СтрокаСтруктура.Вставить("АдресВХранилище", ПоместитьВоВременноеХранилищеНаСервере(СтрокаСтруктура.ПолноеИмя,
			УникальныйИдентификатор));

		МассивФайлов.Добавить(СтрокаСтруктура);
		Если Не СтрокаСтруктура.ЭтоКаталог Тогда
			Продолжить;
		КонецЕсли;

		Результат = НайтиВсеФайлыНаСервере(СтрокаДерева.ПолноеИмя, РазделительПутиСервер, УникальныйИдентификатор);

		Для Каждого СтрокаСтруктура Из Результат Цикл
			МассивФайлов.Добавить(СтрокаСтруктура);
		КонецЦикла;
	КонецЦикла;

	Для сч = 0 По МассивФайлов.ВГраница() Цикл
		СтрокаСтруктура = МассивФайлов[сч];
		Состояние("Копирование " + (сч + 1) + " из " + МассивФайлов.Количество() + " : " + СтрокаСтруктура.ПолноеИмя);

		КонечноеИмяФайла = КаталогПриемник + Сред(СтрокаСтруктура.ПолноеИмя, СтрДлина(КаталогИсточник) + 1);

		Если СтрокаСтруктура.ЭтоКаталог Тогда
			Файл = Новый Файл(КонечноеИмяФайла);
			Если Не Файл.Существует() Тогда
				СоздатьКаталог(КонечноеИмяФайла);
			КонецЕсли;
		Иначе
//			АдресВХранилище = ПоместитьВоВременноеХранилищеНаСервере(СтрокаСтруктура.ПолноеИмя,
//				ЭтаФорма.УникальныйИдентификатор);
			ДвоичныеДанные = ПолучитьИзВременногоХранилища(СтрокаСтруктура.АдресВХранилище);
			ДвоичныеДанные.Записать(КонечноеИмяФайла);
		КонецЕсли;

	КонецЦикла;

	ОбновитьКлиент();

КонецПроцедуры

&НаКлиенте
Процедура УдалитьНаКлиенте(Команда)
	Если ПустаяСтрока(ТекущийКаталогКлиент) Тогда
		Возврат;
	КонецЕсли;

	ЭлементТаблица = Элементы.ФайлыЛеваяПанель;
	ТаблицаПанели = ФайлыЛеваяПанель;

	ТекущиеДанные = ЭлементТаблица.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Для Каждого Строка Из ЭлементТаблица.ВыделенныеСтроки Цикл
		ТекущиеДанные = ТаблицаПанели.НайтиПоИдентификатору(Строка);
		УдалитьФайлы(ТекущиеДанные.ПолноеИмя);
	КонецЦикла;

	ОбновитьКлиент();
КонецПроцедуры

&НаКлиенте
Процедура УдалитьНаСервере(Команда)
	Если ПустаяСтрока(ТекущийКаталогСервер) Тогда
		Возврат;
	КонецЕсли;

	ЭлементТаблица = Элементы.ФайлыПраваяПанель;
	ТаблицаПанели = ФайлыПраваяПанель;

	ТекущиеДанные = ЭлементТаблица.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Для Каждого Строка Из ЭлементТаблица.ВыделенныеСтроки Цикл
		ТекущиеДанные = ТаблицаПанели.НайтиПоИдентификатору(Строка);
		УдалитьФайлыНаСервере(ТекущиеДанные.ПолноеИмя);
	КонецЦикла;

	ОбновитьСервер();

КонецПроцедуры

&НаКлиенте
Процедура ПереместитьССервераНаКлиент(Команда)
	СкопироватьНаКлиент(Неопределено);
	УдалитьНаСервере(Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ПереместитьСКлиентаНаСервер(Команда)
	СкопироватьНаСервер(Неопределено);
	УдалитьНаКлиенте(Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ПереименоватьНаСервере(Команда)
	Если ПустаяСтрока(ТекущийКаталогСервер) Тогда
		Возврат;
	КонецЕсли;

	ЭлементДерево = Элементы.ФайлыСервер;

	ТекущиеДанные = ЭлементДерево.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если ТекущиеДанные.ПолучитьРодителя() = Неопределено Тогда
		Возврат;
	КонецЕсли;

	НовоеИмя = ТекущиеДанные.Имя + ТекущиеДанные.Расширение;
	НовоеИмя = СтрЗаменить(НовоеИмя, РазделительПутиСервер, "");
	Если Не ВвестиСтроку(НовоеИмя) Тогда
		Возврат;
	КонецЕсли;

	ПереименоватьФайлНаСервере(ТекущиеДанные.ПолноеИмя, ТекущийКаталогСервер + НовоеИмя, РазделительПутиСервер);

	ОбновитьСервер();
КонецПроцедуры

&НаКлиенте
Процедура ПереименоватьНаКлиенте(Команда)
	Если ПустаяСтрока(ТекущийКаталогКлиент) Тогда
		Возврат;
	КонецЕсли;

	ЭлементДерево = Элементы.ФайлыЛеваяПанель;

	ТекущиеДанные = ЭлементДерево.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	//Если ТекущиеДанные.ПолучитьРодителя() = Неопределено Тогда
	//	Возврат;
	//КонецЕсли;

	НовоеИмя = ТекущиеДанные.Имя + ТекущиеДанные.Расширение;
	НовоеИмя = СтрЗаменить(НовоеИмя, РазделительПутиКлиент, "");
	Если Не ВвестиСтроку(НовоеИмя) Тогда
		Возврат;
	КонецЕсли;

	ПереименоватьФайлНаКлиенте(ТекущиеДанные.ПолноеИмя, ТекущийКаталогСервер + НовоеИмя, РазделительПутиКлиент);

	ОбновитьКлиент();
КонецПроцедуры

&НаКлиенте
Процедура ШагНазадКлиент(Команда)
	ШагНазад(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ШагВпередКлиент(Команда)
	ШагВперед(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ШагВверхКлиент(Команда)
	ПерейтиНаУровеньВыше(ФайлыЛеваяПанель, Истина);
КонецПроцедуры
&НаКлиенте
Процедура ШагНазадСервер(Команда)
	ШагНазад(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ШагВпередСервер(Команда)
	ШагВперед(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ШагВверхСервер(Команда)
	ПерейтиНаУровеньВыше(ФайлыПраваяПанель, Ложь);
КонецПроцедуры

&НаКлиенте
Процедура Копировать(Команда)
	ЭтоЛеваяПанель=ТекущаяТаблицаФайлов = Элементы.ФайлыЛеваяПанель.Имя;

	Если ЭтоЛеваяПанель Тогда
		СкопироватьНаСервер(Команды.СкопироватьНаСервер);
	Иначе
		СкопироватьНаКлиент(Команды.СкопироватьНаКлиент);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Переместить(Команда)
	ЭтоЛеваяПанель=ТекущаяТаблицаФайлов = Элементы.ФайлыЛеваяПанель.Имя;

	Если ЭтоЛеваяПанель Тогда
		ПереместитьСКлиентаНаСервер(Команды.ПереместитьСКлиентаНаСервер);
	Иначе
		ПереместитьССервераНаКлиент(Команды.ПереместитьССервераНаКлиент);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СоздатьКаталогКоманда(Команда)
	ЭтоЛеваяПанель=ТекущаяТаблицаФайлов = Элементы.ФайлыЛеваяПанель.Имя;

	ПоказатьВводСтроки(Новый ОписаниеОповещения("СоздатьКаталогЗавершениеВводаНаименования", ЭтотОбъект,
		Новый Структура("ИмяТаблицыФайлов,ЭтоЛеваяПанель", ТекущаяТаблицаФайлов, ЭтоЛеваяПанель)), ,
		"Введите наименование нового каталога");
КонецПроцедуры

&НаКлиенте
Процедура Удалить(Команда)
	ТекДанные=Элементы[ТекущаяТаблицаФайлов].ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ЭтоЛеваяПанель=ТекущаяТаблицаФайлов = Элементы.ФайлыЛеваяПанель.Имя;

	UT_CommonClient.ПоказатьВопросПользователю(
		Новый ОписаниеОповещения("УдалитьПослеПодтвержденияНеобходимости", ЭтотОбъект,
		Новый Структура("ЭтоЛеваяПанель,ПолноеИмя", ЭтоЛеваяПанель, ТекДанные.ПолноеИмя)), "Удалить выбранный файл?",
		РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_УстановитьПорядокСортировки(Команда)
	ПорядокСортировки=Прав(Команда.Имя, 4);

	ПрефиксЛевойПанели="ЛеваяПанельГруппаСортировка";
	ПрефиксПравойПанели="ПраваяПанельГруппаСортировка";

	ТаблицаДляСортировки=Неопределено;
	ПрефиксИмени=Неопределено;

	Если СтрНайти(Команда.Имя, ПрефиксЛевойПанели) > 0 Тогда
		ТаблицаДляСортировки=ФайлыЛеваяПанель;
		ПрефиксИмени=ПрефиксЛевойПанели;
	ИначеЕсли СтрНайти(Команда.Имя, ПрефиксПравойПанели) > 0 Тогда
		ТаблицаДляСортировки=ФайлыПраваяПанель;
		ПрефиксИмени=ПрефиксПравойПанели;
	КонецЕсли;

	Если ТаблицаДляСортировки = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ИмяПоляСортировки=СтрЗаменить(Команда.Имя, ПрефиксИмени, "");
	ИмяПоляСортировки=СтрЗаменить(ИмяПоляСортировки, ПорядокСортировки, "");

	ТаблицаДляСортировки.Сортировать("ЭтоКаталог УБЫВ, " + ИмяПоляСортировки + " " + ПорядокСортировки);

	Для Каждого Эл Из Элементы[Команда.Имя].Родитель.ПодчиненныеЭлементы Цикл
		Эл.Пометка=Ложь;
	КонецЦикла;

	Элементы[Команда.Имя].Пометка=Истина;
//	ЭлементыДерева=ФайлыКлиент.ПолучитьЭлементы().	
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ВыполнитьОбщуюКомандуИнструментов(Команда) 
	UT_CommonClient.Подключаемый_ВыполнитьОбщуюКомандуИнструментов(ЭтотОбъект, Команда);
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьРамкуТекущейПанели()
	ЭтоЛеваяПанель=ТекущаяТаблицаФайлов = Элементы.ФайлыЛеваяПанель.Имя;
	
	Если ЭтоЛеваяПанель Тогда
		АктивнаяПанель=Элементы.ФайлыЛеваяПанель;
		НеАктивнаяПанель=Элементы.ФайлыПраваяПанель;
	Иначе
		АктивнаяПанель=Элементы.ФайлыПраваяПанель;
		НеАктивнаяПанель=Элементы.ФайлыЛеваяПанель;
	КонецЕсли;
	
	АктивнаяПанель.ЦветРамки=WebЦвета.Красный;
	НеАктивнаяПанель.ЦветРамки=Новый Цвет;
КонецПроцедуры

&НаКлиенте
Процедура УдалитьПослеПодтвержденияНеобходимости(РезультатВопроса, ДополнительныеПараметры) Экспорт
	Если РезультатВопроса <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;

	Если ДополнительныеПараметры.ЭтоЛеваяПанель Тогда

		НачатьУдалениеФайлов(Новый ОписаниеОповещения("УдалитьФайлЗавершение", ЭтотОбъект, ДополнительныеПараметры),
			ДополнительныеПараметры.ПолноеИмя);
	Иначе
		УдалитьФайлыНаСервере(ДополнительныеПараметры.ПолноеИмя);
		УдалитьФайлЗавершение(ДополнительныеПараметры);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УдалитьФайлЗавершение(ДополнительныеПараметры) Экспорт
	Если ДополнительныеПараметры.ЭтоЛеваяПанель Тогда
		ОбновитьКлиент();
	Иначе
		ОбновитьСервер();
	КонецЕсли;

КонецПроцедуры
&НаСервереБезКонтекста
Функция СоздатьКаталогНаСервере(ПолноеИмя)
	Файл=Новый Файл(ПолноеИмя);
	Если Файл.Существует() Тогда
		UT_CommonClientServer.MessageToUser("Такой каталог уже существует");

		Возврат Неопределено;
	КонецЕсли;

	СоздатьКаталог(Файл.ПолноеИмя);

	Возврат Файл.ПолноеИмя;
КонецФункции

&НаКлиенте
Процедура СоздатьКаталогЗавершениеВводаНаименования(Строка, ДополнительныеПараметры) Экспорт
	Если Строка = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(Строка) Тогда
		Возврат;
	КонецЕсли;

	ЭтоЛеваяПанель=ДополнительныеПараметры.ЭтоЛеваяПанель;
	Если ЭтоЛеваяПанель Тогда
		ТекущийКаталог=ТекущийКаталогКлиент;
	Иначе
		ТекущийКаталог=ТекущийКаталогСервер;
	КонецЕсли;

	
	//Проверяем существование каталога

	ДопПараметрыОповещения=ДополнительныеПараметры;
	ДопПараметрыОповещения.Вставить("ТекущийКаталог", ТекущийКаталог);

	ФайлПолноеИмя=ТекущийКаталог + Строка;

	Если ЭтоЛеваяПанель Тогда
		Файл=Новый Файл(ФайлПолноеИмя);
		ДопПараметрыОповещения.Вставить("Файл", Файл);

		Файл.НачатьПроверкуСуществования(
		Новый ОписаниеОповещения("СоздатьКаталогЗавершениеПроверкиСуществованияНовогоКаталога", ЭтотОбъект,
			ДопПараметрыОповещения));
	Иначе
		Результат=СоздатьКаталогНаСервере(ФайлПолноеИмя);
		Если Результат = Неопределено Тогда
			Возврат;
		КонецЕсли;

		СоздатьКаталогЗавершениеСозданияКаталога(Результат, ДопПараметрыОповещения);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СоздатьКаталогЗавершениеПроверкиСуществованияНовогоКаталога(Существует, ДополнительныеПараметры) Экспорт
	Если Существует Тогда
		UT_CommonClientServer.MessageToUser("Такой каталог уже существует");
		Возврат;
	КонецЕсли;

	НачатьСозданиеКаталога(Новый ОписаниеОповещения("СоздатьКаталогЗавершениеСозданияКаталога", ЭтотОбъект,
		ДополнительныеПараметры), ДополнительныеПараметры.Файл.ПолноеИмя);
КонецПроцедуры

&НаКлиенте
Процедура СоздатьКаталогЗавершениеСозданияКаталога(ИмяКаталога, ДополнительныеПараметры) Экспорт

	Если ДополнительныеПараметры.ЭтоЛеваяПанель Тогда
		ТекущийКаталогКлиент=ИмяКаталога;
		ОбновитьКлиент();
	Иначе
		ТекущийКаталогСервер=ИмяКаталога;
		ОбновитьСервер();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ШагНазад(ЭтоЛеваяТаблица)
	Если ЭтоЛеваяТаблица Тогда
		ИмяПоляТекущегоКаталога="ТекущийКаталогКлиент";
	Иначе
		ИмяПоляТекущегоКаталога="ТекущийКаталогСервер";
	КонецЕсли;

	ЭлементСписок = Элементы[ИмяПоляТекущегоКаталога].СписокВыбора;
	ТекущееЗначение = ЭтотОбъект[ИмяПоляТекущегоКаталога];

	НайденныйЭлемент = ЭлементСписок.НайтиПоЗначению(ТекущееЗначение);
	Если НайденныйЭлемент = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Индекс = ЭлементСписок.Индекс(НайденныйЭлемент);
	Если Индекс + 1 < ЭлементСписок.Количество() - 1 Тогда
		ЭтотОбъект[ИмяПоляТекущегоКаталога] = ЭлементСписок[Индекс + 1].Значение;
		Если ЭтоЛеваяТаблица Тогда
			ОбновитьКлиент();
		Иначе
			ОбновитьСервер();
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ШагВперед(ЭтоЛеваяТаблица)
	Если ЭтоЛеваяТаблица Тогда
		ИмяПоляТекущегоКаталога="ТекущийКаталогКлиент";
	Иначе
		ИмяПоляТекущегоКаталога="ТекущийКаталогСервер";
	КонецЕсли;

	ЭлементСписок = Элементы[ИмяПоляТекущегоКаталога].СписокВыбора;
	ТекущееЗначение = ЭтотОбъект[ИмяПоляТекущегоКаталога];

	НайденныйЭлемент = ЭлементСписок.НайтиПоЗначению(ТекущееЗначение);
	Если НайденныйЭлемент = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Индекс = ЭлементСписок.Индекс(НайденныйЭлемент);
	Если Индекс > 0 Тогда
		ЭтотОбъект[ИмяПоляТекущегоКаталога] = ЭлементСписок[Индекс - 1].Значение;
		Если ЭтоЛеваяТаблица Тогда
			ОбновитьКлиент();
		Иначе
			ОбновитьСервер();
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиНаУровеньВыше(ТаблицаФайлов, ЭтоЛеваяТаблица)
	ПерейтиВКаталог(ТаблицаФайлов, "..", ЭтоЛеваяТаблица);
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиВКаталог(ТаблицаФайлов, ПолноеИмяНовогоКаталога, ЭтоЛеваяТаблица)
	Если ЭтоЛеваяТаблица Тогда
		ИмяПоляКаталога="ТекущийКаталогКлиент";
		РазделительПути=РазделительПутиКлиент;
	Иначе
		ИмяПоляКаталога="ТекущийКаталогСервер";
		РазделительПути=РазделительПутиСервер;
	КонецЕсли;

	ТекущийКаталог=ЭтотОбъект[ИмяПоляКаталога];
	НовыйКаталог="";

	Если ПолноеИмяНовогоКаталога = ".." Тогда
		МассивСтрокКаталога=СтрРазделить(ТекущийКаталог, РазделительПути, Истина);
		Если Не ЗначениеЗаполнено(МассивСтрокКаталога[МассивСтрокКаталога.Количество()-1]) Тогда
			МассивСтрокКаталога.Удалить(МассивСтрокКаталога.Количество() - 1);
		КонецЕсли;
		
		Если МассивСтрокКаталога.Количество() = 0 Тогда
			НовыйКаталог="";
		Иначе
			
			МассивСтрокКаталога.Удалить(МассивСтрокКаталога.Количество() - 1);

			//МассивСтрокКаталога.Вставить(0, "");
			МассивСтрокКаталога.Добавить("");

			НовыйКаталог=СтрСоединить(МассивСтрокКаталога, РазделительПути);
		КонецЕсли;
	Иначе
		НовыйКаталог = ПолноеИмяНовогоКаталога;
	КонецЕсли;

	ЭтотОбъект[ИмяПоляКаталога] = НовыйКаталог;

	Если ЭтоЛеваяТаблица Тогда
		ОбновитьКлиент();
		ОбновитьИсториюКлиент();
	Иначе
		ОбновитьСервер();

		ОбновитьИсториюСервер();
	КонецЕсли;

КонецПроцедуры
&НаСервере
Процедура ЗаполнитьПодменюСортировок()
	ПоляУпорядочивания=Новый Структура;
	ПоляУпорядочивания.Вставить("Имя", "Имя");
	ПоляУпорядочивания.Вставить("Расширение", "Расширение");
	ПоляУпорядочивания.Вставить("ДатаИзменения", "Дата изменения");
	ПоляУпорядочивания.Вставить("Размер", "Размер");

	НаправленияСортировки=Новый Структура;
	НаправленияСортировки.Вставить("ВОЗР", " +");
	НаправленияСортировки.Вставить("УБЫВ", " -");

	МассивПодменю=Новый Массив;
	МассивПодменю.Добавить(Элементы.ЛеваяПанельГруппаСортировка);
	МассивПодменю.Добавить(Элементы.ПраваяПанельГруппаСортировка);

	Для Каждого ТекПодменю Из МассивПодменю Цикл
		Для Каждого ПолеУпорядочивания Из ПоляУпорядочивания Цикл
			Для Каждого Направление Из НаправленияСортировки Цикл
				//Сначала добавляем команду, а потом кнопку
				ОписаниеКоманды=UT_Forms.НовыйОписаниеКомандыКнопки();
				ОписаниеКоманды.Имя=ТекПодменю.Имя + ПолеУпорядочивания.Ключ + Направление.Ключ;
				ОписаниеКоманды.Заголовок=ПолеУпорядочивания.Значение + Направление.Значение;
				ОписаниеКоманды.Действие="Подключаемый_УстановитьПорядокСортировки";
				ОписаниеКоманды.РодительЭлемента=ТекПодменю;
				ОписаниеКоманды.Картинка=Новый Картинка;
				ОписаниеКоманды.ИмяКоманды=ОписаниеКоманды.Имя;

				UT_Forms.СоздатьКомандуПоОписанию(ЭтотОбъект, ОписаниеКоманды);
				UT_Forms.СоздатьКнопкуПоОписанию(ЭтотОбъект, ОписаниеКоманды);
			КонецЦикла;
		КонецЦикла;

		Элементы[ТекПодменю.Имя + "ИмяВОЗР"].Пометка=Истина;
	КонецЦикла;
КонецПроцедуры

&НаСервереБезКонтекста
Процедура РазвернутьФайлНаСервере(АдресВХранилище, КонечноеИмяФайла)
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресВХранилище);
	ДвоичныеДанные.Записать(КонечноеИмяФайла);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДеревоФайлов(НаКлиенте = Истина)
	Если НаКлиенте = Ложь Тогда
		ЭлементДерево = Элементы.ФайлыЛеваяПанель;
		ТаблицаФайловКаталога = ФайлыПраваяПанель;
		ТекущийКаталог = ТекущийКаталогСервер;
		ФайлыТекущегоКаталога = ПолучитьСодержимоеКаталогаНаСервере(ТекущийКаталог, РазделительПутиСервер,
			WindowsСервер);
		ТекущийРазделительПути=РазделительПутиСервер;
		ЭтоWindows=WindowsСервер;
	Иначе
		ЭлементДерево = Элементы.ФайлыЛеваяПанель;
		ТаблицаФайловКаталога = ФайлыЛеваяПанель;
		ТекущийКаталог = ТекущийКаталогКлиент;
		ФайлыТекущегоКаталога = ПолучитьСодержимоеКаталогаНаКлиенте(ТекущийКаталог);
		ТекущийРазделительПути=РазделительПутиКлиент;
		ЭтоWindows=WindowsКлиент;

	КонецЕсли;

	ТаблицаФайловКаталога.Очистить();

//	ТекущийРодитель = Дерево;
	ПолноеИмя = "";
	ПутьДляРазбора = СтрЗаменить(ТекущийКаталог, ТекущийРазделительПути + ТекущийРазделительПути, ":::");
	ИндексКартинки = 6;
	Если ПустаяСтрока(ТекущийКаталог) И ЭтоWindows Тогда
		Если ЭтоWindows Тогда
			Если НаКлиенте Тогда
				Диски = ПолучитьСписокДисковWindowsНаКлиенте(ТекущийРазделительПути);
			Иначе
				Диски = ПолучитьСписокДисковWindowsНаСервере(ТекущийРазделительПути);
			КонецЕсли;
			Для Каждого ИмяДиска Из Диски Цикл
				НоваяСтрока = ТаблицаФайловКаталога.Добавить();
				НоваяСтрока.ИндексКартинки = 2;
				НоваяСтрока.Имя = ИмяДиска;
				НоваяСтрока.ЭтоКаталог = Истина;
				НоваяСтрока.ПолноеИмя = НоваяСтрока.Имя;
			КонецЦикла;

			Возврат;

		КонецЕсли;
//	ИначеЕсли Не ЭтоWindows Тогда
//		ТекущийРодитель = ТекущийРодитель.ПолучитьЭлементы().Добавить();
//		ТекущийРодитель.ИндексКартинки = ИндексКартинки;
//		ТекущийРодитель.Имя = ТекущийРазделительПути;
//		ТекущийРодитель.ЭтоКаталог = Истина;
//		ТекущийРодитель.ПолноеИмя = ТекущийРазделительПути;
//		ИндексКартинки = 1;
//
//		Если СтрНачинаетсяС(ПутьДляРазбора, ТекущийРазделительПути) Тогда
//			ПутьДляРазбора=Сред(ПутьДляРазбора, 2);
//		КонецЕсли;
	КонецЕсли;

//	МассивТекущийПуть = СтрРазделить(ПутьДляРазбора, ТекущийРазделительПути);//РазложитьСтрокуВМассивПодстрок(ПутьДляРазбора, ТекущийРазделительПути);
//	Для Каждого ИмяКаталога Из МассивТекущийПуть Цикл
//		Если ПустаяСтрока(ИмяКаталога) Тогда
//			Прервать;
//		КонецЕсли;
//
//		ИмяКаталога = СтрЗаменить(ИмяКаталога, ":::", ТекущийРазделительПути + ТекущийРазделительПути);
//
//		ПолноеИмя = ПолноеИмя + ИмяКаталога + ТекущийРазделительПути;
//		ТекущийРодитель = ТекущийРодитель.ПолучитьЭлементы().Добавить();
//		ТекущийРодитель.ИндексКартинки = ИндексКартинки;
//		ТекущийРодитель.Имя = ИмяКаталога + ТекущийРазделительПути;
//		ТекущийРодитель.ЭтоКаталог = Истина;
//		ТекущийРодитель.ПолноеИмя = ТекущийРазделительПути + ПолноеИмя;
//		ИндексКартинки = 1;
//	КонецЦикла;

	Для Каждого СтрокаСтруктура Из ФайлыТекущегоКаталога Цикл
		ЗаполнитьЗначенияСвойств(ТаблицаФайловКаталога.Добавить(), СтрокаСтруктура);
	КонецЦикла;

	ТаблицаФайловКаталога.Сортировать("ЭтоКаталог УБЫВ, Имя");
//	Если ТипЗнч(ТекущийРодитель) = Тип("ДанныеФормыЭлементДерева") Тогда
//		ЭлементДерево.ТекущаяСтрока = ТекущийРодитель.ПолучитьИдентификатор();
//		ЭлементДерево.Развернуть(ЭлементДерево.ТекущаяСтрока);
//	КонецЕсли;

	Если ЗначениеЗаполнено(ТекущийКаталог) И ТекущийКаталог <> ТекущийРазделительПути Тогда
		НоваяСтрока = ТаблицаФайловКаталога.Вставить(0);
		НоваяСтрока.ИндексКартинки = 2;
		НоваяСтрока.Имя = "[..]";
		НоваяСтрока.ЭтоКаталог = Истина;
		НоваяСтрока.ПолноеИмя = "..";
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИсториюКлиент()
	ОбновитьИсторию(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИсториюСервер()
	ОбновитьИсторию(Ложь);
КонецПроцедуры
&НаКлиенте
Процедура ОбновитьИсторию(НаКлиенте = Истина)
	Если НаКлиенте = Ложь Тогда
		ТекущийКаталог = ТекущийКаталогСервер;
		ЭлементТекущийКаталог = Элементы.ТекущийКаталогСервер;
		СписокИстория = ИсторияВыбораСервер;
	Иначе
		ТекущийКаталог = ТекущийКаталогКлиент;
		ЭлементТекущийКаталог = Элементы.ТекущийКаталогКлиент;
		СписокИстория = ИсторияВыбораКлиент;
	КонецЕсли;

	НайденныйЭлемент = СписокИстория.НайтиПоЗначению(ТекущийКаталог);
	Если Не НайденныйЭлемент = Неопределено Тогда
		СписокИстория.Удалить(НайденныйЭлемент);
	КонецЕсли;
	СписокИстория.Вставить(0, ТекущийКаталог);

	РазмерСпискаИстории = 25;
	Пока РазмерСпискаИстории < СписокИстория.Количество() Цикл
		СписокИстория.Удалить(СписокИстория.Количество() - 1);
	КонецЦикла;

	ЭлементТекущийКаталог.СписокВыбора.ЗагрузитьЗначения(СписокИстория.ВыгрузитьЗначения());
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьСодержимоеКаталогаНаСервере(Каталог, РазделительПути, ЭтоWindows)
	Возврат ПолучитьСодержимоеКаталога(Каталог, РазделительПути, ЭтоWindows);
КонецФункции

&НаКлиенте
Функция ПолучитьСодержимоеКаталогаНаКлиенте(Каталог)
	Возврат ПолучитьСодержимоеКаталога(Каталог, РазделительПутиКлиент, WindowsКлиент);
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьСодержимоеКаталога(Каталог, РазделительПути, ЭтоWindows)
	Результат = Новый Массив;

	Файлы = НайтиФайлы(Каталог, "*", Ложь);
	Для Каждого Файл Из Файлы Цикл
		Если Ложь Тогда
			Файл = Новый Файл;
		КонецЕсли;

//		Если Не ЭтоWindows И Лев(Файл.ПолноеИмя, 2) = "//" Тогда
//			Файл=Новый Файл(Сред(Файл.ПолноеИмя, 2));
//		Иначе
//			Файл
//		КонецЕсли;

//		Если Не Файл.Существует() Тогда
//			Продолжить
//		КонецЕсли;

		Если Не Файл.Существует() Тогда
			ЭтоКаталог=Ложь;
		Иначе
			ЭтоКаталог=Файл.ЭтоКаталог();
		КонецЕсли;

		ПолноеИмяФайла=Файл.ПолноеИмя + ?(ЭтоКаталог, РазделительПути, "");
		Если Не ЭтоWindows И Лев(Файл.ПолноеИмя, 2) = "//" Тогда
			ПолноеИмяФайла=Сред(Файл.ПолноеИмя, 2);
		КонецЕсли;

		Если ПолноеИмяФайла = "/./" Или ПолноеИмяФайла = "/../" 
			Или ПолноеИмяФайла="/." Или ПолноеИмяФайла= "/.." Тогда
			Продолжить;
		КонецЕсли;

		СтрокаСтруктура = Новый Структура;

		СтрокаСтруктура.Вставить("ЭтоКаталог", ЭтоКаталог);
		СтрокаСтруктура.Вставить("ПолноеИмя", ПолноеИмяФайла);

		Если СтрокаСтруктура.ЭтоКаталог Тогда
			Если ЗначениеЗаполнено(Файл.Имя) Тогда
				ИмяФайла=Файл.Имя;
			Иначе
				ИмяФайла=СтрЗаменить(Файл.Путь, РазделительПути, "");
			КонецЕсли;

			ИмяФайла=ИмяФайла + РазделительПути;
		Иначе
			ИмяФайла=Файл.ИмяБезРасширения;
		КонецЕсли;

		Если Не ЗначениеЗаполнено(ИмяФайла) Тогда
			ИмяФайла=ПолноеИмяФайла;

			Если Не СтрокаСтруктура.ЭтоКаталог И СтрНачинаетсяС(ИмяФайла, РазделительПути) Тогда
				ИмяФайла=Сред(ИмяФайла, 2);
			КонецЕсли;
		КонецЕсли;
		СтрокаСтруктура.Вставить("Имя", ИмяФайла);
		СтрокаСтруктура.Вставить("Расширение", ?(СтрокаСтруктура.ЭтоКаталог, "", Файл.Расширение));
		СтрокаСтруктура.Вставить("ИндексКартинки", ИндексКартинки(СтрокаСтруктура.Расширение,
			СтрокаСтруктура.ЭтоКаталог));

		Попытка
			СтрокаСтруктура.Вставить("ДатаИзменения", Файл.ПолучитьВремяИзменения());
		Исключение
			СтрокаСтруктура.Вставить("ДатаИзменения", '00010101');
		КонецПопытки;

		Если Не СтрокаСтруктура.ЭтоКаталог Тогда
			Попытка
				СтрокаСтруктура.Вставить("Размер", Файл.Размер() / 1000);
			Исключение
				СтрокаСтруктура.Вставить("Размер", 0);
			КонецПопытки;
		КонецЕсли;
		СтрокаСтруктура.Вставить("Представление", Формат(СтрокаСтруктура.ДатаИзменения, "ДФ='yyyy-MM-dd HH:MM:ss'"));

		Результат.Добавить(СтрокаСтруктура);
	КонецЦикла;

//	Результат.СортироватьПоПредставлению(НаправлениеСортировки.Убыв);
//	Возврат Результат.ВыгрузитьЗначения();

	Возврат Результат;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ИндексКартинки(Знач Расширение, ЭтоКаталог)
	Если ЭтоКаталог Тогда
		Возврат 2;
	Иначе
		Возврат UT_CommonClientServer.GetFileIconIndex(Расширение);
	КонецЕсли;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьСписокДисковWindows(РазделительПути)
	Результат = Новый Массив;

	Для сч = 0 По 25 Цикл
		БукваДиска = Символ(КодСимвола("A") + сч) + ":" + РазделительПути;
		Если НайтиФайлы(БукваДиска).Количество() > 0 Тогда
			Результат.Добавить(БукваДиска);
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьСписокДисковWindowsНаСервере(РазделительПути)
	Возврат ПолучитьСписокДисковWindows(РазделительПути);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокДисковWindowsНаКлиенте(РазделительПути)
	Возврат ПолучитьСписокДисковWindows(РазделительПути);
КонецФункции


&НаСервереБезКонтекста
Функция ИмяКаталонаНаСервере(ИмяКаталога)
	Возврат Вычислить(ИмяКаталога + "()");
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция РазмерФайла(РазмерФайлаВБайтах, ЕдиницаИзмерения)
	ЕдиницаИзмерения = "КБ";
	Возврат РазмерФайлаВБайтах / 1000;
КонецФункции

&НаСервереБезКонтекста
Процедура УдалитьФайлыНаСервере(ИмяФайла)
	УдалитьФайлы(ИмяФайла);
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПоместитьВоВременноеХранилищеНаСервере(ИсходныйФайл, ИдентификаторФормы)
	ДвоичныеДанные = Новый ДвоичныеДанные(ИсходныйФайл);
	АдресВХранилище = ПоместитьВоВременноеХранилище(ДвоичныеДанные, ИдентификаторФормы);
	Возврат АдресВХранилище;
КонецФункции

&НаСервереБезКонтекста
Функция НайтиВсеФайлыНаСервере(ТекущийКаталог, РазделительПути, УникальныйИдентификаторФормы)
	Результат = Новый Массив;

	НайденныеФайлы = НайтиФайлы(ТекущийКаталог, "*", Истина);
	Для Каждого Файл Из НайденныеФайлы Цикл
		СтрокаСтруктура = Новый Структура;
		Результат.Добавить(СтрокаСтруктура);

		СтрокаСтруктура.Вставить("ЭтоКаталог", Файл.ЭтоКаталог());
		СтрокаСтруктура.Вставить("ПолноеИмя", Файл.ПолноеИмя + ?(СтрокаСтруктура.ЭтоКаталог, РазделительПути, ""));
		СтрокаСтруктура.Вставить("АдресВХранилище", ПоместитьВоВременноеХранилище(
			Новый ДвоичныеДанные(СтрокаСтруктура.ПолноеИмя), УникальныйИдентификаторФормы));
	КонецЦикла;

	Возврат Результат;
КонецФункции

&НаКлиенте
Функция НайтиВсеФайлыНаКлиенте(ТекущийКаталог, РазделительПути, УникальныйИдентификаторФормы)
	Результат = Новый Массив;

	НайденныеФайлы = НайтиФайлы(ТекущийКаталог, "*", Истина);
	Для Каждого Файл Из НайденныеФайлы Цикл
		СтрокаСтруктура = Новый Структура;
		Результат.Добавить(СтрокаСтруктура);

		СтрокаСтруктура.Вставить("ЭтоКаталог", Файл.ЭтоКаталог());
		СтрокаСтруктура.Вставить("ПолноеИмя", Файл.ПолноеИмя + ?(СтрокаСтруктура.ЭтоКаталог, РазделительПути, ""));
		СтрокаСтруктура.Вставить("АдресВХранилище", ПоместитьВоВременноеХранилище(
			Новый ДвоичныеДанные(СтрокаСтруктура.ПолноеИмя), УникальныйИдентификаторФормы));

	КонецЦикла;

	Возврат Результат;
КонецФункции

&НаСервереБезКонтекста
Процедура ПереименоватьФайлНаСервере(ИмяФайлаИсточника, ИмяФайлаПриемника, РазделительПути)
	Файл = Новый Файл(ИмяФайлаИсточника);
	Если Файл.ЭтоФайл() Тогда
		ПереместитьФайл(ИмяФайлаИсточника, ИмяФайлаПриемника);
	Иначе
		МассивСлов = СтрРазделить(ИмяФайлаПриемника, РазделительПути);
		Если ПустаяСтрока(МассивСлов[МассивСлов.ВГраница()]) Тогда
			МассивСлов.Удалить(МассивСлов.ВГраница());
		КонецЕсли;
		//ФСО = Новый COMОбъект("Scripting.FileSystemObject");

		//ФСО.GetFolder(ИмяФайлаИсточника).Name = МассивСлов[МассивСлов.ВГраница()];
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПереименоватьФайлНаКлиенте(ИмяФайлаИсточника, ИмяФайлаПриемника, РазделительПути)
	Файл = Новый Файл(ИмяФайлаИсточника);
	//Если Файл.ЭтоФайл() Тогда
		ПереместитьФайл(ИмяФайлаИсточника, ИмяФайлаПриемника);
	//Иначе
	//	МассивСлов = СтрРазделить(ИмяФайлаПриемника, РазделительПути);
	//	Если ПустаяСтрока(МассивСлов[МассивСлов.ВГраница()]) Тогда
	//		МассивСлов.Удалить(МассивСлов.ВГраница());
	//	КонецЕсли;
	//	//ФСО = Новый COMОбъект("Scripting.FileSystemObject");

	//	//ФСО.GetFolder(ИмяФайлаИсточника).Name = МассивСлов[МассивСлов.ВГраница()];
	//КонецЕсли;

КонецПроцедуры


#КонецОбласти