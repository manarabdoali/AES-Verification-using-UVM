
# AES Verification using UVM

**GitHub Repository:**  
[manarabdoali/AES-Verification-using-UVM](https://github.com/manarabdoali/AES-Verification-using-UVM)

![SystemVerilog](https://img.shields.io/badge/SystemVerilog-Verification-blue)
![UVM](https://img.shields.io/badge/UVM-1.1d-green)
![AES](https://img.shields.io/badge/AES-Cryptography-yellow)
![License](https://img.shields.io/badge/License-Educational-lightgrey)

## Table of Contents
- [Project Overview](#project-overview)
- [Project Structure](#project-structure)
- [Verification Architecture](#verification-architecture)
- [Components](#components)
- [Design Under Test (DUT)](#design-under-test-dut)
- [Verification Plan](#verification-plan)
- [Test Cases](#test-cases)
- [Coverage](#coverage)
- [Getting Started](#getting-started)
- [Running Simulations](#running-simulations)
- [Results](#results)
- [Key Features](#key-features)
- [Learning Objectives](#learning-objectives)
- [Contributing](#contributing)
- [Contact](#contact)

## Project Overview

This repository presents a **complete UVM-based verification environment** for validating an **AES (Advanced Encryption Standard) encryption and decryption RTL design**.

The environment uses **directed and constrained-random testing**, integrates a **Python golden reference model**, and applies **functional coverage** to ensure correctness and robustness.

### Key Highlights

- ✅ Full **UVM verification environment**
- ✅ **Python golden model** for result comparison
- ✅ Directed + constrained-random tests
- ✅ Self-checking scoreboard
- ✅ Functional coverage collection
- ✅ Industry-standard verification methodology

## Project Structure

```
AES-Verification-using-UVM/
├── rtl/
│   ├── aes_core.v
│   └── aes_cipher.v
│
├── verification/
│   ├── aes_interface.sv
│   ├── aes_seq_item.sv
│   ├── aes_sequence.sv
│   ├── aes_sequencer.sv
│   ├── aes_driver.sv
│   ├── aes_monitor.sv
│   ├── aes_agent.sv
│   ├── aes_scoreboard.sv
│   ├── aes_coverage.sv
│   ├── aes_env.sv
│   ├── aes_test.sv
│   └── top.sv
│
├── python_ref/
│   ├── aes_golden_model.py
│   └── test_vectors.py
│
└── README.md
```

## Verification Architecture

```
┌───────────────────────────────┐
│          UVM Test             │
└──────────────┬────────────────┘
               │
               ▼
┌───────────────────────────────┐
│        UVM Environment         │
│                               │
│  ┌──────────┐   ┌──────────┐  │
│  │Sequencer │→  │ Driver   │→ DUT
│  └──────────┘   └──────────┘  │
│         ▲              │      │
│         │              ▼      │
│    ┌──────────┐   ┌────────┐  │
│    │ Sequence │   │Monitor │  │
│    └──────────┘   └───┬────┘  │
│                        │      │
│             ┌──────────▼───┐  │
│             │ Scoreboard   │  │
│             │ Coverage     │  │
│             └──────────────┘  │
└───────────────────────────────┘
```

## Components

### Interface
Defines clock, reset, control, data, and key signals between the testbench and DUT.

### Sequence Item
Represents an AES transaction containing:
- Plaintext / Ciphertext
- Key
- Operation mode (Encrypt / Decrypt)

### Sequencer
Controls and schedules AES transactions.

### Driver
Drives transactions to the DUT at pin level.

### Monitor
Samples DUT inputs/outputs and forwards transactions.

### Scoreboard
Compares DUT output against the **Python golden model**.

### Coverage
Tracks:
- Operation mode coverage
- Key patterns
- Data patterns

### Environment
Instantiates and connects all UVM components.

## Design Under Test (DUT)

### AES Specifications
- AES-128 Encryption
- AES-128 Decryption

### DUT Interface

| Signal   | Direction | Width | Description |
|--------|-----------|-------|-------------|
| clk    | Input     | 1     | Clock |
| rst    | Input     | 1     | Reset |
| start  | Input     | 1     | Start operation |
| key    | Input     | 128   | AES key |
| data_in | Input    | 128   | Plaintext / Ciphertext |
| mode   | Input     | 1     | 0=Encrypt, 1=Decrypt |
| data_out | Output  | 128   | Output data |
| ready  | Output    | 1     | Operation complete |

## Verification Plan

### Objectives
1. Verify encryption correctness
2. Verify decryption correctness
3. Compare DUT output with golden model
4. Achieve high functional coverage

### Strategy
- Directed test vectors
- Constrained-random testing
- Coverage-driven verification
- Self-checking scoreboard

## Test Cases

- Basic encryption test
- Basic decryption test
- Random encryption tests
- Random decryption tests
- Corner-case vectors

## Coverage

### Functional Coverage
- Encrypt vs Decrypt
- Key value distribution
- Data value distribution
- Operation completion

### Code Coverage
- Line coverage
- Branch coverage
- Toggle coverage

## Getting Started

### Prerequisites
- Questa / VCS / Riviera-PRO
- UVM 1.1d or later
- Python 3
- PyCryptodome

### Installation

```bash
git clone https://github.com/manarabdoali/AES-Verification-using-UVM.git
cd AES-Verification-using-UVM
pip install pycryptodome
```

## Running Simulations

### Compile

```bash
vlog +incdir+./rtl +incdir+./verification      ./rtl/*.v ./verification/*.sv
```

### Run Test

```bash
vsim -c top +UVM_TESTNAME=aes_test -do "run -all; exit"
```

### With Coverage

```bash
vsim -coverage top +UVM_TESTNAME=aes_test -do "run -all; exit"
```

## Results

```
AES Encryption Test: PASSED
AES Decryption Test: PASSED
Random Tests: PASSED
Functional Coverage: >98%
```

## Key Features

- Industry-standard UVM environment
- Python golden reference model
- Self-checking verification
- Coverage-driven approach
- Highly modular and reusable

## Learning Objectives

- UVM component hierarchy
- Sequence–driver interaction
- Scoreboard and reference models
- Functional coverage
- Verification best practices

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Open a pull request

## Contact

**Author:** Manar Abdoali  
**GitHub:** https://github.com/manarabdoali  

⭐ If you find this project useful, consider giving it a **star** ⭐
