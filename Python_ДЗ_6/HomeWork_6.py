"""
1. Создать класс TrafficLight (светофор) и определить у него один атрибут color (цвет) и метод running (запуск).
Атрибут реализовать как приватный. В рамках метода реализовать переключение светофора в режимы: красный, желтый, зеленый.
Продолжительность первого состояния (красный) составляет 7 секунд, второго (желтый) — 2 секунды, третьего (зеленый) —
на ваше усмотрение. Переключение между режимами должно осуществляться только в указанном порядке (красный, желтый, зеленый).
Проверить работу примера, создав экземпляр и вызвав описанный метод.
Задачу можно усложнить, реализовав проверку порядка режимов,
и при его нарушении выводить соответствующее сообщение и завершать скрипт.
"""
# import time
#
# class TrafficLight:
#     __color = "Красный"
#
#     def running(self):
#         if (TrafficLight.__color == "Красный"):
#             print(f"Горит красный цвет")
#             time.sleep(7)
#             print("Горит желтый цвет")
#             time.sleep(2)
#             print(f"Горит зеленый цвет")
#             time.sleep(7)
#         else:
#             print("Ошибка в работе светофора")
#
# a = TrafficLight()
# a.running()

"""
2. Реализовать класс Road (дорога), в котором определить атрибуты: length (длина), width (ширина).
Значения данных атрибутов должны передаваться при создании экземпляра класса.
Атрибуты сделать защищенными.
Определить метод расчета массы асфальта, необходимого для покрытия всего дорожного полотна.
Использовать формулу: длина * ширина *
масса асфальта для покрытия одного кв метра дороги асфальтом, толщиной в 1 см * число см толщины полотна.
Проверить работу метода.
Например: 20м * 5000м * 25кг * 5см = 12500 т
"""

# class Road:
#     road_mass_of_asphalt_per_1_m = 25
#     road_thickness = 5
#
#     def __init__(self, road_lenght, road_width):
#         self._road_lenght = road_lenght
#         self._road_width = road_width
#
#     def get_mass_of_all_asphalt(self):
#         print(f"Масса асфальта, необходимая для покрытия всего дорожного полотна: "
#               f"{(Road.road_mass_of_asphalt_per_1_m*Road.road_thickness*self._road_lenght * self._road_width)/1000} тонн")
#
#
# road_1 = Road(20, 5000)
# road_1.get_mass_of_all_asphalt()

"""
3. Реализовать базовый класс Worker (работник), в котором определить атрибуты: 
name, surname, position (должность), income (доход). 
Последний атрибут должен быть защищенным и ссылаться на словарь, содержащий элементы: оклад и премия, например, 
{"wage": wage, "bonus": bonus}. 
Создать класс Position (должность) на базе класса Worker. 
В классе Position реализовать методы получения полного имени сотрудника (get_full_name) 
и дохода с учетом премии (get_total_income). 
Проверить работу примера на реальных данных (создать экземпляры класса Position, 
передать данные, проверить значения атрибутов, вызвать методы экземпляров)."""

#
# class Worker:
#     def __init__(self, name, surname, position, wage, bonus):
#         self.name = name
#         self.surname = surname
#         self.position = position
#         self._income = {"wage": int(wage), "bonus": int(bonus)}
#
# class Position (Worker):
#     def __init__(self, name, surname, position, wage, bonus):
#         super().__init__(name, surname, position, wage, bonus)
#
#     def get_full_name(self):
#         print(f"Полное имя - {self.surname} {self.name}")
#
#     def get_total_income(self):
#         print("Доход составляет: ", self._income["wage"] + self._income["bonus"], "тысяч рублей")
#
#
# worker_1 = Position("Олег", "Иванов", "manager", "100", "50")
# worker_1.get_full_name()
# worker_1.get_total_income()
#
# worker_2 = Position("Анна", "Михайлова", "assistent", "50", "20")
# worker_2.get_full_name()
# worker_2.get_total_income()
#
# worker_3 = Position("Ольга", "Васнецова", "assistent", "70", "30")
# worker_3.get_full_name()
# worker_3.get_total_income()


""" 4. Реализуйте базовый класс Car. 
У данного класса должны быть следующие атрибуты: speed, color, name, is_police (булево). 
А также методы: go, stop, turn(direction), которые должны сообщать, что машина поехала, остановилась, повернула (куда). 
Опишите несколько дочерних классов: TownCar, SportCar, WorkCar, PoliceCar. 
Добавьте в базовый класс метод show_speed, который должен показывать текущую скорость автомобиля. 
Для классов TownCar и WorkCar переопределите метод show_speed. При значении скорости свыше 60 (TownCar) и 40 (WorkCar) 
должно выводиться сообщение о превышении скорости.
Создайте экземпляры классов, передайте значения атрибутов. 
Выполните доступ к атрибутам, выведите результат. Выполните вызов методов и также покажите результат."""
#
# class Car:
#     def __init__(self, speed, color, name, is_police):
#         self.speed = speed
#         self.color = color
#         self.name = name
#         self.is_police = is_police
#
#     def car_go(self):
#         print("Автомобиль поехал")
#
#     def car_stop(self):
#         print("Автомобиль остановился")
#
#     def car_turn(self, direction):
#         print("Автомобиль повернул", direction)
#
#     def show_speed(self):
#         print(f"Автомобиль едет со скоростью {self.speed} км/ч")
#
#
# class TownCar (Car):
#     def __init__(self, speed, color, name, is_police):
#         super().__init__(speed, color, name, is_police)
#
#     def show_speed(self):
#         if int(self.speed) > 60:
#             print(f"Автомобиль едет со скоростью {self.speed} км/ч. Cкорость превышена!")
#         else:
#             print(f"Автомобиль едет со скоростью {self.speed} км/ч")
#
# class SportCar (Car):
#     def __init__(self, speed, color, name, is_police):
#         super().__init__(speed, color, name, is_police)
#
#
# class WorkCar (Car):
#     def __init__(self, speed, color, name, is_police):
#         super().__init__(speed, color, name, is_police)
#
#     def show_speed(self):
#         if int(self.speed) > 40:
#             print(f"Автомобиль едет со скоростью {self.speed} км/ч. Cкорость превышена!")
#         else:
#             print(f"Автомобиль едет со скоростью {self.speed} км/ч")
#
# class PoliceCar (Car):
#     def __init__(self, speed, color, name, is_police):
#         super().__init__(speed, color, name, is_police)
#
# towncar_1 = TownCar("70", "blue", "Lexus", 0)
# print(towncar_1.name, towncar_1.color)
# towncar_1.car_go()
# towncar_1.show_speed()
# towncar_1.car_turn("налево")
# towncar_1.car_stop()
#
# towncar_2 = TownCar("55", "black", "Mazda", 0)
# print(towncar_2.name, towncar_2.color)
# towncar_2.car_go()
# towncar_2.show_speed()
# towncar_1.car_turn("направо")
# towncar_2.car_stop()
#
# sportcar_1 = SportCar("110", "red", "Pagani", 0)
# print(sportcar_1.color, sportcar_1.name)
# sportcar_1.car_go()
# sportcar_1.show_speed()
# sportcar_1.car_stop()
#
# workcar_1 = WorkCar("80", "orange", "Kamaz", 0)
# print(workcar_1.color, workcar_1.name)
# workcar_1.car_go()
# workcar_1.car_turn("налево")
# workcar_1.show_speed()
# workcar_1.car_turn("направо")
# workcar_1.car_stop()
#
# workcar_2 = WorkCar("30", "blue", "Kamaz", 0)
# print(workcar_2.color, workcar_2.name)
# workcar_2.car_go()
# workcar_2.show_speed()
# workcar_2.car_turn("направо")
# workcar_2.car_stop()
#
# policecar_1 = PoliceCar("90", "blue and white", "Mercedez", 1)
# print(policecar_1.color, policecar_1.name)
# policecar_1.car_go()
# policecar_1.car_turn("направо")
# policecar_1.show_speed()
# policecar_1.car_stop()

"""
5. Реализовать класс Stationery (канцелярская принадлежность). Определить в нем атрибут title (название) 
и метод draw (отрисовка). Метод выводит сообщение “Запуск отрисовки.” 
Создать три дочерних класса Pen (ручка), Pencil (карандаш), Handle (маркер). 
В каждом из классов реализовать переопределение метода draw. 
Для каждого из классов методы должен выводить уникальное сообщение. 
Создать экземпляры классов и проверить, что выведет описанный метод для каждого экземпляра."""
#
# class Stationery:
#     def __init__(self, title):
#         self.title = title
#
#     def draw(self):
#         print(f"Запуск отрисовки")
#
# class Pen (Stationery):
#     def __init__(self, title):
#         super().__init__(title)
#
#     def draw(self):
#         print(f"Метод отрисовки - {self.title}")
#
#
# class Pencil(Stationery):
#     def __init__(self, title):
#         super().__init__(title)
#
#     def draw(self):
#         print(f"Метод отрисовки - {self.title}")
#
# class Handle(Stationery):
#     def __init__(self, title):
#         super().__init__(title)
#
#     def draw(self):
#         print(f"Метод отрисовки - {self.title}")
#
# stationery_1 = Stationery("краски")
# stationery_1.draw()
#
# pen_1 = Pen("ручка")
# pen_1.draw()
#
# pencil_1 = Pencil("карандаш")
# pencil_1.draw()
#
# handle = Handle("маркер")
# handle.draw()