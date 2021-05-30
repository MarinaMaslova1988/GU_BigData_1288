"""
1. Создать программно файл в текстовом формате, записать в него построчно данные, вводимые пользователем.
Об окончании ввода данных свидетельствует пустая строка.
"""
# file_name = input('Введите наименование файла: ')
# f = open(file_name, 'w', encoding='utf-8')
# while True:
#     s = input("Введите данные: ")
#     if s == '':
#         break
#     f.write(s+'\n')
# f.close()

"""
2. Создать текстовый файл (не программно), сохранить в нем несколько строк,
выполнить подсчет количества строк, количества слов в каждой строке.
"""

# with open("File_2", 'r', encoding='utf-8') as file_obj:
#     my_list = file_obj.readlines()
#     print("Количество строк в файле: ", len(my_list))
#     for el in my_list:
#         print('\n', el, "Количество слов в строке: ", len(el.split()))

"""
3. Создать текстовый файл (не программно), построчно записать фамилии сотрудников и величину их окладов. Определить, 
кто из сотрудников имеет оклад менее 20 тыс., вывести фамилии этих сотрудников. 
Выполнить подсчет средней величины дохода сотрудников."""

# with open("File_3", 'r', encoding='utf-8') as file_obj:
#     my_list = file_obj.readlines()
#     sum = 0
#     for el in my_list:
#         a = el.split(" ")
#         sum += int(a[1])
#         if int(a[1]) < 20000:
#             print(a)
#         else:
#             continue
#     print("Средняя величина дохода сотрудников: ", (sum/len(my_list)))


"""
4. Создать (не программно) текстовый файл со следующим содержимым:
One — 1
Two — 2
Three — 3
Four — 4
Необходимо написать программу, открывающую файл на чтение и считывающую построчно данные. 
При этом английские числительные должны заменяться на русские. 
Новый блок строк должен записываться в новый текстовый файл."""


# with open("File_4", 'r', encoding='utf-8') as file_obj:
#     for el in file_obj.readlines():
#         a = el.split()
#         if a[0] == 'One':
#             with open("File_4_new.txt", 'w', encoding='utf-8') as file_a:
#                 file_a.write("Один - 1\n")
#         elif a[0] == 'Two':
#             with open("File_4_new.txt", 'a+', encoding='utf-8') as file_a:
#                 file_a.write("Два - 2\n")
#         elif a[0] == 'Three':
#             with open("File_4_new.txt", 'a+', encoding='utf-8') as file_a:
#                 file_a.write("Три - 3\n")
#         elif a[0] == 'Four':
#             with open("File_4_new.txt", 'a+', encoding='utf-8') as file_a:
#                 file_a.write("Четыре - 4\n")
#         else:
#             break
#
# my_f = open("File_4_new.txt", "r", encoding='utf-8')
# content = my_f.readlines()
# print(content)
# my_f.close()


"""
5. Создать (программно) текстовый файл, записать в него программно набор чисел, разделенных пробелами. 
Программа должна подсчитывать сумму чисел в файле и выводить ее на экран."""

# with open("File_5.txt", "r", encoding='utf-8') as file_obj:
#     for el in file_obj.readlines():
#         my_list = el.split(" ")
#         print(my_list)
#         sum = 0
#         for el_list in my_list:
#             if el_list.isdigit() == True:
#                 sum += int(el_list)
#             else:
#                 continue
# print("Сумма чисел в файле составляет: ", sum)

"""
6. Необходимо создать (не программно) текстовый файл, где каждая строка описывает учебный предмет
 и наличие лекционных, практических и лабораторных занятий по этому предмету и их количество. 
 Важно, чтобы для каждого предмета не обязательно были все типы занятий. 
 Сформировать словарь, содержащий название предмета и общее количество занятий по нему. Вывести словарь на экран.
Примеры строк файла:
Информатика: 100(л) 50(пр) 20(лаб).
Физика: 30(л) — 10(лаб)
Физкультура: — 30(пр) —

Пример словаря:
{“Информатика”: 170, “Физика”: 40, “Физкультура”: 30}"""

# my_dict = {}
# with open ("File_6.txt", encoding='utf-8') as file_obj:
#    for line in file_obj:
#         subject, lecture, practice, lab = line.split()
#
#         if lecture == '—':
#             lecture = lecture.replace("—", "0")
#         else:
#             lecture = lecture.replace('(л)', '')
#
#         if practice == '—':
#             practice = practice.replace('—', '0')
#         else:
#             practice = practice.replace('(пр)', '')
#
#         if lab == '—':
#             lab = lab.replace('—', '0')
#         else:
#             lab = lab.replace('(лаб)', '')
#
#         my_dict.setdefault(subject, int(lecture)+int(practice)+int(lab))
#
# print(my_dict)


"""
7. Создать (не программно) текстовый файл, в котором каждая строка должна содержать данные о фирме: 
название, форма собственности, выручка, издержки.
Пример строки файла: firm_1 ООО 10000 5000.
Необходимо построчно прочитать файл, вычислить прибыль каждой компании, а также среднюю прибыль. 
Если фирма получила убытки, в расчет средней прибыли ее не включать.
Далее реализовать список. 
Он должен содержать словарь с фирмами и их прибылями, а также словарь со средней прибылью. 
Если фирма получила убытки, также добавить ее в словарь (со значением убытков).
Пример списка: [{“firm_1”: 5000, “firm_2”: 3000, “firm_3”: 1000}, {“average_profit”: 2000}].
Итоговый список сохранить в виде json-объекта в соответствующий файл.
Пример json-объекта:
[{"firm_1": 5000, "firm_2": 3000, "firm_3": 1000}, {"average_profit": 2000}]

Подсказка: использовать менеджеры контекста."""

# sum = 0
# i = 0
# my_list = []
# my_dict_1 = {}  # словарь для фирм с прибылью
# my_dict_2 = {}  # словарь для фирм с убытками
# my_dict_3 = {}  # словарь для средней прибыли
#
# with open ("File_7", encoding='utf-8') as file_obj:
#     for line in file_obj:
#         Name, Type, Revenue, Costs = line.split(" ")
#
#         if int(Revenue) < int(Costs):
#             my_dict_2.setdefault(Name, int(Costs) - int(Revenue))
#         else:
#             i += 1
#             sum += int(Revenue) - int(Costs)
#             my_dict_1.setdefault(Name, int(Revenue) - int(Costs))
#
#     my_dict_3.setdefault("average_profit", sum/i)
#
#     my_list.append(my_dict_1)
#     my_list.append(my_dict_2)
#     my_list.append(my_dict_3)
#     print(my_list)
#
# import json
# with open ("File_7.json", 'w', encoding='utf-8') as file_1:
#     json.dump(my_list, file_1)
