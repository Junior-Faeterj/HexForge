# HEXFORGE - Script to Asset Mapping

This document lists all the scripts and the corresponding nodes or resources they should be attached to.

## 1. Autoloads (Singletons)
Add these in **Project Settings > Autoload**.

| Name | Script Path |
| :--- | :--- |
| **GameManager** | `res://scripts/autoload/GameManager.gd` |
| **SaveManager** | `res://scripts/autoload/SaveManager.gd` |
| **SceneManager** | `res://scripts/autoload/SceneManager.gd` |
| **AudioManager** | `res://scripts/autoload/AudioManager.gd` |
| **InputManager** | `res://scripts/autoload/InputManager.gd` |

---

## 2. Character: Player
| Scene | Node Name | Script |
| :--- | :--- | :--- |
| `Player.tscn` | **Player** (CharacterBody2D) | `res://scripts/player/Player.gd` |
| | `Components/Input` | `res://scripts/player/PlayerInput.gd` |
| | `Components/Movement` | `res://scripts/player/PlayerMovement.gd` |
| | `Components/Animation` | `res://scripts/player/PlayerAnimation.gd` |
| | `Components/Health` | `res://scripts/core/HealthComponent.gd` |
| | `Components/Mana` | `res://scripts/player/PlayerMana.gd` |
| | `Components/Level` | `res://scripts/player/PlayerLevel.gd` |
| | `Components/Spells` | `res://scripts/magic/SpellManager.gd` |
| | `Components/Inventory` | `res://scripts/inventory/InventoryManager.gd` |
| | `Hurtbox` | `res://scripts/combat/Hurtbox.gd` |
| | `InteractionRay` | (RayCast2D - no script) |
| | `FSM` | `res://scripts/player/PlayerFSM.gd` |
| | `FSM/Idle` | `res://scripts/player/states/IdleState.gd` |
| | `FSM/Move` | `res://scripts/player/states/MoveState.gd` |
| | `FSM/Death` | `res://scripts/player/states/DeathState.gd` |

---

## 3. Magic Spells
| Scene | Node Name | Script |
| :--- | :--- | :--- |
| `Fireball.tscn` | **Fireball** | `res://scripts/magic/Fireball.gd` |
| `ArcaneRay.tscn` | **ArcaneRay** | `res://scripts/magic/ArcaneRay.gd` |
| `MysticExplosion.tscn` | **MysticExplosion** | `res://scripts/magic/MysticExplosion.gd` |
| `ArcaneShield.tscn` | **ArcaneShield** | `res://scripts/magic/ArcaneShield.gd` |
| *(All Spell Scenes)* | `Hitbox` | `res://scripts/combat/Hitbox.gd` |

---

## 4. Enemies & AI
| Scene | Node Name | Script |
| :--- | :--- | :--- |
| `EnemyBase.tscn` | **EnemyBase** | `res://scripts/enemy/EnemyBase.gd` |
| `Boss.tscn` | **Boss** | `res://scripts/enemy/Boss.gd` |
| | `Components/Health` | `res://scripts/core/HealthComponent.gd` |
| | `DetectionArea` | `res://scripts/enemy/DetectionComponent.gd` |
| | `Hurtbox` | `res://scripts/combat/Hurtbox.gd` |
| | `FSM` | `res://scripts/enemy/EnemyFSM.gd` |
| | `FSM/Idle` | `res://scripts/enemy/states/IdleState.gd` |
| | `FSM/Patrol` | `res://scripts/enemy/states/PatrolState.gd` |
| | `FSM/Death` | `res://scripts/enemy/states/DeathState.gd` |
| `Boss.tscn` | `FSM/Phase1` | `res://scripts/enemy/boss_states/BossPhase1State.gd` |
| | `FSM/Phase2` | `res://scripts/enemy/boss_states/BossPhase2State.gd` |
| | `FSM/Teleport` | `res://scripts/enemy/boss_states/BossTeleportState.gd` |

---

## 5. UI & Menus
| Scene | Node Name | Script |
| :--- | :--- | :--- |
| `HUD.tscn` | **HUD** | `res://scripts/ui/HUD.gd` |
| `PauseMenu.tscn` | **PauseMenu** | `res://scripts/ui/PauseMenu.gd` |
| `InventoryUI.tscn` | **InventoryUI** | `res://scripts/ui/InventoryUI.gd` |
| `InventorySlot.tscn` | **InventorySlot** | `res://scripts/ui/InventorySlot.gd` |
| `MainMenu.tscn" | **MainMenu** | `res://scripts/menus/MainMenu.gd` |
| `SettingsMenu.tscn` | **SettingsMenu** | `res://scripts/menus/SettingsMenu.gd` |
| `LoadingScreen.tscn` | **LoadingScreen** | `res://scripts/menus/LoadingScreen.gd` |
| `DamageText.tscn` | **DamageText** | `res://scripts/ui/DamageText.gd` |

---

## 6. World Objects
| Scene | Node Name | Script |
| :--- | :--- | :--- |
| `Checkpoint.tscn` | **Checkpoint** | `res://scripts/world/Checkpoint.gd` |
| `Portal.tscn" | **Portal** | `res://scripts/world/Portal.gd` |
| `NPC.tscn" | **NPC** | `res://scripts/world/NPC.gd" |

---

## 7. Resources (.tres)
Scripts used to define data structures.

| Script Path | Usage |
| :--- | :--- |
| `res://scripts/player/PlayerStats.gd` | For `PlayerStats.tres` |
| `res://resources/magic/MagicResource.gd` | For individual spells. |
| `res://scripts/enemy/EnemyStats.gd` | For individual enemies. |
| `res://scripts/enemy/BossStats.gd` | For the Boss data. |
| `res://resources/items/ItemResource.gd` | Base for items. |
