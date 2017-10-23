﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПодготавливаюВспомогательныеДанныеПродажи()","ЯПодготавливаюВспомогательныеДанныеПродажи","Допустим я подготавливаю вспомогательные данные продажи","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСоздаюДокументПродажа()","ЯСоздаюДокументПродажа","Когда я создаю документ Продажа","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗаполняюШапкуДокументаПродажи()","ЯЗаполняюШапкуДокументаПродажи","И я заполняю шапку документа продажи","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗаполняюТабличнуюЧастьДокументаПродажи()","ЯЗаполняюТабличнуюЧастьДокументаПродажи","И я заполняю табличную часть документа продажи","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПровожуДокументПродажи()","ЯПровожуДокументПродажи","И я провожу документ продажи","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"РезультатПроведенияПродажиКорректен()","РезультатПроведенияПродажиКорректен","Тогда результат проведения продажи корректен","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПолучаюСообщениеОбОшибкеОНехваткеТовара(НазваниеТовара)","ЯПолучаюСообщениеОбОшибкеОНехваткеТовара","я получаю сообщение об ошибке о нехватке товара","","");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции

&НаКлиенте
Функция ПолучитьПутьКФайлОтносительноКаталогоFeatures(ИмяФайлаСРасширением)
	ПутьКФайлу = "";
	
	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();
	
	ПутьКТекущемуFeatureФайлу = СостояниеVanessaBehavior.ТекущаяФича.ПолныйПуть;
	
	ПутьКФайлу = Лев(ПутьКТекущемуFeatureФайлу, Найти(ПутьКТекущемуFeatureФайлу, "features") - 1) + ИмяФайлаСРасширением;
	                  
	Возврат ПутьКФайлу;
КонецФункции

&НаКлиенте
Процедура ЗагрузитьFixtureИзМакета(ИмяМакета)
	Ванесса.ЗапретитьВыполнениеШагов();
	
	НачальноеИмяФайла = ПолучитьПутьКФайлОтносительноКаталогоFeatures("tools\Выгрузка и загрузка данных XML.epf");
	
	Адрес = "";
	
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗагрузитьFixtureИзМакетаЗавершение", ЭтотОбъект, ИмяМакета), Адрес, НачальноеИмяФайла, Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьFixtureИзМакетаЗавершение(УдалосьПоместитьФайл, Адрес, ВыбранноеИмяФайла, ИмяМакета) Экспорт
	ЗагрузитьFixtureИзМакетаЗавершениеНаСервере(Адрес, ИмяМакета);
	
	Ванесса.ПродолжитьВыполнениеШагов();
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьFixtureИзМакетаЗавершениеНаСервере(Адрес, ИмяМакета)
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(Адрес);
	ДвоичныеДанные.Записать(ИмяВременногоФайла);
	
	ВнешняяОбработка = ВнешниеОбработки.Создать(ИмяВременногоФайла, Ложь);
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	
	Текст = РеквизитФормыВЗначение("Объект").ПолучитьМакет(ИмяМакета).ПолучитьТекст();
	
	ВременныйДокумент = Новый ТекстовыйДокумент;
	ВременныйДокумент.УстановитьТекст(Текст);
	ВременныйДокумент.Записать(ИмяВременногоФайла, КодировкаТекста.UTF8);

	ВнешняяОбработка.ВыполнитьЗагрузку(ИмяВременногоФайла);
КонецПроцедуры


///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Допустим я подготавливаю вспомогательные данные
//@ЯПодготавливаюВспомогательныеДанные()
Процедура ЯПодготавливаюВспомогательныеДанныеПродажи() Экспорт
	ЗагрузитьFixtureИзМакета("ЗагрузкаНоменклатуры");
	ЗагрузитьFixtureИзМакета("ЗагрузкаСотрудников");
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	//ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//Когда я создаю документ Продажа
//@ЯСоздаюДокументПродажа()
Процедура ЯСоздаюДокументПродажа() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я заполняю шапку документа
//@ЯЗаполняюШапкуДокумента()
Процедура ЯЗаполняюШапкуДокументаПродажи() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я заполняю табличную часть документа
//@ЯЗаполняюТабличнуюЧастьДокумента()
Процедура ЯЗаполняюТабличнуюЧастьДокументаПродажи() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я провожу документ
//@ЯПровожуДокумент()
Процедура ЯПровожуДокументПродажи() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//Тогда результат проведения корректен
//@РезультатПроведенияКорректен()
Процедура РезультатПроведенияПродажиКорректен() Экспорт
	//ТекИнфо = КонтекстСохраняемый.ТестовоеПриложение.ПолучитьТекущуюИнформациюОбОшибке();
	актОкно = КонтекстСохраняемый.ТестовоеПриложение.ПолучитьАктивноеОкно();
	
	Попытка
		массИнфо = актОкно.ПолучитьТекстыСообщенийПользователю();
		Если массИнфо.Количество()>0 Тогда
			ВызватьИсключение ""; //в окне сообщений есть сообщения
		КонецЕсли;
	Исключение
		ВызватьИсключение ""; //появление системного окна ошибки о невозможности провести документ
	КонецПопытки;
	
	//массИнфо = Новый массив;
	
	//ТипзанчСтрока = ТипЗнч(ТекИнфо);
	//СообщТЗ = Новый СообщениеПользователю;
	//СообщТЗ.Текст = "Тип значения инфо об ошибке строк сообщений = " + массИнфо.Количество();
	//СообщТЗ.Сообщить();
	
	//Нехватка = Ложь;
	//сообщ = Новый СообщениеПользователю;
	//сообщ.Текст = "Предполагаемое сообщение о проблеме: " + ТекИнфо;
	//сообщ.Сообщить();
	//Если СтрНайти(ТекИнфо,"не удалось")>0 Тогда
	//	Нехватка = Истина;
	//	сообщ.Текст = " перехватили <не удалось> - есть нехватка остатков";
	//Иначе
	//	сообщ.Текст = " перехватили <не удалось> - остатка хватает";
	//КонецЕсли;
	//сообщ.Сообщить();
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	//ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//Тогда результат проведения корректен
//@РезультатПроведенияКорректен()
Процедура ЯПолучаюСообщениеОбОшибкеОНехваткеТовара(НазваниеТовара) Экспорт
	//ТекИнфо = КонтекстСохраняемый.ТестовоеПриложение.ПолучитьТекущуюИнформациюОбОшибке();
	актОкно = КонтекстСохраняемый.ТестовоеПриложение.ПолучитьАктивноеОкно();
	
	ЕстьКомментОНехватке = Ложь;
	Попытка
		массИнфо = актОкно.ПолучитьТекстыСообщенийПользователю();
		Для каждого Инфо из массИнфо Цикл
			Если СтрНайти(Инфо,НазваниеТовара)>0 Тогда
				ЕстьКомментОНехватке = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	Исключение
	КонецПопытки;
	
	Если не ЕстьКомментОНехватке Тогда
		ВызватьИсключение ""; //если нет сообщения о нехватке указанного товара
	КонецЕсли;
	
	//массИнфо = Новый массив;
	
	//ТипзанчСтрока = ТипЗнч(ТекИнфо);
	//СообщТЗ = Новый СообщениеПользователю;
	//СообщТЗ.Текст = "Тип значения инфо об ошибке строк сообщений = " + массИнфо.Количество();
	//СообщТЗ.Сообщить();
	
	//Нехватка = Ложь;
	//сообщ = Новый СообщениеПользователю;
	//сообщ.Текст = "Предполагаемое сообщение о проблеме: " + ТекИнфо;
	//сообщ.Сообщить();
	//Если СтрНайти(ТекИнфо,"не удалось")>0 Тогда
	//	Нехватка = Истина;
	//	сообщ.Текст = " перехватили <не удалось> - есть нехватка остатков";
	//Иначе
	//	сообщ.Текст = " перехватили <не удалось> - остатка хватает";
	//КонецЕсли;
	//сообщ.Сообщить();
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	//ВызватьИсключение "Не реализовано.";
КонецПроцедуры
