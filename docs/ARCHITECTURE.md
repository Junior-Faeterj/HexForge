# HEXFORGE - Technical Architecture

This document outlines the architectural decisions, design patterns, and structural organization of the HEXFORGE project.

## Architectural Principles

- **SOLID:** Every class has a single responsibility.
- **Composition over Inheritance:** Components are used to add functionality to entities (e.g., HealthComponent, HitboxComponent).
- **Signal-driven Communication:** Nodes communicate "up" via signals and "down" via method calls to reduce coupling.
- **Clean Code:** Meaningful variable names, small functions, and clear comments.

## Design Patterns

### 1. State Pattern (FSM)
Used for Player and Enemy AI. Each state is a separate object that handles logic for a specific condition (Idle, Moving, Attacking, etc.).
- **Implementation:** `scripts/core/StateMachine.gd` and `scripts/core/State.gd`.

### 2. Observer Pattern
Extensively used through Godot's **Signals**. Entities emit signals (e.g., `health_changed`, `died`) that the HUD or GameManager listen to.

### 3. Singleton (Autoloads)
For global management of cross-cutting concerns:
- `GameManager`: Game state, score, level progression.
- `SaveManager`: Serialization of game data.
- `AudioManager`: Global SFX and Music playback.
- `SceneManager`: Transitions between levels/menus.
- `InputManager`: Centralized input handling.

### 4. Factory Pattern
Used for spawning magic projectiles and enemies.
- **Implementation:** `MagicFactory` will handle the creation of different spell scenes based on their resource type.

### 5. Object Pool
Used for high-frequency objects like projectiles and particles to avoid performance hits from constant instantiation and garbage collection.

### 6. Command Pattern
Used for decoupling input from action. InputManager translates raw input into "Commands" that the Player controller executes.

### 7. Composition
Nodes are built using smaller, reusable "Component" nodes:
- `HitboxComponent`
- `HurtboxComponent`
- `StatsComponent`

## Folder Documentation

### /assets
- `sprites/`: Pixel art textures.
- `audio/`: SFX and Music.
- `shaders/`: Custom visual effects.

### /scripts
- `core/`: Base classes and core logic (State Machine, Base Components).
- `autoload/`: Global singletons.
- `player/`, `enemy/`, `magic/`: Domain-specific logic.

### /resources
- Used for **Data-Driven Design**. Magic stats, player level tables, and item data are stored as `.tres` files for easy balancing.

## Combat System
Combat is entirely magic-based. Each spell is a `MagicResource` containing:
- Mana cost
- Damage
- Cooldown
- Visual scene (projectile/area)
- Type (Fire, Arcane, etc.)
