"""
1. Реализовать класс «Дата», функция-конструктор которого должна принимать дату в виде строки формата
«день-месяц-год». В рамках класса реализовать два метода.
Первый, с декоратором @classmethod, должен извлекать число, месяц, год и преобразовывать их тип к типу «Число».
Второй, с декоратором @staticmethod, должен проводить валидацию числа, месяца и года
(например, месяц — от 1 до 12). Проверить работу полученной структуры на реальных данных.
"""
#
# class DateInfo:
#
#     # справочник, содержащий информацию о количестве дней в каждом месяце
#     my_months_dict = {'01': 31, '02': 29, '03': 31, '04': 30, '05': 31, '06': 30, '07': 31, '08': 31, '09': 30, '10': 31,
#                       '11': 30, '12': 31}
#
#     @classmethod
#     def date_get(cls, date_str):
#         a = date_str.split('-')
#         print("Введенная дата:", date_str, '\n', "Число:", int(a[0]), "Месяц:", int(a[1]), "Год:", int(a[2]), '\n')
#
#     @staticmethod
#     def date_validate(date_str):
#         a = date_str.split('-')
#
#         if a[0].isdigit() == False or a[1].isdigit() == False or a[2].isdigit() == False:
#             print(f"В введенной дате {date_str} присутствует НЕ число! Проверьте данные!\n")
#         elif int(a[0]) < 1 or int(a[0]) > DateInfo.my_months_dict.get(a[1]):
#             print(f"В введенной дате {date_str} некорректно введен день!\n")
#         elif int(a[1]) < 1 or int(a[1]) > 12:
#             print(f"В введенной дате {date_str} некорректно введен месяц!\n")
#         elif int(len(a[2])) != 4:
#             print(f"В введенной дате {date_str} некорректно введен год!\n")
#         else:
#             print(f"Ошибок при вводе даты {date_str} не обнаружено!")
#
#
# DateInfo.date_validate('12-02-1988')
# DateInfo.date_get('12-02-1988')
#
# DateInfo.date_validate('12-aa-1988')  # некорректно введен месяц!
# DateInfo.date_validate('40-02-2000')  # некорректно введена дата!
# DateInfo.date_validate('12-05-19888')   # некорректно введен год!
#
# DateInfo.date_validate('25-08-1999')
# DateInfo.date_get('25-08-1999')
#
# DateInfo.date_validate('25-11-2020')
# DateInfo.date_get('25-11-2020')

"""
2. Создайте собственный класс-исключение, обрабатывающий ситуацию деления на нуль. 
Проверьте его работу на данных, вводимых пользователем. 
При вводе пользователем нуля в качестве делителя программа должна корректно обработать эту ситуацию 
и не завершиться с ошибкой."""
#
# class OwnError(Exception):
#     def __init__(self, txt):
#         self.txt = txt
#
# a = int(input("Введите делимое: "))
# b = int(input("Введите делитель: "))
#
# try:
#     if b == 0:
#         raise OwnError("Делить на 0 нельзя!")
#     else:
#         res = a/b
# except ValueError:
#     print("Вы ввели НЕ число!")
# except OwnError as err:
#     print(err)
# else:
#     print(f"Деление прошло успешно! Результат деления {a} на {b} равно {res}")

"""
3. Создайте собственный класс-исключение, который должен проверять содержимое списка на наличие только чисел. 
Проверить работу исключения на реальном примере. Необходимо запрашивать у пользователя данные и заполнять список. 
Класс-исключение должен контролировать типы данных элементов списка.
Примечание: длина списка не фиксирована. Элементы запрашиваются бесконечно, пока пользователь сам не остановит 
работу скрипта, введя, например, команду “stop”. При этом скрипт завершается, сформированный список выводится на экран.
Подсказка: для данного задания примем, что пользователь может вводить только числа и строки. 
При вводе пользователем очередного элемента необходимо реализовать проверку типа элемента и вносить его в список, 
только если введено число. Класс-исключение должен не позволить пользователю ввести текст (не число) и 
отобразить соответствующее сообщение. При этом работа скрипта не должна завершаться."""

# class OwnError(Exception):
#     def __init__(self, txt):
#         self.txt = txt
#
# my_list = []
# while True:
#     try:
#         num = input("Введите число или 'stop' для завершения программы: ")
#         if num == 'stop':
#             print("Программа завершена!")
#             print("Окончательное содержимое списка: ", my_list)
#             break
#         elif num.isdigit() == False:
#             raise OwnError("Некорректный тип данных! Введите число!")
#         else:
#             my_list.append(num)
#     except OwnError as err:
#         print(err)
#     else:
#         print("Текущее содержимое списка:", my_list)


"""
4. Начните работу над проектом «Склад оргтехники». Создайте класс, описывающий склад. 
А также класс «Оргтехника», который будет базовым для классов-наследников. 
Эти классы — конкретные типы оргтехники (принтер, сканер, ксерокс). В базовом классе определить параметры, 
общие для приведенных типов. В классах-наследниках реализовать параметры, уникальные для каждого типа оргтехники.

5. Продолжить работу над первым заданием. Разработать методы, отвечающие за приём оргтехники на склад и передачу 
в определенное подразделение компании. Для хранения данных о наименовании и количестве единиц оргтехники, 
а также других данных, можно использовать любую подходящую структуру, например словарь.

6. Продолжить работу над вторым заданием. Реализуйте механизм валидации вводимых пользователем данных. 
Например, для указания количества принтеров, отправленных на склад, нельзя использовать строковый тип данных.
Подсказка: постарайтесь по возможности реализовать в проекте «Склад оргтехники» максимум возможностей, 
изученных на уроках по ООП.
"""
#
# from abc import ABC, abstractmethod
#
# class OwnError(Exception):
#     def __init__(self, txt):
#         self.txt = txt
#
# class Warehouse:
#     warehouse_dict = []
#     departments_dict = []
#
#     def __init__(self, warehouse_name):
#         self.warehouse_name = warehouse_name
#         print("Объект класса 'Склад' успешно создан!\n")
#
#     def add_to_wh(self, eq_type, equipment, quantity):
#         try:
#             if quantity.isdigit() == False:
#                 raise OwnError("Некорректно введено количество товара на склад!!!")
#             else:
#                 Warehouse.warehouse_dict.append(
#                 [
#                             self.warehouse_name,
#                     {
#                                 'equipmenent_type': eq_type,
#                                 'equipment_name': equipment.equipment_name,
#                                 'equipment_model': equipment.equipment_model,
#                                 'equipment_quantity': int(quantity)
#                     }
#                 ])
#
#         except OwnError as err:
#             print(err)
#         else:
#             print (f"Передача на склад {self.warehouse_name} произведена успешно!")
#
#     def send_to_department(self, department_name, eq_type, equipment, quantity):
#         try:
#             if quantity.isdigit() == False:
#                 raise OwnError(f"Некорректно введено количество товара {eq_type} для передачи в департамент {department_name}!!!")
#             else:
#                 Warehouse.departments_dict.append(
#                     [
#                         department_name,
#                         {
#                             'equipmenent_type': eq_type,
#                             'equipment_name': equipment.equipment_name,
#                             'equipment_model': equipment.equipment_model,
#                             'equipment_quantity': int(quantity)
#                         }
#                     ])
#                 for el in Warehouse.warehouse_dict:
#                     if el[1]['equipment_name'] == equipment.equipment_name and el[1]['equipment_model'] == equipment.equipment_model:
#                         el[1]['equipment_quantity'] = int(el[1]['equipment_quantity']) - int(quantity)
#
#                     else:
#                         continue
#         except OwnError as err:
#             print(err)
#         else:
#             print(f"Передача оборудования {eq_type} в департамент {department_name} произведена успешно!")
#
#
#     def dict_show(self):
#         print("Содержимое справочника по оборудованию на складе:")
#         for el in self.warehouse_dict:
#             print(el)
#
# class Equipment(ABC):
#     equipment_dict = []
#     def __init__(self, equipment_name, equipment_model, equipment_year):
#         self.equipment_name = equipment_name
#         self.equipment_model = equipment_model
#         self.equipment_year = equipment_year
#
#     @abstractmethod
#     def add_to_equipment_dict(self):
#         pass
#
#     @classmethod
#     def count_elements(cls):
#         return len(Equipment.equipment_dict)
#
#     @staticmethod
#     def dict_show():
#         print("Содержимое справочника по оборудованию:")
#         for el in Equipment.equipment_dict:
#             print(el)
#
# class Printer(Equipment):
#     title = 'Printer'
#
#     def __init__(self, equipment_name, equipment_model, equipment_year, price):
#         super().__init__(equipment_name, equipment_model, equipment_year)
#         self.price = price
#
#     def add_to_equipment_dict(self):
#         try:
#             if not str(self.price).isdigit():
#                 raise OwnError ("Некорректно введена цена на товар!")
#             else:
#                 Equipment.equipment_dict.append(
#                     [Printer.title,
#                      {
#                          'equipment_name': self.equipment_name,
#                          'equipment_model': self.equipment_model,
#                          'equipment_year': self.equipment_year,
#                          'equipment_price': self.price
#                      }
#                      ])
#         except OwnError as err:
#             print(err)
#
# class Scanner (Equipment):
#     title = 'Scanner'
#
#     def __init__(self, equipment_name, equipment_model, equipment_year, price):
#         super().__init__(equipment_name, equipment_model, equipment_year)
#         self.price = price
#
#     def add_to_equipment_dict(self):
#         try:
#             if str(self.price).isdigit() == False:
#                 raise OwnError("Некорректно введена цена на товар!")
#             else:
#                 Equipment.equipment_dict.append(
#                     [Scanner.title,
#                      {
#                          'equipment_name': self.equipment_name,
#                          'equipment_model': self.equipment_model,
#                          'equipment_year': self.equipment_year,
#                          'equipment_price': self.price
#                      }
#                      ])
#         except OwnError as err:
#             print(err)
#
#
# class Xerox (Equipment):
#     title = 'Xerox'
#
#     def __init__(self, equipment_name, equipment_model, equipment_year, price):
#         super().__init__(equipment_name, equipment_model, equipment_year)
#         self.price = price
#
#     def add_to_equipment_dict(self):
#         try:
#             if str(self.price).isdigit() == False:
#                 raise OwnError("Некорректно введена цена на товар!")
#             else:
#                 Equipment.equipment_dict.append(
#                     [Xerox.title,
#                      {
#                          'equipment_name': self.equipment_name,
#                          'equipment_model': self.equipment_model,
#                          'equipment_year': self.equipment_year,
#                          'equipment_price': self.price
#                      }
#                      ])
#         except OwnError as err:
#             print(err)
#
# # Создание экземпляров классов. Добавление экземляров классов в справочник по оборудованию
# printer_1 = Printer('hp', 'XS5050', '2000', '8000')
# printer_2 = Printer('hp', 'XS6000', '2001', '7000')
# printer_3 = Printer('hp', 'XS6090', '2005', '6000')
# printer_4 = Printer('hp', 'XS6190', '2006', 'aaa')  # некорректная цена на товар!
#
# printer_1.add_to_equipment_dict()
# printer_2.add_to_equipment_dict()
# printer_3.add_to_equipment_dict()
# printer_4.add_to_equipment_dict()
#
# scanner_1 = Scanner('samsung', 'SD2030', '2000', '3900')
# scanner_2 = Scanner('samsung', 'SD2090', '2001', '4500')
# scanner_3 = Scanner('samsung', 'SD2230', '2007', '2900')
# scanner_4 = Scanner('samsung', 'SD3030', '2007', 'aaa')  # некорректная цена на товар!
#
# scanner_1.add_to_equipment_dict()
# scanner_2.add_to_equipment_dict()
# scanner_3.add_to_equipment_dict()
# scanner_4.add_to_equipment_dict()
#
# xerox_1 = Xerox('acer', 'AS3040', '2020', '4000')
# xerox_2 = Xerox('acer', 'AS3090', '2021', '4500')
# xerox_3 = Xerox('acer', 'AS3990', '2021', '5000')
#
# xerox_1.add_to_equipment_dict()
# xerox_2.add_to_equipment_dict()
# xerox_3.add_to_equipment_dict()
#
# Equipment.dict_show()
# print("Количество элементов в справочнике по оборудованию:", Equipment.count_elements(), '\n')
#
# # Передача оборудования на склад
# warehouse_1 = Warehouse('Equipment')
# warehouse_1.add_to_wh('Printer', printer_1, '100')
# warehouse_1.add_to_wh('Printer', printer_2, '125')
#
#
# warehouse_1.add_to_wh('Scanner', scanner_1, '300')
# warehouse_1.add_to_wh('Scanner', scanner_2, '200')
#
#
# warehouse_1.add_to_wh('Xerox', xerox_1, '30')
# warehouse_1.add_to_wh('Xerox', xerox_2, '20')
#
# warehouse_1.dict_show()
#
#
# # передача оборудования в департаменты компании
# warehouse_1.send_to_department('HR', 'Printer', printer_1, '5')
# warehouse_1.send_to_department('IT', 'Scanner', scanner_1, '10')
# warehouse_1.send_to_department('HR', 'Xerox', xerox_2, '12')
# warehouse_1.send_to_department('Management', 'Scanner', scanner_1, '3')
# warehouse_1.send_to_department('Management', 'Printer', printer_1, 'aaa')  # некорректное число товара!
#
# # можно посмотреть, что уменьшилось количество оборудования на складе в связи с передачей в департменты компании:
# warehouse_1.dict_show()

"""
7. Реализовать проект «Операции с комплексными числами». 
Создайте класс «Комплексное число», реализуйте перегрузку методов сложения и умножения комплексных чисел. 
Проверьте работу проекта, создав экземпляры класса (комплексные числа) 
и выполнив сложение и умножение созданных экземпляров. Проверьте корректность полученного результата."""
#
# class ComplexNumbers():
#     def __init__(self, param_1, param_2):
#         self.param_1 = param_1
#         self.param_2 = param_2
#
#     def __str__(self):
#         return str(complex(self.param_1, self.param_2))
#
#     def __add__(self, other):
#         return complex(self.param_1, self.param_2)+complex(other.param_1, other.param_2)
#
#     def __mul__(self, other):
#         return complex(self.param_1, self.param_2)*complex(other.param_1, other.param_2)
#
# a = ComplexNumbers (1, 2)
# print("Первое комплексное число:", a)
#
# b = ComplexNumbers (3, 4)
# print("Второе комплексное число:", b)
#
# print("Сумма комплексных чисел:", a+b)
# print("Произведение комплексных чисел:", a*b)