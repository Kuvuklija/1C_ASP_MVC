﻿
&НаКлиенте
Процедура ReserveMarksRequestButton(Команда)
	
	ReserveMarksRequestServer();
	
КонецПроцедуры

&НаКлиенте
Процедура ReserveMarksRequestServer()
	
	СтруктураАдреса=НастройкиПодключения();
	
	ЗапуститьОбмен("ReserveMarksRequest", СтруктураАдреса);   //можно асинхронно через обработку оповещения, чтобы не вешать базу
	
КонецПроцедуры   

&НаСервере
Функция НастройкиПодключения()
	
	//настройки
	СтруктураАдреса=Новый Структура;
	СтруктураАдреса.Вставить("IPадресСервера","localhost");
	СтруктураАдреса.Вставить("Port","49425");

	Возврат СтруктураАдреса;
	
КонецФункции

&НаКлиенте
Процедура ЗапуститьОбмен(ИмяЗапроса, СтруктураАдреса)
	
	//json файл
	Запись = Новый ЗаписьJSON;
	ПутьКФайлу=ПолучитьИмяВременногоФайла("json");
	ПараметрыЗаписи=Новый ПараметрыЗаписиJSON(,Символы.Таб);
	Запись.ОткрытьФайл(ПутьКФайлу,,,ПараметрыЗаписи);
	
	//набор вызовов
	Json=Неопределено;
	Выполнить("Json="+ИмяЗапроса+"()");
	
	Если НЕ Json=Неопределено Тогда
		НастройкиСериализацииJSON=Новый НастройкиСериализацииJSON;
		НастройкиСериализацииJSON.ВариантЗаписиДаты=ВариантЗаписиДатыJSON.ЛокальнаяДата;
		НастройкиСериализацииJSON.ФорматСериализацииДаты=ФорматДатыJSON.ISO; 
		
		ЗаписатьJSON(Запись,Json, НастройкиСериализацииJSON, "ФункцияПреобразованияЗаписи", Объект);
	Иначе
		Сообщить("Не сформировали JSON!");
	КонецЕсли;
	
	Запись.Закрыть();
	
	ПодключитьсяПоHttp(СтруктураАдреса,ПутьКФайлу, ИмяЗапроса);
	
КонецПроцедуры

&НаКлиенте
Функция ReserveMarksRequest()
	
	json = Новый Структура;
	json.Вставить("Location","1");
	json.Вставить("Document","20191212-HC20989");
	
	Материалы=Новый Массив;
	Состав1=Новый Структура;
	Состав1.Вставить("Artikul","2133123");
	Состав1.Вставить("Batch","123123");
	//Состав2=Новый Структура();
	//Состав2.Вставить("Artikul","22222");
	//Состав2.Вставить("Batch","22222");
	Материалы.Добавить(Состав1);
	//Материалы.Добавить(Состав2);
	
	json.Вставить("Materials",Материалы);
	
	Возврат json;
	
КонецФункции

&НаКлиенте
Процедура ArrivalButton(Команда)
	ArrivalServer();
КонецПроцедуры

&НаКлиенте
Процедура ArrivalServer()
	
	СтруктураАдреса=НастройкиПодключения();
	
	ЗапуститьОбмен("Arrival", СтруктураАдреса);   //можно асинхронно через обработку оповещения, чтобы не вешать базу
	
КонецПроцедуры

&НаКлиенте
Функция Arrival()
	
	СтруктураArrival=Новый Структура;
	СтруктураArrival.Вставить("Location","1");
	СтруктураArrival.Вставить("Document","20191212-HC20989");
	СтруктураArrival.Вставить("Status","Stock");
	СтруктураArrival.Вставить("Materials");
	
	Товары=Новый Массив;
	Строка1=Новый Структура;
	Строка1.Вставить("Artikul","2133123");
	Строка1.Вставить("Batch","123123");
	Строка1.Вставить("RegForm1","FA-121233");
	Строка1.Вставить("RegForm2","FB-123323");
	Строка1.Вставить("AlcoCode","01928383");
	Строка1.Вставить("DocumentRow","1");
	Строка1.Вставить("Pallets");
	Товары.Добавить(Строка1);
	СтруктураArrival.Materials=Товары;
	
	ПаллетыСтроки1=Новый Массив;
	Паллета1=Новый Структура;
	Паллета1.Вставить("VirtualPallete",Ложь);
	Паллета1.Вставить("PalletCode","87897897");
	Паллета2=Новый Структура;
	Паллета2.Вставить("VirtualPallete",Ложь);
	Паллета2.Вставить("PalletCode","65656551");
	
	ПаллетыСтроки1.Добавить(Паллета1);
	ПаллетыСтроки1.Добавить(Паллета2);
	Строка1.Pallets=ПаллетыСтроки1;
	
	КоробаПаллеты1=Новый Массив;
	КоробаПаллеты2=Новый Массив;

	////короба из паллеты 1
	Короб1=Новый Структура;
	Короб1.Вставить("VirtualCarton", Ложь);
	Короб1.Вставить("CartonCode", "78987987");
	Короб1.Вставить("Marks");
	Короб2=Новый Структура;
	Короб2.Вставить("VirtualCarton", Ложь);
	Короб2.Вставить("CartonCode", "78955555");
	Короб2.Вставить("Marks");
	КоробаПаллеты1.Добавить(Короб1);
	КоробаПаллеты1.Добавить(Короб2);
	Паллета1.Вставить("Cartons",КоробаПаллеты1);
	
	////короб из паллеты 2
	Короб3=Новый Структура;
	Короб3.Вставить("VirtualCarton", Ложь);
	Короб3.Вставить("CartonCode", "11111112");
	Короб3.Вставить("Marks");
	КоробаПаллеты2.Добавить(Короб3);
	Паллета2.Вставить("Cartons",КоробаПаллеты2);
	
	МаркиКороба1=Новый Массив;
	Марка11=Новый Структура;
	Марка11.Вставить("MarkCode",1234431243);
	Марка12=Новый Структура;
	Марка12.Вставить("MarkCode",1234431243);
	Марка13=Новый Структура;
	Марка13.Вставить("MarkCode",1234431243);
	МаркиКороба1.Добавить(Марка11);
	МаркиКороба1.Добавить(Марка12);
	МаркиКороба1.Добавить(Марка13);
	Короб1.Marks=МаркиКороба1;
	
	МаркиКороба2=Новый Массив;
	Марка21=Новый Структура;
	Марка21.Вставить("MarkCode",1234431243);
	Марка22=Новый Структура;
	Марка22.Вставить("MarkCode",1234431243);
	Марка23=Новый Структура;
	Марка23.Вставить("MarkCode",1234431243);
	МаркиКороба2.Добавить(Марка21);
	МаркиКороба2.Добавить(Марка22);
	МаркиКороба2.Добавить(Марка23);
	Короб2.Marks=МаркиКороба2;
	
	МаркиКороба3=Новый Массив;
	Марка31=Новый Структура;
	Марка31.Вставить("MarkCode",1234431243);
	Марка32=Новый Структура;
	Марка32.Вставить("MarkCode",1234431243);
	Марка33=Новый Структура;
	Марка33.Вставить("MarkCode",1234431243);
	МаркиКороба3.Добавить(Марка31);
	МаркиКороба3.Добавить(Марка32);
	МаркиКороба3.Добавить(Марка33);
	Короб3.Marks=МаркиКороба3;
	
    Возврат СтруктураArrival;	
	
КонецФункции

&НаКлиенте
Функция ПодключитьсяПоHttp(СтруктураАдреса, ПутьКФайлу, ИмяМетодаСервера)
	
	Попытка
		
		Server=СтруктураАдреса.IPадресСервера;
		Port=СтруктураАдреса.Port;
		
		СтрокаХМЛ="";
		
		Соединение = Новый HTTPСоединение(Server,Port);
		
		//запрос-ответ
		ЗаголовокЗапросаHTTP = Новый Соответствие();
		ЗаголовокЗапросаHTTP.Вставить("Content-Type", "application/json");
		
		HTTPЗапрос = Новый HTTPЗапрос("/Marks/"+ИмяМетодаСервера,ЗаголовокЗапросаHTTP);
		HTTPЗапрос.УстановитьИмяФайлаТела(ПутьКФайлу);
		
		Результат  = Соединение.ОтправитьДляОбработки(HTTPЗапрос);
		
		СтрокаJson=Результат.ПолучитьТелоКакСтроку(КодировкаТекста.UTF8);
		
		ReadJson=Новый ЧтениеJSON();
		ReadJson.УстановитьСтроку(СтрокаJson);
		Структура=ПрочитатьJSON(ReadJson);
		
		Соединение = Неопределено; 
		HTTPЗапрос=Неопределено;
		
		Если Результат.КодСостояния > 299 Тогда
			Сообщить("Ошибка ответа сервера!");
		КонецЕсли; 
		
	Исключение
		Соединение = Неопределено; 
		HTTPЗапрос=Неопределено;
		Сообщить(ОписаниеОшибки());
		//ВызватьИсключение;
	КонецПопытки;
	
КонецФункции





