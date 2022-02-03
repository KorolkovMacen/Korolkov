import Foundation

class EmojiMemoryGame : ObservableObject //тип наблюдаемого класса
{
    //издатель(обертка свойства)
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String>
    {
        let emojis: Array<String> = ["🐗","🦧","🐁","🦫","🐖","🥶","😈","🐷"]
        //функция возвращает Модель игры инциализируя тип контента карты строкой копируем модель (value type) с аргументами количества пар карт в диапазоне от 2 до 5 включая верхнюю границу, 2,3,4,5 диапазон 2..<5 не будет включат верхнюю границу
        return MemoryGame<String>(numberOfPairsOfCards:Int(3))
        {
            pairIndex in return emojis[Int.random(in: 0..<emojis.count)]// замыкание pairIndex возвращает значок который определеятеся рандомным числом от 0 до количества элементов в массиве избегая верхнюю границу pair index присваивается каждой итерации это реализация второго аргумента структуры контент фабрики
        }
        
    }
    // MARK: запросы к модели
    var cards: Array<MemoryGame<String>.Card>
    {
        //вычисляемая переменная массива карт с типом карты копировали массив карт из модели
        model.cards
    }
    // MARK: реализация намерения пользователя
    //функция выбора карты принимает аргументом карту и передает сообщение в функцию модели где модель изменяет это уже в своем массиве карты
    func choose(card: MemoryGame<String>.Card)
    {
        model.choose(card: card)
    }
}

