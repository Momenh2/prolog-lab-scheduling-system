# Labs Scheduling System

A Prolog-based system for scheduling lab sessions and assigning teaching assistants (TAs) efficiently, while respecting constraints such as TA availability and maximum slots per day.

## Features

- **Automatic TA Assignment:** Assigns TAs to lab slots based on their availability.
- **Constraint Satisfaction:** Ensures no TA is assigned more slots than allowed per day.
- **Daily and Weekly Scheduling:** Supports scheduling for individual days and entire weeks.
- **Conflict Avoidance:** Prevents double-booking of TAs within the same day.

## How It Works

The system models TAs and their available slots, then recursively assigns them to lab sessions using Prolog's logic programming capabilities. It checks constraints at each step to ensure valid schedules.

### Key Predicates

- `ta_slot_assignment/3`: Updates TA availability after assignment.
- `slot_assignment/4`: Assigns TAs to a set of lab slots for a day.
- `max_slots_per_day/2`: Checks that no TA exceeds the daily slot limit.
- `day_schedule/4`: Schedules all labs for a single day.
- `week_schedule/4`: Schedules labs for an entire week, day by day.

## Usage

1. **Define TAs and Labs:**
   - Represent TAs as `ta(Name, AvailableSlots)`.
   - List labs as numbers of required slots per day.

2. **Query Examples:**

   ```prolog
   % Example TA list: [ta(alice, 3), ta(bob, 2), ta(carol, 2)]
   % Example daily lab requirements: [2, 1, 2] (3 labs needing 2, 1, and 2 TAs)
   % Maximum slots per TA per day: 2

   week_schedule([[2,1],[1,2]], [ta(alice,3), ta(bob,2), ta(carol,2)], 2, Schedule).
   ```

   This will attempt to schedule labs for two days, given the TA list and constraints.

3. **Run in SWI-Prolog:**

   ```sh
   swipl
   ?- [ 'Labs Scheduling System.pl' ].
   ?- % Your queries here
   ```

## Customization

- **Add More Constraints:** Extend predicates to handle additional rules (e.g., TA preferences, unavailable days).
- **Change Slot Limits:** Adjust the `DayMax` parameter in `week_schedule/4` to set daily limits.

## File Structure

- `Labs Scheduling System.pl` — Main Prolog source file containing all scheduling logic.

## Requirements

- [SWI-Prolog](https://www.swi-prolog.org/) or any compatible Prolog interpreter.

## License

MIT License (or specify your own). 