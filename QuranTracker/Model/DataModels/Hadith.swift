//  Hadith.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 09.12.2024.
//

import Foundation

struct Hadith {
    let label: String
    let author: String
    let text: String
    let source: String
    let additionalInfo: String?
    // swiftlint:disable line_length
    static let hadiths: [Hadith] = [
        Hadith(
            label: "Коран как заступник ✨",
            author: "Абу Умама (да будет доволен им Аллах)  рассказывал:",
            text: "Я слышал, как Посланник Аллаха ﷺ говорил: “Читайте Коран, ибо, поистине, в День воскрешения он явится, как заступник за тех, кто его читал!”",
            source: "Этот хадис передал Муслим 804.", additionalInfo: nil
        ),
        Hadith(
            label: "О лучших из нас! 👑",
            author: "От ‘Усмана ибн ‘Аффана (да будет доволен им Аллах) сообщается, что Посланник Аллаха ﷺ сказал:",
            text: "Лучшими из вас являются те, кто изучал Коран и обучал ему других",
            source: "Этот хадис передал аль-Бухари (5027).", additionalInfo: nil
        ),
        Hadith(
            label: "Читай Коран по мусхафу! 📖",
            author: "Передают со слов Ибн Мас’уда о том, что пророк, ﷺ, сказал:",
            text: "Кого обрадует то, что его полюбят Аллах и Его посланник, пусть читает Коран по мусхафу!",
            source: "Этот хадис передали Ибн Шахин в «ат-Таргъиб» 1/288, Абу Ну’айм в «Хильятуль-аулияъ» 7/209 и Ибн ‘Ади 2/111.", additionalInfo: nil
        ),
        Hadith(
            label: "Сердца - это сосуды 🫀",
            author: "Ибн Мас’уд (да будет доволен им Аллах) говорил:",
            text: "Поистине, эти сердца – сосуды, так наполняйте же их Кораном и не наполняйте их чем-то иным",
            source: "Это сообщение передал Ибн Аби Шейба (30615).", additionalInfo: nil
        ),
        Hadith(
            label: "О Мусхафе 📖",
            author: "Сообщается, что Ибн Мас’уд (да будет доволен им Аллах) сказал:",
            text: "Часто смотрите в Мусхаф (при чтении Корана)",
            source: "Это сообщение передал Абу ‘Убайд в “Фадаиль аль-Къуран” 96. Иснад хороший.",
            additionalInfo: """
Хафиз Ибн Касир сказал: “Некоторые ученые говорили, что предпочтение в этом вопросе (чтении Корана по памяти или по Мусхафу) возвращается к смиренности. Если у человека смиренности больше при чтении по памяти, то это лучше, а если смиренности больше при чтении по Мусхафу, то тогда лучше это. Если же вопрос смиренности одинаков, то чтение по Мусхафу лучше, поскольку это точнее”. См. “Фадаиль аль-Къуран” 212.
Однако не следует забывать о том, чтобы заучивать побольше Коран, читая его по памяти. Ведь как говорил славный сподвижник Абу Умама, Аллах не накажет того, в чьем сердце есть Коран. 
"""
        ),
        Hadith(
            label: "Дом, который посещают Ангелы ✨",
            author: "Сообщается, что Абу Хурайра (да будет доволен им Аллах) сказал:",
            text: "Поистине, дом становится просторным, посещают его ангелы, избегают его шайтаны и увеличивается в нём благо, если читают в нём Коран. И поистине, дом становится тесным для его обитателей, отдаляются от него ангелы и населяют его шайтаны, и уменьшается в нём благо, если не читают в нём Коран",
            source: "Это сообщение передали ад-Дарими 3352 и Ибн ад-Дарис в “Фадаиль аль-Къуран” 185. Иснад достоверный.",
            additionalInfo: nil
        ),
        Hadith(
            label: "Читай и восходи! 🆙",
            author: "Передают со слов ‘Абдуллаха ибн ‘Амра ибн аль-‘Аса, да будет доволен Аллах ими обоими, что пророк, да благословит его Аллах и да приветствует, сказал:",
            text: "– Тому, кто знал Коран, будет сказано: «Читай, восходи и отчётливо произноси слова /раттиль/ , как делал ты это в земной жизни, и, поистине, место твоё будет соответствовать последнему прочтённому тобою айату».",
            source: "Этот хадис передали Ахмад 2/192, Абу Дауд 1464, Ибн Маджах 3780 и другие",
            
            additionalInfo: """
Шейх аль-Албани в «ас-Сильсиля ас-сахиха» (5/281) сказал:

«Знай, что под словом “знавший Коран/сахиб аль-Къуран/” подразумевается тот, кто заучивает Коран наизусть, как сказал пророк, да благословит его Аллах и приветствует: “Молитвой людей руководит тот, кто знает больше Коран” — имея ввиду, того, кто запомнил больше из Корана.

Различие в статусе в Раю будет зависеть от того, сколько человек запомнил в этом мире, а несколько он прочитает в тот день, как ошибочно считают некоторые люди. Это ясно указывает на достоинства хафизов, которые запомнили Коран, но с необходимым условием, что это должно делаться ради Лика Всеблагого и Всевышнего Аллаха, а не ради мирских целей, дирхамов и динаров, в противном же случае, пророк, да благословит его Аллах и приветствует, сказал: «Большинство лицемеров моей уммы это чтецы Корана».

Аль-Хаттаби сказал: «Сообщается, что в Коране столько же аятов, сколько есть ступеней в Раю, и чтецу Корана будет сказано: “Поднимайся по ступеням в соответствии с тем, сколько аятов ты прочёл”. И кто прочтёт весь Коран, тот займет самую высокую ступень Рая. А тот, кто прочтёт его часть, то поднимется в соответствии с количеством прочитанного, т.е. предел его вознаграждения будет там, где он закончит свое чтение».
"""
        )
    ]
    // swiftlint:enable line_length
}
