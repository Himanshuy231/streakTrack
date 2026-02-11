//
//  ContentView.swift
//  streakTrack
//
//  Created by himanshu yadav on 22/11/1947 Saka.
//
import SwiftUI
import UserNotifications


struct ContentView: View {
    @State private var freezeCount = UserDefaults.standard.integer(forKey: "freezeCount")
    
    @State private var showMilestoneAlert = false
    @State private var milestoneMessage = ""
    
    @State private var practiceDates: [Date] = UserDefaults.standard.array(forKey: "practiceDates") as? [Date] ?? []
    
    @State private var currentStreak = UserDefaults.standard.integer(forKey: "currentStreak")
    @State private var longestStreak = UserDefaults.standard.integer(forKey: "longestStreak")
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Practice Streak")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Current Streak: \(currentStreak)")
                .font(.title2)
            
            Text("Longest Streak: \(longestStreak)")
                .font(.title3)
                .foregroundColor(.gray)
            
            Text("Freezes Available: \(freezeCount)")
                .font(.subheadline)
                .foregroundColor(.blue)
            
            
            // Button
            Button(action: markPracticeDone) {
                Text("Mark Practice Done")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            Divider()
            
            // Practice History Section
            Text("Practice History")
                .font(.headline)
            
            List(practiceDates, id: \.self) { date in
                Text(date.formatted(date: .abbreviated, time: .omitted))
            }
            .frame(height: 200)
        }
        .padding()
        
        .alert("Milestone Reached!", isPresented: $showMilestoneAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(milestoneMessage)
        }
        
        //Call Permission Request
        .onAppear {
            requestNotificationPermission()
        }

        
    }
    
    
    func markPracticeDone() {
        
        let today = Calendar.current.startOfDay(for: Date())
        let lastPracticeTime = UserDefaults.standard.object(forKey: "lastPracticeDate") as? Date
        
        if let lastPractice = lastPracticeTime {
            
            let lastPracticeDay = Calendar.current.startOfDay(for: lastPractice)
            
            // Already practiced today
            if lastPracticeDay == today {
                return
            }
            
            // Practiced yesterday → increase streak
            if Calendar.current.isDate(lastPracticeDay, inSameDayAs: today.addingTimeInterval(-86400)) {
                currentStreak += 1
            }
            else {
                // Missed a day
                if freezeCount > 0 {
                    freezeCount -= 1   // use freeze
                } else {
                    currentStreak = 1  // reset streak
                }
            }
            
        } else {
            // First time practicing
            currentStreak = 1
        }
        
        if currentStreak > longestStreak {
            longestStreak = currentStreak
        }
        
        // Milestone check (test)
        if currentStreak == 2 {
            milestoneMessage = "🎉 Great job! You reached a 2-day streak!"
            showMilestoneAlert = true
        }
        
        // Save data
        UserDefaults.standard.set(currentStreak, forKey: "currentStreak")
        UserDefaults.standard.set(longestStreak, forKey: "longestStreak")
        UserDefaults.standard.set(today, forKey: "lastPracticeDate")
        UserDefaults.standard.set(freezeCount, forKey: "freezeCount")
        
        practiceDates.append(today)
        UserDefaults.standard.set(practiceDates, forKey: "practiceDates")
    }
    init() {
        if UserDefaults.standard.object(forKey: "freezeCount") == nil {
            freezeCount = 1
            UserDefaults.standard.set(1, forKey: "freezeCount")
        }
    }
    
//    Request Notification Permission
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                scheduleDailyReminder()
            }
        }
    }
    
    // Call Permission Request
    
    func scheduleDailyReminder() {

        let center = UNUserNotificationCenter.current()

        // Remove existing reminders
        center.removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])

        let content = UNMutableNotificationContent()
        content.title = "Practice Reminder"
        content.body = "Don't forget to practice today to keep your streak!"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(
            identifier: "dailyReminder",
            content: content,
            trigger: trigger
        )

        center.add(request)
    }




}

#Preview {
    ContentView()
}
