# HEXFORGE

**HEXFORGE** is a professional Hack and Slash game developed with Godot Engine 4.x where the protagonist is a mage. Instead of traditional physical weapons, all combat is based on magic, featuring fast, fluid, and fun gameplay.

This project is designed as a Final Paper (TCC), prioritizing clean, modular, reusable code and following SOLID, DRY, KISS, and Clean Code principles.

## Project Vision
- **Genre:** Hack and Slash
- **Engine:** Godot Engine 4.x
- **Language:** GDScript
- **Style:** Pixel Art
- **Platform:** Windows
- **Mode:** Single Player

## Key Features
- **Magic-based Combat:** 8-way movement with unique magical abilities (Fireball, Arcane Ray, Mystic Blast, Arcane Shield).
- **Advanced AI:** Enemies using Finite State Machines (FSM) for complex behaviors.
- **Boss Fights:** Multi-phase encounters with unique patterns.
- **Progression System:** XP, Leveling, and Inventory management.
- **Robust Architecture:** Modular design using professional design patterns (State, Observer, Factory, etc.).

## Directory Structure
The project is organized into a modular structure:
- `assets/`: Graphic and audio resources.
- `scenes/`: Godot scenes (.tscn) organized by category.
- `scripts/`: GDScript files, separated by responsibility.
- `resources/`: Data containers (Stats, Magic definitions, Item data).
- `docs/`: Technical documentation and architecture details.

## Technical Documentation
For detailed architectural information, please refer to [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).
