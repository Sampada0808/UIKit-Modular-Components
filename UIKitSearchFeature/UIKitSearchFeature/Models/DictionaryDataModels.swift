import Foundation




struct WordInformation {
    let word: String
    let definitions: String
    let phonetic: String
    let audio: String
    let synonyms: [String]
    let antonyms: [String]
    let example: String
}




let sampleWordsData: [WordInformation] = [
    WordInformation(
        word: "chocolate",
        definitions: "A food made from ground roasted cocoa beans.",
        phonetic: "/ˈt͡ʃɔk(ə)lət/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/chocolate-us.mp3",
        synonyms: ["candy", "confectionery"],
        antonyms: [],
        example: "Chocolate is a very popular treat."
    ),
    WordInformation(
        word: "serendipity",
        definitions: "The occurrence of events by chance in a happy or beneficial way.",
        phonetic: "/ˌsɛrənˈdɪpɪti/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/serendipity-us.mp3",
        synonyms: ["fluke", "luck", "chance"],
        antonyms: ["misfortune", "bad luck"],
        example: "Finding the book was pure serendipity."
    ),
    WordInformation(
        word: "benevolent",
        definitions: "Well meaning and kindly.",
        phonetic: "/bəˈnɛvələnt/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/benevolent-us.mp3",
        synonyms: ["kind", "generous", "compassionate"],
        antonyms: ["malevolent", "unkind"],
        example: "She was a benevolent leader who cared deeply about her people."
    ),
    WordInformation(
        word: "ephemeral",
        definitions: "Lasting for a very short time.",
        phonetic: "/ɪˈfɛmərəl/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/ephemeral-us.mp3",
        synonyms: ["transient", "fleeting", "momentary"],
        antonyms: ["permanent", "enduring"],
        example: "The beauty of the sunset was ephemeral."
    ),
    WordInformation(
        word: "fortitude",
        definitions: "Courage in pain or adversity.",
        phonetic: "/ˈfɔːrtɪˌtjuːd/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/fortitude-us.mp3",
        synonyms: ["courage", "bravery", "resilience"],
        antonyms: ["cowardice", "fear"],
        example: "She endured the hardship with fortitude."
    ),
    WordInformation(
        word: "gregarious",
        definitions: "Fond of company; sociable.",
        phonetic: "/ɡrɪˈɡɛəriəs/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/gregarious-us.mp3",
        synonyms: ["sociable", "outgoing", "friendly"],
        antonyms: ["reserved", "shy"],
        example: "He was a gregarious person who loved parties."
    ),
    WordInformation(
        word: "haphazard",
        definitions: "Lacking any obvious principle of organization.",
        phonetic: "/hæpˈhæzərd/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/haphazard-us.mp3",
        synonyms: ["random", "chaotic", "disorganized"],
        antonyms: ["organized", "systematic"],
        example: "The books were piled in a haphazard manner."
    ),
    WordInformation(
        word: "jubilant",
        definitions: "Feeling or expressing great happiness and triumph.",
        phonetic: "/ˈdʒuːbɪlənt/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/jubilant-us.mp3",
        synonyms: ["joyful", "elated", "exultant"],
        antonyms: ["mournful", "sad"],
        example: "The team was jubilant after their victory."
    ),
    WordInformation(
        word: "kinetic",
        definitions: "Relating to or resulting from motion.",
        phonetic: "/kɪˈnɛtɪk/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/kinetic-us.mp3",
        synonyms: ["dynamic", "active", "moving"],
        antonyms: ["static", "still"],
        example: "The sculpture captures kinetic energy perfectly."
    ),
    WordInformation(
        word: "lucid",
        definitions: "Expressed clearly; easy to understand.",
        phonetic: "/ˈluːsɪd/",
        audio: "https://api.dictionaryapi.dev/media/pronunciations/en/lucid-us.mp3",
        synonyms: ["clear", "intelligible", "comprehensible"],
        antonyms: ["confused", "unclear"],
        example: "His explanation was lucid and easy to follow."
    )
]
