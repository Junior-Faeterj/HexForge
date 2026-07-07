# HEXFORGE - Implementation Plan

This document outlines the step-by-step implementation strategy for HEXFORGE, ensuring a modular and stable development process.

## Phase 1: Foundation (Current)
- [x] Folder structure initialization.
- [x] Global Autoloads (Game, Save, Scene, Audio, Input).
- [x] Base architecture classes (FSM, Resources).
- [x] Technical documentation.

## Phase 2: Player System
- [ ] Base Player scene with Sprite2D and CollisionShape2D.
- [ ] Player State Machine (Idle, Move, Dash, Attack, Hurt, Death).
- [ ] Player Stats Component (Health, Mana, XP).
- [ ] 8-way movement implementation.

## Phase 3: Magic System
- [ ] `MagicManager` component for the Player.
- [ ] Prototyping "Fireball" (Projectile) and "Arcane Shield" (Aura).
- [ ] Mana consumption and cooldown logic.
- [ ] Visual effects (Particles) and SFX integration.

## Phase 4: Enemy AI & Combat
- [ ] Base Enemy class with FSM.
- [ ] Steering behaviors for obstacle avoidance.
- [ ] Combat components (Hitbox/Hurtbox).
- [ ] Basic enemy types (Melee and Ranged).

## Phase 5: World & Progression
- [ ] Level design with Tilemaps.
- [ ] Experience and Level-up system.
- [ ] Item drops and Inventory system.

## Phase 6: User Interface (HUD & Menus)
- [ ] HUD (Bars, Cooldowns, Level).
- [ ] Main Menu and Pause Menu.
- [ ] Save/Load UI.

## Phase 7: Boss & Polish
- [ ] Multi-phase Boss logic.
- [ ] Screen shake, hit-stop, and juice.
- [ ] Final audio balancing and bug fixes.
