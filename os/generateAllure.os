//////////////////////////////////////////////////////////////////////
// Скрипт запуска отчета allure

Процедура СформироватьОтчетAllure()
	КаталогОтчетов = "D:\repo\AksonDevelop\allure-report";
	
	УдалитьФайлы(КаталогОтчетов + "\allure-report");

	ЗапуститьПриложение("allure generate .", КаталогОтчетов, Истина);
	ЗапуститьПриложение("allure open", КаталогОтчетов);
   КонецПроцедуры 
   
   СформироватьОтчетAllure();