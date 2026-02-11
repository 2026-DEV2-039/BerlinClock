# Berlin Clock Kata

This repository contains an implementation of the **Berlin Clock** kata.

The Berlin Clock is an alternative way to represent time using a series of illuminated lamps.  
Instead of displaying hours, minutes, and seconds as numbers, it visualizes time using colored lamps arranged in rows.

This project focuses on **clean logic, testability, and separation of concerns**, rather than UI complexity.

## 🕰️ Berlin Clock Overview

The Berlin Clock (German: Mengenlehreuhr) is a unique clock design that tells time using illuminated colored lamps instead of traditional hands or digital numbers.

It was designed by Dieter Binninger in 1975 and installed in Berlin.

🔗 More details:
https://en.wikipedia.org/wiki/Mengenlehreuhr

The Berlin Clock consists of **4 main rows of lamps**, along with a blinking seconds lamp:

### 1. Seconds Lamp
- A single lamp at the top
- Blinks **on/off every second**
- **On** for even seconds, **off** for odd seconds

### 2. Top Hours Row (5-hour blocks)
- 4 red lamps
- Each lamp represents **5 hours**
- Example: 13 hours → first 2 lamps ON

### 3. Bottom Hours Row (1-hour blocks)
- 4 red lamps
- Each lamp represents **1 hour**
- Example: 13 hours → 3 lamps ON

### 4. Top Minutes Row (5-minute blocks)
- 11 lamps
- Each lamp represents **5 minutes**
- Every 3rd lamp (15, 30, 45) is **red**, others are **yellow**

### 5. Bottom Minutes Row (1-minute blocks)
- 4 yellow lamps
- Each lamp represents **1 minute**

## 🎯 Objective of the Kata

The goal of this kata is to:

- Convert a standard time format (`HH:mm:ss`)
- Into a **Berlin Clock representation**
- With **correct lamp states and colors**
- Using **clean, testable logic**

This kata is commonly used to practice:
- Test-Driven Development (TDD)
- Incremental design
- Refactoring
- Domain modeling

## Example

Input:
13:17:01

Output (ASCII representation):

O
R R O O
R R R O
Y Y R O O O O O O O O
Y Y O O

Legend:
- R = Red
- Y = Yellow
- O = Off

## Tech Stack

- Swift 5
- SwiftUI
- Swift Testing framework
- iOS 17+
- Xcode 15.0+

## Getting Started

### Prerequisites

- macOS
- Xcode 16.4 or later
- iOS 18 SDK


### Clone the Repository

git clone https://github.com/2026-DEV2-039/BerlinClock.git
cd BerlinClock

### Open the Project

open BerlinClock.xcodeproj

Or open via Xcode → File → Open.

### Run the App

- Select an iOS simulator
- Press ⌘ + R

### Run Tests

- Press ⌘ + U
- Or Product → Test

The test suite validates domain logic independently of the UI layer.

## License
This project is licensed under the MIT License.
See the [LICENSE](https://github.com/2026-DEV2-039/BerlinClock/blob/main/LICENSE) file for details.
