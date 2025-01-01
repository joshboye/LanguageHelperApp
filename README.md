# Language Helper App

## Setup & Compilation Instructions

### Prerequisites
- Flutter (latest stable version)
- Dart (latest stable version)
- Hive package (for local storage)
- Provider package (for state management)
- SharedPreferences package (for storing username)
  
### Installation
1. Clone the repository:
    ```bash
    git clone <repository_url>
    cd stimuler_app
    ```
2. Install dependencies:
    ```bash
    flutter pub get
    ```
3. Build and run the app:
    ```bash
    flutter run
    ```

## Architecture Overview

This app follows **Clean Architecture** principles, organizing the code into distinct layers:

- **Presentation Layer**: Contains UI components and business logic that interacts with state management (using Provider).
- **Domain Layer**: Includes use cases and entities like `Node`, `Exercise`, `Question`, and `Option`. This layer handles core business logic.
- **Data Layer**: Responsible for interacting with the Hive database and managing data storage and retrieval. It also includes SharedPreferences for storing the username.

### Database Schema

#### Exercise
- `title`: The name of the exercise.
- `questions`: A list of questions in the exercise.
- `score`: The score achieved for the exercise (optional).

#### Node
- `title`: The name of the node.
- `exercises`: A list of exercises associated with the node.

#### Question
- `text`: The text of the question.
- `options`: A list of options for the question.
- `correctOption`: The correct option for the question.

#### Option
- `text`: The text of the option.
- `isCorrect`: Whether the option is the correct answer.

### Known Limitations
- **Node Update Issue**: After completing an exercise, the node is not immediately updated on the home screen. A state issue requires fixing, as the node only updates after clicking the previous node twice.

## Design Decisions

- **Sine Wave Animation**: The journey map uses a sine wave to simulate the curve, with randomized amplitudes for peaks and valleys. This creates a dynamic and engaging visual.
- **Wave Coloring**: The wave is cut into sections and colored green to represent the user's progress. However, a smooth transition between these sections hasn't been implemented yet.

