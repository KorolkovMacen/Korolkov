import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable
{
    var cards : Array<Card>
    
    var indexOfTheOnlyFaceUpCard: Int?
    
    mutating func choose(card:Card)//структуры доступны только для чтения модификатор mutating позволяет вносить изменения в нее
    {
        //записываем индекс выбранной карты в константу, соответсцитвуем целому числу инициализуремся функцией массива карт ( аргументом передаем карту )
        if let chosenIndex = cards.FirstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched
           {
            if let potentialMatchInex = indexOfTheOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchInex].content
                    {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchInex].isMatched = true
                    }
                indexOfTheOnlyFaceUpCard = nil
            } else {
                        for index in cards.indices {
                            cards[index].isFaceUp = false
                        }
                        indexOfTheOnlyFaceUpCard = chosenIndex
            }
                    self.cards[chosenIndex].isFaceUp = true
            }
    }
    //инциализтор модели, при создании копии структуры модели мы инициализируем переменные структуры одним из аргументов структуры будет являться вложенная функция создания контента для карты которая получает индекс пары и возвращает контент (не важно какого типа)
    init (numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent)
    {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards //зададим индекс пары карт каждой итерации цикла в диапазоне от 0 до количество пар карт
        {
            let content = cardContentFactory(pairIndex) // константа которая реализует функцию создания контента для карты передавая индекс пары в качестве аргумента, свифт из контекста выводит тип CardContent тк функция возвращает этот тип
            cards.append(Card(content: content, id: pairIndex * 2))//добавляем в массив карт карту с конетнтом и добавим айди карты с помощью индекса пары карт
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()// при инициализации модели перемешиваем массив карт
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}


