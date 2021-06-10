"""
1. Реализовать скрипт, в котором должна быть предусмотрена функция расчета заработной платы сотрудника.
В расчете необходимо использовать формулу: (выработка в часах * ставка в час) + премия.
Для выполнения расчета для конкретных значений необходимо запускать скрипт с параметрами.
"""
# from sys import argv
#
# script_name, hours, rate_per_hour, premia = argv
#
# print("Имя скрипта: ", script_name)
# print("Выработка в часах: ", hours)
# print("Ставка в час: ", rate_per_hour)
# print("Премия: ", premia)
# print("Зарплата сотрудника: ", int(hours) * float(rate_per_hour) + float(premia))

"""
Попробовала запустить в терминале код со следующими параметрами:
python HomeWork_4.py 10 3 350

Получила следующий результат:
Имя скрипта:  HomeWork_4.py
Выработка в часах:  10
Ставка в час:  3
Премия:  350
Зарплата сотрудника:  380.0
"""

"""
2. Представлен список чисел. Необходимо вывести элементы исходного списка, значения которых больше предыдущего элемента.
Подсказка: элементы, удовлетворяющие условию, оформить в виде списка. Для формирования списка использовать генератор.
Пример исходного списка: [300, 2, 12, 44, 1, 1, 4, 10, 7, 1, 78, 123, 55].
Результат: [12, 44, 4, 10, 78, 123].
"""
# my_list = [300, 2, 12, 44, 1, 1, 4, 10, 7, 1, 78, 123, 55]
# my_list_new = [j for i, j in zip(my_list, my_list[1:]) if j > i]
# print(my_list_new)

"""
3. Для чисел в пределах от 20 до 240 найти числа, кратные 20 или 21. Необходимо решить задание в одну строку.
Подсказка: использовать функцию range() и генератор.
"""

# print(list(el for el in range(20, 240) if el % 20 == 0 or el % 21 == 0))

"""
4. Представлен список чисел. Определите элементы списка, не имеющие повторений. 
Сформируйте итоговый массив чисел, соответствующих требованию. 
Элементы выведите в порядке их следования в исходном списке. 
Для выполнения задания обязательно используйте генератор.
Пример исходного списка: [2, 2, 2, 7, 23, 1, 44, 44, 3, 2, 10, 7, 4, 11].
Результат: [23, 1, 3, 10, 4, 11]
"""

# my_list = [2, 2, 2, 7, 23, 1, 44, 44, 3, 2, 10, 7, 4, 11]
# my_list_new = [el for el in my_list if my_list.count(el) < 2]
# print(my_list_new)

"""
5. Реализовать формирование списка, используя функцию range() и возможности генератора. 
В список должны войти четные числа от 100 до 1000 (включая границы). 
Необходимо получить результат вычисления произведения всех элементов списка.
Подсказка: использовать функцию reduce().
"""
# from functools import reduce
# my_list = [el for el in range(100, 1001) if el%2 == 0]
#
# def my_func(prev_el,el):
#     return prev_el*el
#
# print(reduce(my_func, my_list))

"""
6. Реализовать два небольших скрипта:
а) итератор, генерирующий целые числа, начиная с указанного,
б) итератор, повторяющий элементы некоторого списка, определенного заранее.
Подсказка: использовать функцию count() и cycle() модуля itertools. Обратите внимание, 
что создаваемый цикл не должен быть бесконечным. Необходимо предусмотреть условие его завершения.
Например, в первом задании выводим целые числа, начиная с 3, а при достижении числа 10 завершаем цикл. 
Во втором также необходимо предусмотреть условие, при котором повторение элементов списка будет прекращено.
"""

# Итератор, генерирующий целые числа, начиная с 3 и заканчивая 10
# from itertools import count
#
# for el in count(3):
#     if el > 10:
#         break
#     else:
#         print(el)

# Итератор, повторяющий элементы некоторого списка, определенного заранее

# from itertools import cycle
#
# my_list = ['a', 'b', 'c', 'd', 'e']
# iter = cycle(my_list)
#
# print(next(iter))
# print(next(iter))
# print(next(iter))
# print(next(iter))
# print(next(iter))
# print(next(iter))
# print(next(iter))
# print(next(iter))
# print(next(iter))

"""
7. Реализовать генератор с помощью функции с ключевым словом yield, создающим очередное значение. 
При вызове функции должен создаваться объект-генератор. Функция должна вызываться следующим образом: for el in fact(n). 
Функция отвечает за получение факториала числа, а в цикле необходимо выводить только первые n чисел, начиная с 1! и до n!.
Подсказка: факториал числа n — произведение чисел от 1 до n. Например, факториал четырёх 4! = 1 * 2 * 3 * 4 = 24.
"""

# def fact(n):
#     res = 1
#     for i in range(1, n+1):
#         res = res*i
#         yield i
#
# n = int(input("Введите факториал интересуемого числа: "))
#
# for el in fact(n):
#     print(el)


