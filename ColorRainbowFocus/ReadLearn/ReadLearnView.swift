import SwiftUI

struct ReadingMaterial: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let fullText: String
    let duration: String
}

let sampleReads: [ReadingMaterial] = [
    ReadingMaterial(
        title: "The Myth of Multitasking",
        subtitle: "Why Doing Less Helps You Achieve More",
        fullText: "Multitasking feels productive — you’re answering emails, scrolling, eating lunch, thinking about that meeting. But studies show your brain isn’t truly doing multiple things at once. It’s rapidly switching between tasks, and that switching costs energy, focus, and quality.\n\nThe truth? Multitasking lowers efficiency by up to 40% and increases stress. It pulls your attention in micro-fragments and prevents deep engagement — the kind that produces your best work and your most fulfilling moments.\n\nModern culture glorifies 'busy' as if juggling everything is the goal. But high performers in every field — artists, athletes, entrepreneurs — all have one thing in common: they focus. Deeply. Repeatedly. Intentionally.\n\nInstead of stretching yourself thin, try this:\n- Choose one priority for the next hour. Just one.\n- Turn off your notifications. Not forever — just for now.\n- Set a 20-minute Rainbow Focus session to enter flow.\n- When your mind wanders, gently bring it back. Like a muscle, focus gets stronger with use.\n\n✨ Multitasking is a myth. Presence is the secret. Every time you choose one thing — fully — you create space for quality, peace, and true momentum.",
        duration: "~3 minutes"
    ),
    ReadingMaterial(
        title: "Clarity Isn’t Found — It’s Created",
        subtitle: "Cut Through the Mental Fog with Small Intentions",
        fullText: "We often wait for clarity like it’s a weather pattern — hoping the fog lifts before we act. But what if clarity isn’t something you wait for? What if it’s something you *make*?\n\nMental fog isn’t always solved by doing more. Sometimes it’s solved by doing less — and doing it with intention. When everything feels like a blur, your job isn’t to push harder. It’s to pause, breathe, and simplify.\n\nHere’s a path to clarity:\n- Each morning, write down one clear intention. Not a to-do, but a *to-feel* — something like “Today I want to feel grounded” or “Today I want to feel light.”\n- When facing a decision, ask: “Does this bring me closer to clarity or further into clutter?”\n- Practice single-tasking. Your mind finds peace when it’s not split in ten directions.\n\n🔵 Use the Clarity session in Rainbow Focus to clear internal space. Blue is the color of still water and wide skies — it invites calm thinking and refined choices.\n\nYou don’t find clarity by overthinking. You create it by slowing down and choosing with presence. It’s already inside you — beneath the noise. All you have to do is listen.",
        duration: "~4 minutes"
    ),
    ReadingMaterial(
        title: "The Power of One Hour",
        subtitle: "Why Less Time Can Create More Depth",
        fullText: "There’s something sacred about an hour. Not too long. Not too short. Just enough time to do something meaningful — if you give it your full attention.\n\nMost of us waste hours in micro-distractions. We start something, then check a message. Open a document, then scroll. Not because we’re lazy — but because we’re overstimulated. The mind craves novelty, but it *needs* depth.\n\nOne hour of true focus is more valuable than five hours of scattered effort. It’s where the magic happens — where your creativity, logic, and memory align. A single hour of deep work can:\n- Finish what you’ve been putting off for days.\n- Reignite a personal project you’ve neglected.\n- Give you the emotional clarity you didn’t know you needed.\n\nTo protect this hour, treat it like a ritual:\n1. Prepare your space — clean, quiet, minimal.\n2. Choose your color. 🟧 Momentum if you want movement. 🔷 Deep Focus if you’re going deep. 🟪 Imagination if you’re creating.\n3. Set your Rainbow Focus timer. Let the countdown be your anchor.\n4. Start. Not perfectly — just fully.\n\n⏳ You’ll feel resistance at first. That’s normal. Sit with it. Let your mind settle. Within minutes, the world will narrow, and something beautiful will unfold: presence.\n\nOne focused hour a day isn’t a productivity hack. It’s a self-respect practice. Time is precious. So are you.",
        duration: "~4 minutes"
    ),
    ReadingMaterial(
        title: "Slow is Not a Weakness",
        subtitle: "Reclaiming the Power of a Thoughtful Pace",
        fullText: "We’re told to move fast. Respond quickly. Stay ahead. But what if the speed you’ve been chasing is the very thing keeping you from your best work?\n\nSlowness isn’t laziness — it’s depth. It’s the space between stimulus and response. It’s choosing not to react instantly, but to reflect intentionally.\n\nThink about it:\n- A thoughtful answer often says more than a fast reply.\n- A slow morning can set the tone for an entire clear-headed day.\n- Taking your time isn’t wasting time. It’s *owning* it.\n\nIn slowness, the noise fades. The real ideas show up. The decisions become clearer. There’s less rushing, and more arriving. Less burnout, more presence.\n\nAsk yourself:\n- What would I do differently if I wasn’t in a hurry?\n- Where can I let go of urgency that’s not mine?\n- What would it feel like to move with calm, steady purpose — even in a fast world?\n\nThe pace of peace isn’t always slow. But it’s never rushed.\n\nYou are not behind. You are exactly where you are. And that’s where everything begins.",
        duration: "~4 minutes"
    ),
    ReadingMaterial(
        title: "Let It Be Simple",
        subtitle: "How Less Can Quiet the Mind",
        fullText: "There’s a quiet magic in simplicity. In the single task. The clean workspace. The no-fuss morning routine. We often chase complexity because it looks impressive. But it’s simplicity that frees us.\n\nYour mind craves clarity, not chaos. And it’s not just about minimalism — it’s about *mental spaciousness*. When there’s too much on your plate, your brain goes into defense mode. When there’s just enough, it can thrive.\n\nHere’s what simplicity might look like today:\n- Saying no to one thing that isn’t aligned.\n- Choosing just one focus for the next hour.\n- Creating a quiet moment before your day begins — no screens, no inputs.\n\nIt’s not always easy. Simplicity often feels like discomfort at first. The silence. The stillness. But underneath it is your most focused self. Your clearest thoughts. Your real priorities.\n\nYou don’t need to do everything. You need to do the right things — without the noise.\n\nLet today be light. Let it be clear. Let it be simple.",
        duration: "~3 minutes"
    ),
    ReadingMaterial(
        title: "The Beauty of Boredom",
        subtitle: "Why Doing Nothing Is the Start of Everything",
        fullText: "We avoid boredom at all costs. Reach for our phones. Refresh the feed. Fill the silence. But what if boredom isn’t a gap to be filled — what if it’s a doorway?\n\nBoredom is the brain’s whisper that it’s ready to wander. Ready to think differently. To dream again. It’s not emptiness — it’s incubation. The space where new thoughts are born.\n\nYour best ideas rarely come when you're trying. They arrive in the shower, on a walk, during a quiet stare out the window. Not because you're distracted, but because you're *unguarded*. Because your mind has room.\n\nBoredom isn’t the enemy. Distraction is. And the difference is subtle:\n- Distraction pulls you *away* from your mind.\n- Boredom nudges you *back* toward it.\n\nLet yourself be bored sometimes. Resist the urge to fill every silence. Sit still. Let your thoughts meander. Let your inner world speak without interruption.\n\nIn boredom, we meet ourselves. And from there, everything meaningful begins.\n\n✨ The mind, left alone, often knows exactly where to go.",
        duration: "~4 minutes"
    ),
    ReadingMaterial(
        title: "The Art of Starting Small",
        subtitle: "Build Big Change in Quiet, Gentle Ways",
        fullText: "We often think change has to be big to matter. That progress only counts if it’s visible, measurable, impressive. But the truth? Big things are built from small, consistent steps — repeated with care.\n\nStarting small isn’t weakness. It’s wisdom. It’s how habits form, confidence grows, and transformation actually lasts.\n\nConsider:\n- One page a day becomes a book.\n- Ten mindful minutes becomes a mindset.\n- A single shift in focus becomes a new way of being.\n\nMost people give up not because they didn’t try hard enough — but because they tried to do too much, too fast. Start smaller than you think you need to. Celebrate quietly. Build trust with yourself.\n\nAsk yourself:\n- What’s the smallest next step I can take today?\n- Can I show up for five minutes without pressure to finish?\n- What if progress felt gentle, not forceful?\n\n🌱 Small is powerful. It’s patient. And it compounds. Don’t wait for the perfect moment to start big. Begin humbly. Begin today.\n\nBig things grow quietly. Let them.",
        duration: "~4 minutes"
    )
]

struct ReadLearnView: View {
    @State private var selectedRead: ReadingMaterial?
    @State private var showDetail = false
    @State private var showShare = false
    @State private var shareText = ""
    
    var body: some View {
        ZStack {
            Color(hex: "#055426").ignoresSafeArea()
            VStack() {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(#colorLiteral(red: 0.055658284574747086, green: 0.4134615361690521, blue: 0.20512039959430695, alpha: 1)))
                    .frame(width: 393, height: 167)
                    Text("Read & Learn")
                        .font(.custom("LibreBaskerville-Bold", size: 22))
                        .foregroundColor(.white)
                }
                .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(sampleReads) { item in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(item.title)
                                    .font(.custom("LibreBaskerville-Bold", size: 17))
                                    .foregroundColor(.white)
                                
                                Text(item.subtitle)
                                    .font(.custom("Montserrat-Regular", size: 15))
                                    .foregroundColor(.white.opacity(0.8))
                                
                                HStack(spacing: 6) {
                                    Image(systemName: "clock")
                                        .foregroundColor(.white.opacity(0.7))
                                    Text(item.duration)
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.custom("Montserrat-Medium", size: 18))
                                }
                                
                                HStack(spacing: 16) {
                                    Button("Read") {
                                        withAnimation {
                                            selectedRead = item
                                            showDetail = true
                                        }
                                    }
                                    .frame(width: 100, height: 36)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .font(.custom("LibreBaskerville-Regular", size: 17))
                                    
                                    Button("Share") {
                                        shareText = "\(item.title)\n\(item.subtitle)\n\n\(item.fullText)"
                                        showShare = true
                                    }
                                    .frame(width: 100, height: 36)
                                    .background(Color.white.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.custom("LibreBaskerville-Regular", size: 17))
                                }
                            }
                            .padding()
                            .frame(width: 344, height: 200)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(16)
                        }
                    }
                    
                    .padding()
                    Spacer().frame(height: 120)
                }
                
                
            }
            .ignoresSafeArea()
            .blur(radius: showDetail ? 10 : 0)
            
            if let read = selectedRead, showDetail {
                ReadDetailView(read: read, isPresented: $showDetail)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .sheet(isPresented: $showShare) {
            ActivityView(activityItems: [shareText])
        }
    }
}

struct ReadDetailView: View {
    let read: ReadingMaterial
    @Binding var isPresented: Bool
    @State private var showRating = false
    @State private var rated = false
    @State private var selectedStars = 0
    
    var body: some View {
        ZStack {
            Color(hex: "#0E6934").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    Spacer()
                }
                .padding(.top)
                
                Text(read.title)
                    .font(.custom("LibreBaskerville-Bold", size: 21))
                    .foregroundColor(.white)
                
                Text(read.subtitle)
                    .font(.custom("Montserrat-Medium", size: 18))
                    .foregroundColor(.white.opacity(0.8))
                
                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .foregroundColor(.white.opacity(0.7))
                    Text(read.duration)
                        .foregroundColor(.white.opacity(0.7))
                        .font(.custom("Montserrat-Bold", size: 15))
                }
                
                ScrollView {
                    Text(read.fullText)
                        .foregroundColor(.white)
                        .font(.custom("Montserrat-Reugar", size: 18))
                }
                
                Button("Rate") {
                    withAnimation {
                        showRating = true
                    }
                }
                .frame(width: 100, height: 36)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .font(.custom("LibreBaskerville-Regular", size: 17))
                
                Spacer().frame(height: 60)
            }
            .blur(radius: showRating ? 10 : 0)
            .padding()
            
            if showRating {
                ZStack {
                    VStack(spacing: 16) {
                        if rated {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.green)
                            Text("Thank you!")
                                .font(.custom("LibreBaskerville-Bold", size: 21))
                                .foregroundColor(.white)
                        } else {
                            Spacer().frame(height: 50)
                            HStack(spacing: 10) {
                                ForEach(1...5, id: \.self) { i in
                                    Image(systemName: i <= selectedStars ? "star.fill" : "star")
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(.yellow)
                                        .onTapGesture {
                                            selectedStars = i
                                        }
                                }
                            }
                            Spacer().frame(height: 50)
                            HStack(spacing: 16) {
                                Button("Close") {
                                    withAnimation {
                                        showRating = false
                                    }
                                }
                                .frame(width: 100, height: 36)
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.custom("LibreBaskerville-Regular", size: 17))
                                Button("Rate") {
                                    withAnimation {
                                        rated = true
                                    }
                                }
                                .font(.custom("LibreBaskerville-Regular", size: 17))
                                .disabled(selectedStars == 0)
                                .frame(width: 100, height: 36)
                                .background(selectedStars == 0 ? Color.white.opacity(0.3) : Color.white)
                                .foregroundColor(selectedStars == 0 ? .black.opacity(0.3) : .black)
                                .cornerRadius(10)
                            }
                        }
                        
                        if rated {
                            Button("Close") {
                                withAnimation {
                                    showRating = false
                                    rated = false
                                    selectedStars = 0
                                }
                            }
                            .frame(width: 120, height: 40)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.custom("LibreBaskerville-Regular", size: 17))
                        }
                    }
                    .padding()
                    .frame(width: 300)
                    .background(Color(hex: "#0E6934"))
                    .cornerRadius(24)
                }
                .transition(.scale)
            }
        }
    }
}


#Preview {
    ReadLearnView()
}
