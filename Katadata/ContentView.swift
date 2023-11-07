import SwiftUI
import Combine

struct AnimalFact {
    var name: String
    var fact: String
    
struct ContentView: View {
    @State private var userInput = ""
    @State private var timeRemaining = 40
    @State private var points = 0
    @State private var currentAnimalIndex = 0
    @State private var showFact = false
    @State private var showAlert = false
    @State private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    @State private var cancellable: Set<AnyCancellable> = []
    @State private var animalFacts: [AnimalFact] = [
        
        AnimalFact(name: "こんにちは", fact: "(Konnichiwa) Hello"),
          AnimalFact(name: "ありがとう", fact: "(Arigatou) Thank you"),
          AnimalFact(name: "すごい", fact: "(Sugoi) Amazing"),
          AnimalFact(name: "いいえ", fact: "(Iie) No"),
          AnimalFact(name: "はい", fact: "(Hai) Yes"),
          AnimalFact(name: "ごめんなさい", fact: "(Gomen nasai) I'm sorry"),
          AnimalFact(name: "はじめまして", fact: "(Hajimemashite) Nice to meet you"),
          AnimalFact(name: "いただきます", fact: "(Itadakimasu) Let's eat (before a meal)"),
        AnimalFact(name: "ごちそうさまでした", fact: "(Gochisousama deshita) Thank you for the meal (after a meal)"),
           AnimalFact(name: "おはよう", fact: "(Ohayou) Good morning"),
           AnimalFact(name: "こんばんは", fact: "(Konbanwa) Good evening"),
           AnimalFact(name: "おやすみなさい", fact: "(Oyasuminasai) Goodnight"),
           AnimalFact(name: "わかりました", fact: "(Wakarimashita) I understand"),
           AnimalFact(name: "もちろん", fact: "(Mochiron) Of course"),
           AnimalFact(name: "わかりません", fact: "(Wakarimasen) I don't understand"),
           AnimalFact(name: "すみません", fact: "(Sumimasen) Excuse me / I'm sorry"),
           AnimalFact(name: "お手伝いできますか", fact: "(Otetsudai dekimasu ka) Can I help you?"),
           AnimalFact(name: "かわいい", fact: "(Kawaii) Cute"),
           AnimalFact(name: "おめでとう", fact: "(Omedetou) Congratulations"),
        AnimalFact(name: "ごちそうさまでした", fact: "(Gochisousama deshita) Thank you for the meal (after a meal)"),
        AnimalFact(name: "おはよう", fact: "(Ohayou) Good morning"),
        AnimalFact(name: "こんばんは", fact: "(Konbanwa) Good evening"),
        AnimalFact(name: "おやすみなさい", fact: "(Oyasuminasai) Goodnight"),
        AnimalFact(name: "わかりました", fact: "(Wakarimashita) I understand"),
        AnimalFact(name: "もちろん", fact: "(Mochiron) Of course"),
        AnimalFact(name: "わかりません", fact: "(Wakarimasen) I don't understand"),
        AnimalFact(name: "すみません", fact: "(Sumimasen) Excuse me / I'm sorry"),
        AnimalFact(name: "かわいい", fact: "(Kawaii) Cute"),
        AnimalFact(name: "おめでとう", fact: "(Omedetou) Congratulations"),
        AnimalFact(name: "おはようございます", fact: "(Ohayou gozaimasu) Good morning"),
          AnimalFact(name: "ありがとうございます", fact: "(Arigatou gozaimasu) Thank you very much"),
          AnimalFact(name: "おやすみなさい", fact: "(Oyasuminasai) Goodnight"),
          AnimalFact(name: "どういたしまして", fact: "(Dou itashimashite) You're welcome"),
          AnimalFact(name: "すみませんが", fact: "(Sumimasen ga) Excuse me, but..."),
          AnimalFact(name: "よくやった", fact: "(Yoku yatta) Well done"),
          AnimalFact(name: "わかりました", fact: "(Wakarimashita) I understand"),
          AnimalFact(name: "もちろん", fact: "(Mochiron) Of course"),
          AnimalFact(name: "わかりません", fact: "(Wakarimasen) I don't understand"),
          AnimalFact(name: "すみません", fact: "(Sumimasen) Excuse me / I'm sorry"),
          AnimalFact(name: "さようなら", fact: "(Sayounara) Goodbye"),
          AnimalFact(name: "おめでとう", fact: "(Omedetou) Congratulations"),
          AnimalFact(name: "ありがとうございます", fact: "(Arigatou gozaimasu) Thank you very much"),
          AnimalFact(name: "おやすみなさい", fact: "(Oyasuminasai) Goodnight"),
          AnimalFact(name: "どういたしまして", fact: "(Dou itashimashite) You're welcome"),
          AnimalFact(name: "すみませんが", fact: "(Sumimasen ga) Excuse me, but..."),
          AnimalFact(name: "よくやった", fact: "(Yoku yatta) Well done"),
          AnimalFact(name: "おいしい", fact: "(Oishii) Tasty"),
          AnimalFact(name: "おはようございます", fact: "(Ohayou gozaimasu) Good morning"),
          AnimalFact(name: "こんばんは", fact: "(Konbanwa) Good evening"),
          AnimalFact(name: "おやすみなさい", fact: "(Oyasuminasai) Goodnight"),
          AnimalFact(name: "もちろん", fact: "(Mochiron) Of course"),
          AnimalFact(name: "わかりません", fact: "(Wakarimasen) I don't understand"),
          AnimalFact(name: "すみません", fact: "(Sumimasen) Excuse me / I'm sorry"),
    
        AnimalFact(name: "おばあちゃん", fact: "(Obaachan) Grandmother"),
        AnimalFact(name: "おじいちゃん", fact: "(Ojiichan) Grandfather"),
        AnimalFact(name: "おしゃべり", fact: "(Oshaberi) Chit-chat"),
        AnimalFact(name: "カラオケ", fact: "(Karaoke) Karaoke"),
        AnimalFact(name: "おいしい", fact: "(Oishii) Delicious"),
        AnimalFact(name: "びっくりする", fact: "(Bikkuri suru) Surprised"),
        AnimalFact(name: "ただいま", fact: "(Tadaima) I'm back"),
        AnimalFact(name: "おみやげ", fact: "(Omiyage) Souvenir"),
        AnimalFact(name: "おすすめ", fact: "(Osusume) Recommendation"),
        AnimalFact(name: "ホテル", fact: "(Hoteru) Hotel"),
        AnimalFact(name: "バス", fact: "(Basu) Bus"),
        AnimalFact(name: "タクシー", fact: "(Takushii) Taxi"),
        AnimalFact(name: "カフェ", fact: "(Kafe) Cafe"),
        AnimalFact(name: "ショッピング", fact: "(Shoppingu) Shopping"),
        AnimalFact(name: "ラーメン", fact: "(Ramen) Ramen"),
        AnimalFact(name: "おすし", fact: "(Osushi) Sushi"),
        AnimalFact(name: "あたま", fact: "(Atama) Head"),
         AnimalFact(name: "てがみ", fact: "(Tegami) Letter"),
         AnimalFact(name: "おとこのこ", fact: "(Otokonoko) Boy"),
         AnimalFact(name: "おんなのこ", fact: "(Onnanoko) Girl"),
         AnimalFact(name: "あさごはん", fact: "(Asagohan) Breakfast"),
         AnimalFact(name: "ばんごはん", fact: "(Bangohan) Dinner"),
         AnimalFact(name: "あたらしい", fact: "(Atarashii) New"),
         AnimalFact(name: "たのしい", fact: "(Tanoshii) Fun"),
         AnimalFact(name: "しずか", fact: "(Shizuka) Quiet"),
         AnimalFact(name: "あかるい", fact: "(Akarui) Bright"),
         AnimalFact(name: "くるま", fact: "(Kuruma) Car"),
         AnimalFact(name: "ほん", fact: "(Hon) Book"),
         AnimalFact(name: "つくえ", fact: "(Tsukue) Desk"),
         AnimalFact(name: "でんわ", fact: "(Denwa) Phone"),
         AnimalFact(name: "くつ", fact: "(Kutsu) Shoes"),
         AnimalFact(name: "きっさてん", fact: "(Kissaten) Cafe"),
         AnimalFact(name: "かばん", fact: "(Kaban) Bag"),
         AnimalFact(name: "てがみ", fact: "(Tegami) Letter"),
         AnimalFact(name: "あめ", fact: "(Ame) Rain"),
         AnimalFact(name: "ねこ", fact: "(Neko) Cat"),
        AnimalFact(name: "くるま", fact: "(Kuruma) Car"),
        AnimalFact(name: "ほんだな", fact: "(Hondana) Bookshelf"),
        AnimalFact(name: "ねこ", fact: "(Neko) Cat"),
        AnimalFact(name: "いぬ", fact: "(Inu) Dog"),
        AnimalFact(name: "くつした", fact: "(Kutsushita) Socks"),
        AnimalFact(name: "てがみ", fact: "(Tegami) Letter"),
        AnimalFact(name: "あめ", fact: "(Ame) Rain"),
        AnimalFact(name: "たべもの", fact: "(Tabemono) Food"),
        AnimalFact(name: "のみもの", fact: "(Nomimono) Drink"),
        AnimalFact(name: "ははおや", fact: "(Hahaoya) Mother"),
        AnimalFact(name: "ちちおや", fact: "(Chichioya) Father"),
        AnimalFact(name: "あおい", fact: "(Aoi) Blue"),
        AnimalFact(name: "あかい", fact: "(Akai) Red"),
        AnimalFact(name: "しろい", fact: "(Shiroi) White"),
        AnimalFact(name: "くろい", fact: "(Kuroi) Black"),
        AnimalFact(name: "あおぞら", fact: "(Aozora) Blue sky"),
        AnimalFact(name: "あかちゃん", fact: "(Akachan) Baby"),
        AnimalFact(name: "いもうと", fact: "(Imouto) Younger sister"),
        AnimalFact(name: "おとうと", fact: "(Otouto) Younger brother"),
        AnimalFact(name: "おばあさん", fact: "(Obaasan) Grandmother"),
        AnimalFact(name: "おじいさん", fact: "(Ojiisan) Grandfather"),
        AnimalFact(name: "さくらんぼ", fact: "(Sakuranbo) Cherry"),
        AnimalFact(name: "みず", fact: "(Mizu) Water"),
        AnimalFact(name: "あたま", fact: "(Atama) Head"),
        AnimalFact(name: "め", fact: "(Me) Eye"),
        AnimalFact(name: "みみ", fact: "(Mimi) Ear"),
        AnimalFact(name: "はな", fact: "(Hana) Nose"),
        AnimalFact(name: "くち", fact: "(Kuchi) Mouth"),
        AnimalFact(name: "て", fact: "(Te) Hand"),
        AnimalFact(name: "あし", fact: "(Ashi) Leg"),
        AnimalFact(name: "ひざ", fact: "(Hiza) Knee"),
        AnimalFact(name: "あたま", fact: "(Atama) Head"),
        AnimalFact(name: "はい", fact: "(Hai) Yes"),
        AnimalFact(name: "いいえ", fact: "(Iie) No"),
        AnimalFact(name: "ありがとう", fact: "(Arigatou) Thank you"),
        AnimalFact(name: "おねがいします", fact: "(Onegaishimasu) Please"),
        AnimalFact(name: "はい、もちろん", fact: "(Hai, mochiron) Yes, of course"),
        AnimalFact(name: "おいしい", fact: "(Oishii) Delicious"),
        AnimalFact(name: "たべもの", fact: "(Tabemono) Food"),
        AnimalFact(name: "のみもの", fact: "(Nomimono) Drink"),
        AnimalFact(name: "ねむい", fact: "(Nemui) Sleepy"),
        AnimalFact(name: "あくび", fact: "(Akubi) Yawn"),
        AnimalFact(name: "くらい", fact: "(Kurai) Dark"),
        AnimalFact(name: "あかるい", fact: "(Akarui) Bright"),
        AnimalFact(name: "さむい", fact: "(Samui) Cold"),
        AnimalFact(name: "あつい", fact: "(Atsui) Hot"),
        AnimalFact(name: "はれ", fact: "(Hare) Sunny"),
        AnimalFact(name: "くもり", fact: "(Kumori) Cloudy"),
        AnimalFact(name: "あめ", fact: "(Ame) Rain"),
        AnimalFact(name: "ゆき", fact: "(Yuki) Snow"),
        
    ].shuffled()

    var body: some View {
        ZStack {
            Color.red.opacity(0.9)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("\(animalFacts[currentAnimalIndex].name)")
                    .font(.system(size: 36))
                    .shadow(color: .white, radius: 1, x: 2, y: 2)
                    .foregroundColor(.white)
                    .padding()
                
                Button("Submit") {
                    checkUserInput()
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(20)
                .padding(.top, 20)
                
                
                TextField(" ", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .cornerRadius(20)
                    .font(.system(size: 48))

                if showFact {
                    VStack {
                        Text(animalFacts[currentAnimalIndex].name)
                            .font(.title)
                        Text(animalFacts[currentAnimalIndex].fact)
                            .font(.subheadline)
                    }
                    .padding()
                }

                Text("Points: \(points)")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.top, 20)

                Text("Time remaining: \(timeRemaining) seconds")
                    .onAppear {
                        startTimer()
                    }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Get good kid"), dismissButton: .default(Text("Try Again")) {
                resetGame()
            })
        }
    }
    
    func checkUserInput() {
        if userInput.lowercased() == animalFacts[currentAnimalIndex].name.lowercased() {
            points += 1
            showFact = true
        } else {
            points = 0
            showFact = false
            showAlert = true
        }
        userInput = ""
        moveToNextAnimal()
    }
    
    func moveToNextAnimal() {
        if currentAnimalIndex < animalFacts.count - 1 {
            currentAnimalIndex += 1
        } else {
            currentAnimalIndex = 0
            animalFacts.shuffle()
        }
        resetForNextRound()
    }
    
    func resetForNextRound() {
        timeRemaining = 40
        cancellable.forEach { $0.cancel() }
        cancellable.removeAll()
        startTimer()
    }
    
    func resetGame() {
        points = 0
        currentAnimalIndex = 0
        animalFacts.shuffle()
        resetForNextRound()
    }
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        timer?.sink { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.points = 0
                self.showFact = false
                self.showAlert = true
            }
        }.store(in: &cancellable)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
