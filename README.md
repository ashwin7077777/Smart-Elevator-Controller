# Smart Elevator Controller

## Overview

The Smart Elevator Controller is a Verilog HDL-based RTL design that simulates the operation of a four-floor elevator system. The controller accepts floor requests, determines the direction of movement, tracks the current floor, and controls door operations using a Finite State Machine (FSM).

This project demonstrates fundamental RTL design concepts such as FSM implementation, sequential logic, combinational logic, register-based storage, and functional verification using a Verilog testbench.

---

## Key Features

* Supports four floors (0–3)
* FSM-based control architecture
* Automatic upward and downward movement
* Floor request handling
* Door open and close control
* Current floor tracking
* Verilog testbench for functional verification
* Waveform generation for debugging and analysis

---

## Design Approach

The controller operates using a Finite State Machine with the following states:

### IDLE

Waits for a floor request.

### MOVE_UP

Moves the elevator upward toward the requested floor.

### MOVE_DOWN

Moves the elevator downward toward the requested floor.

### OPEN_DOOR

Opens the elevator door when the destination floor is reached.

### CLOSE_DOOR

Closes the door and returns the controller to the idle state.

---

## RTL Concepts Implemented

### Finite State Machine (FSM)

Used to control elevator movement and door operations.

### Sequential Logic

Used for:

* State storage
* Current floor tracking
* Request registration

### Combinational Logic

Used for:

* Next-state generation
* Target floor selection
* Direction control

### Flip-Flops

D Flip-Flops are inferred through clocked always blocks for storing state and floor information.

---

## Verification

A Verilog testbench was developed to validate the functionality of the controller.

### Test Scenarios

* Request Floor 3 from Floor 0
* Request Floor 1 from Floor 3
* Request Floor 0 from Floor 1

### Verification Checks

* Correct floor tracking
* Proper state transitions
* Accurate movement direction
* Door operation at destination floor
* Successful return to idle state

---

## Simulation Results

The design was simulated using a Verilog simulator and verified through waveform analysis.

Simulation outputs include:

* Floor transitions
* Elevator movement status
* Door status
* FSM behavior

Waveforms were generated using a VCD file and analyzed using GTKWave.

---

## Learning Outcomes

Through this project, the following concepts were practiced:

* RTL Design using Verilog HDL
* FSM Design Methodology
* Sequential and Combinational Logic
* Register and Flip-Flop Modeling
* Functional Verification
* Waveform Debugging and Analysis

---

## Future Improvements

* Request queue implementation
* Elevator scheduling algorithm
* Multiple elevator support
* Emergency stop feature
* Floor display controller
* SystemVerilog Assertions (SVA)
* UVM-based verification environment

---

## Author

**Ashwin Karthikeyan**

RTL Design | SystemVerilog | Verification | UVM Enthusiast
