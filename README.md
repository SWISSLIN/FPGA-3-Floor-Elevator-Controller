# FPGA-Based 3-Floor Elevator Controller

A 3-floor elevator controller designed using **Verilog HDL** and implemented on the **Digilent Nexys A7 FPGA** using **Xilinx Vivado 2024.2**.

## 📌 Project Overview

This project implements a digital elevator control system for a three-floor building.

The elevator controller receives floor-selection inputs from FPGA push buttons and controls the elevator movement between Floor 1, Floor 2, and Floor 3.

The design uses a **Finite State Machine (FSM)** to control the elevator operation.

The current floor is indicated using LEDs and a 7-segment display. Additional LEDs indicate whether the elevator is moving upward, moving downward, or the door is open.

---

## 🎯 Objectives

- Design a simple elevator controller using Verilog HDL.
- Implement elevator control using an FSM.
- Control a 3-floor elevator using FPGA push buttons.
- Display the current floor using a 7-segment display.
- Indicate elevator movement using LEDs.
- Verify the design using Vivado behavioral simulation.
- Synthesize and implement the design on a Nexys A7 FPGA.
- Generate a programming bitstream for the FPGA.

---

## ✨ Features

- 3-floor elevator control
- Floor 1, Floor 2, and Floor 3 selection
- UP movement indication
- DOWN movement indication
- Door-open indication
- Current-floor LED indication
- 7-segment floor display
- Reset functionality
- Clock divider
- FSM-based control
- Verilog RTL implementation
- Vivado behavioral simulation
- FPGA synthesis
- FPGA implementation
- Timing analysis
- Bitstream generation

---

## 🛠️ Hardware Used

- Digilent Nexys A7 FPGA
- On-board push buttons
- On-board LEDs
- On-board 7-segment display

### FPGA Device

```text
Device: xc7a100tcsg324-1
FPGA Family: Artix-7
