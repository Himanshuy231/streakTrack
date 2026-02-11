Practice Streak Tracker (iOS App)

Overview :
This is a SwiftUI-based iOS application that helps users maintain a daily practice streak.
The app tracks consecutive practice days, provides reminders, and protects streaks using a freeze mechanism.

Features :

1. Daily practice tracking

2. Current streak and longest streak display

3. Practice history tracking

4. Streak freeze to prevent streak loss

5. Milestone celebration alerts

6. Daily reminder notifications

7. Local data persistence using UserDefaults

Tech Stack :

. Swift

. SwiftUI

. UserDefaults (local storage)

. UserNotifications framework

How It Works :

1. User taps Mark Practice Done
2.App checks:
 If already practiced today → ignore

 If practiced yesterday → increase streak

 If missed a day → use freeze or reset streak

3. Data is saved locally

4. Notifications remind user daily

Architecture : 
 The app follows a simple structure:

1. View (UI using SwiftUI)

2. Business logic inside View methods

3. Local persistence with UserDefaults

4. Notification scheduling using UNUserNotificationCenter

Future Improvements ::::::

. Calendar heatmap

. Cloud sync

. Better UI animations

. Multiple habit tracking

Screenshots :::
![Uploading Screenshot 1947-11-23 at 1.48.34 AM.png…]()

