# SportsApp 🏀⚽🏈

Welcome to **SportsApp**, where you can explore the world of sports, leagues, and teams—all in one place! Built with Swift, UIKit, MVVM, CoreData, and some magic. ✨

## What's inside the app?

### Sports Tab 🏅
- On the **first tab**, you get to scroll through all the sports available, laid out in a clean 2-column collection view. No spaces between them, so it's like sports heaven right on your screen.
- Each sport shows its name and thumbnail. If a sport is missing its image, we’ve got it covered with a placeholder to ensure everything stays sharp.
- Tap on any sport to view all leagues related to that sport.

### Favorite Leagues Tab ⭐
- The **second tab** houses your favorite leagues, stored locally using CoreData, so they’re always available even when offline.
- The layout matches the Leagues screen for consistency.
- If you're offline and try to access a league’s details, an alert will notify you that an internet connection is required.

### Leagues View 📺
- The **Leagues screen** is a `UITableView` where each row displays:
  1. A circular badge for the league (we love round logos).
  2. The league name.
  3. A YouTube button that links to the league’s official YouTube page for highlights.
- Selecting a league navigates to the **League Details** screen.

### League Details ⚡
- The **League Details** screen is split into three sections with smooth orthogonal scrolling:
  1. **Upcoming Events**: Displays upcoming events for the league with event name, date, and time in a horizontal scroll.
  2. **Latest Results**: Shows recent match results including teams, scores, date, and time in a vertical scroll.
  3. **Teams**: Displays teams with circular images. Tapping a team takes you to the **Team Details**.

### Team Details ⚽
- The **Team Details** screen showcases team information in an elegant layout designed for clarity and aesthetic appeal.

## Special Touches 🌟
- **Dark Mode**: The app fully supports dark mode, maintaining its sleek design across both light and dark themes.
- **Image Handling**: Missing images are no issue! We’ve implemented placeholder images for missing content, ensuring the UI remains polished.

## Tech Stack 🛠️
- **MVVM**: For clean separation of concerns and easy maintainability.
- **CoreData**: To manage and store favorite leagues locally.
- **Alamofire**: For making network requests to the sports API. [Alamofire GitHub](https://github.com/Alamofire/Alamofire)
- **Kingfisher**: To download and cache images seamlessly. [Kingfisher GitHub](https://github.com/onevcat/Kingfisher)

## Unit Testing ✅
- We’ve implemented unit tests with a focus on the network layer, ensuring robust performance, with **100% network class code coverage** for reliability.

## Installation Guide 🚀

1. **Clone the repository:**
   ```bash
   git clone https://github.com/M7Aymn/SportsApp.git
   ```

2. **Install dependencies using CocoaPods:**
   ```bash
   pod install
   ```

3. **Generate an API token:**
   - Go to [All Sports API](https://allsportsapi.com/) and sign up for an account.
   - Generate a new API token, which will be required for the app to function properly.

4. **Open the project in Xcode:**
   ```bash
   open SportsApp.xcworkspace
   ```
5. **Replace token** in Services/Remote/API.swift

6. **Build and run the app** on your simulator or connected device.

---

Feel free to explore and contribute! 😊


<img src="https://github.com/user-attachments/assets/6971c3f7-3686-4727-98df-cbd5baef5916" width="150" />
<img src="https://github.com/user-attachments/assets/81b00483-8dd0-4ad8-96b3-00f2e05279d2" width="150" />
<img src="https://github.com/user-attachments/assets/f62dbd60-9346-4d51-a2ac-f96b1739888d" width="150" />
<img src="https://github.com/user-attachments/assets/95772140-067d-4962-8d68-ddd4c25d20e7" width="150" />
<img src="https://github.com/user-attachments/assets/21ba4bcb-9b5b-467e-a621-8195c39ebd7c" width="150" />
<img src="https://github.com/user-attachments/assets/25961ae5-7fb9-4995-a411-dce563ce2b68" width="150" />
<img src="https://github.com/user-attachments/assets/46e6581e-848c-4c50-92d2-2d53fb8257ce" width="150" />
<img src="https://github.com/user-attachments/assets/1af3e475-4c44-4cde-9022-25cf39ae8ef6" width="150" />
<img src="https://github.com/user-attachments/assets/e46542de-22f9-4465-99f7-a97b7df79c25" width="150" />
<img src="https://github.com/user-attachments/assets/a1abe7db-8561-45db-b057-27ac193a7a1a" width="150" />
<img src="https://github.com/user-attachments/assets/105a4b5a-b3c7-4e55-820f-3146743d0777" width="150" />
<img src="https://github.com/user-attachments/assets/3634fc77-ddda-421a-87dc-e807a7a04771" width="150" />
<img src="https://github.com/user-attachments/assets/cffe523f-bbc3-41a3-af9c-fadfadaa4a05" width="150" />
<img src="https://github.com/user-attachments/assets/d92fcf80-ac0b-452b-a2ba-ea92408a488a" width="150" />
<img src="https://github.com/user-attachments/assets/76ef5c42-0b51-4fe9-bf70-b61211df4b63" width="150" />
<img src="https://github.com/user-attachments/assets/b46e9394-cd0f-45b1-bf97-0587e69837c8" width="150" />
<img src="https://github.com/user-attachments/assets/6c81d4d2-2a09-4471-af79-cfb73afa648b" width="150" />
<img src="https://github.com/user-attachments/assets/e71b1e73-63a0-49dd-b86d-9d67c63ed647" width="150" />
<img src="https://github.com/user-attachments/assets/47a2dc73-007f-47f6-8c57-701dec68ac4e" width="150" />
<img src="https://github.com/user-attachments/assets/c7bef0d4-4383-451a-8456-45a7f937de7a" width="150" />
<img src="https://github.com/user-attachments/assets/a80a33d3-7291-467d-bae3-93ddc76b5793" width="150" />
<img src="https://github.com/user-attachments/assets/7fb87c73-676e-40e3-a498-da29ce45bd1f" width="150" />
<img src="https://github.com/user-attachments/assets/097ae43a-c888-482b-b95c-80e451ee6d95" width="150" />
<img src="https://github.com/user-attachments/assets/38ab5f97-8805-468e-9f69-e2417e523126" width="150" />
<img src="https://github.com/user-attachments/assets/7136cf04-1971-49e4-a00a-5629c2237178" width="150" />
<img src="https://github.com/user-attachments/assets/b57362da-ef4b-4260-b3d5-a30624deb548" width="150" />
<img src="https://github.com/user-attachments/assets/ec85589b-238f-4f12-92d6-b07081839f90" width="150" />
<img src="https://github.com/user-attachments/assets/0c47fe30-fe77-431c-8517-01f37faf94d6" width="150" />
<img src="https://github.com/user-attachments/assets/3616d428-f51b-4756-b0aa-8b7875dcc719" width="150" />
<img src="https://github.com/user-attachments/assets/778c1c6c-6b6d-4126-ac63-0af25c254ca8" width="150" />
<img src="https://github.com/user-attachments/assets/3616b772-48f8-448f-b254-13abd1f88ffd" width="150" />

