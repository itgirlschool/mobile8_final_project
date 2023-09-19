//Событие для истории заказов, родительский класс для всех событий
class OrdersHistoryEvent {
}

//Событие для загрузки истории заказов
class LoadOrdersHistoryEvent extends OrdersHistoryEvent {
}