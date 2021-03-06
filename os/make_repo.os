//////////////////////////////////////////////////////////////////////
// Скрипт создания базовых каталогов

Процедура СформироватьРепозиторий()
	КаталогРепо = "D:\repo";
	
	текКаталог = ТекущийКаталог();

	ЗапуститьПриложение("git init", текКаталог, Истина);

	КаталогиСоздания = Новый Массив();
	КаталогиСоздания.Добавить("doc");
	КаталогиСоздания.Добавить("examples");
	КаталогиСоздания.Добавить("features");
	КаталогиСоздания.Добавить("lib");
	КаталогиСоздания.Добавить("license");
	КаталогиСоздания.Добавить("spec");
	КаталогиСоздания.Добавить("src");
	КаталогиСоздания.Добавить("tools");
	КаталогиСоздания.Добавить("vendor");

	Для каждого КаталогСоздания из КаталогиСоздания Цикл
		СоздатьКаталог(текКаталог +"\"+ КаталогСоздания);
		Сообщить("Создан каталог " + КаталогСоздания);
	КонецЦикла;

	Текст = Новый ТекстовыйДокумент;	
	ИмяФайла = "README.md";
	Текст.Записать(текКаталог + "\" + ИмяФайла);
	Сообщить("Создан файл " + ИмяФайла);
	
	ФайлыКопирования = Новый Массив();
	ФайлыКопирования.Добавить("pre-commit");
	ФайлыКопирования.Добавить("v8files-extractor.os");
	
	Для каждого ОбъектКопирования из ФайлыКопирования Цикл
		КопироватьФайл(КаталогРепо +"\precommit1c\"+ ОбъектКопирования,текКаталог + "\.git\hooks\" + ОбъектКопирования);
		Сообщить("Скопирован файл " + ОбъектКопирования);
	КонецЦикла;

	КаталогиКопирования = Новый Массив();
	КаталогиКопирования.Добавить("tools");
	КаталогиКопирования.Добавить("v8Reader");
	
	Для каждого ОбъектКопирования из КаталогиКопирования Цикл
		ЗапуститьПриложение("xcopy " + КаталогРепо + "\precommit1c\" + ОбъектКопирования + " " + текКаталог + "\.git\hooks\" +  ОбъектКопирования + "\ /S /E", Истина);
		Сообщить("Скопирован каталог " + ОбъектКопирования);
	КонецЦикла;
	
КонецПроцедуры 
   
   СформироватьРепозиторий();