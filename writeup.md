Brief Write-up

The Practice Streak Tracker feature is designed to motivate users to practice speech exercises consistently. In speech therapy, daily repetition plays a crucial role in improving pronunciation and fluency. A streak-based system encourages habit formation by providing measurable progress and positive reinforcement.

This feature integrates seamlessly into a speech therapy application by allowing users to mark daily practice completion. The app calculates the current streak based on the last practice date and increases it only when practice is completed on consecutive days. If a day is missed, the streak resets unless the user has an available streak freeze, which protects progress for a limited number of days. This ensures fairness while still encouraging regular engagement.

To increase user motivation, milestone celebrations notify users when they reach specific streak targets. These small rewards help reinforce positive behavior and encourage continued participation. A practice history section allows users to view past activity, providing a visual sense of progress over time.

User engagement is further improved through daily reminder notifications. These reminders are scheduled locally and help users maintain consistency without needing to open the application manually.

The feature was implemented using SwiftUI for the user interface and UserDefaults for local persistence, ensuring that data remains available across app launches. The notification system uses the UserNotifications framework to schedule daily reminders. The application architecture keeps the logic simple and maintainable, making it easy to integrate into a larger speech therapy platform.

Overall, this feature improves retention by encouraging daily interaction, rewarding consistency, and providing meaningful feedback to users. It supports the goals of a speech therapy platform by promoting habit formation and measurable progress.
