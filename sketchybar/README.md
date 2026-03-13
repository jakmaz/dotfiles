# Sketchybar Configuration

Personal sketchybar setup with system monitoring, productivity tools, and media controls.

## Layout Overview

```
LEFT                     CENTER              RIGHT
[Apple] [Front App]      [Apple Music]       [Calendar] [Volume] [Battery] [CPU] [Memory] [Pomodoro] [Kanata]
```

## Bar Configuration

- **Position**: Top
- **Height**: 40px
- **Font**: Hack Nerd Font Bold 14.0
- **Colors**:
  - Bar background: Transparent
  - Item background: Semi-transparent dark gray
  - Item border: Subtle white border (1px)
  - Corner radius: 5px

## Items

### Left Side

#### Apple Logo
- **Icon**: Apple logo
- **Function**: Static decoration
- **Interactions**: None

#### Front App
- **Icon**: Dynamic app icon (from sketchybar-app-font)
- **Label**: Current application name
- **Updates**: On app switch (event-based)
- **Interactions**: None

### Center

#### Apple Music
- **Icon**: Music note (when playing)
- **Label**: "Track Name – Artist" (when playing), "[jakmaz]" (when stopped)
- **Update Frequency**: On music state change (event-based)
- **Interactions**:
  - **Left click**: Open Music app
  - **Right click**: Play/Pause toggle
  - **Hover**: Shows subtle background highlight
- **Special**: Transparent background, no border

### Right Side

#### Calendar
- **Icon**: Calendar icon
- **Label**: Date and time (e.g., "Fri 13 Mar 10:45")
- **Update Frequency**: 30 seconds
- **Interactions**: None

#### Volume
- **Icon**: Dynamic based on volume level and mute state
  - High volume (60-100%): Speaker with waves
  - Medium volume (30-59%): Speaker with fewer waves
  - Low volume (1-29%): Speaker with single wave
  - Muted/0%: Muted speaker
- **Label**: Volume percentage
- **Update Frequency**: On system volume change (event-based)
- **Interactions**:
  - **Right click**: Toggle mute/unmute
  - **Scroll up/down**: Increase/decrease volume by 10%

#### Battery
- **Icon**: Dynamic based on charge level and charging state
  - 90-100%: Full battery
  - 60-89%: High battery
  - 30-59%: Medium battery
  - 10-29%: Low battery
  - 0-9%: Critical battery
  - Charging: Charging icon (overrides battery level)
- **Label**: Battery percentage
- **Update Frequency**: 120 seconds, or on power source change/wake (event-based)
- **Interactions**: None

#### CPU
- **Icon**: CPU chip icon
- **Label**: CPU usage percentage
- **Update Frequency**: 2 seconds
- **Interactions**: None
- **Details**: Calculates combined system and user CPU usage across all cores

#### Memory
- **Icon**: Memory chip icon
- **Label**: RAM usage percentage
- **Update Frequency**: 10 seconds
- **Interactions**: None
- **Details**: Shows active + wired + compressed memory as percentage of total RAM

#### Pomodoro Timer
- **Icon**: 
  - Chair icon: Sitting session (20 minutes)
  - Up arrow: Standing session (10 minutes)
  - Pause icon: Timer paused
- **Label**: Time remaining (MM:SS format) or "PAUSED"
- **Update Frequency**: 1 second (when running)
- **Interactions**:
  - **Left click**: Start/Stop timer (starts fresh 20min sit session when stopped)
  - **Right click**: Skip to next session (sit/stand toggle)
- **Features**:
  - 20-10 rule: 20 minutes sitting, 10 minutes standing
  - Plays Glass.aiff sound when transitioning between sit/stand
  - State persists in /tmp/pomodoro_state

#### Kanata
- **Icon**: Keyboard icon
- **Color**: 
  - White: Kanata running
  - Gray: Kanata stopped
- **Label**: Hidden
- **Update Frequency**: 30 seconds, or on kanata_update event
- **Interactions**:
  - **Click**: Toggle Kanata on/off (via ~/.config/kanata/kanata-toggle.sh)
- **Note**: Enabling Kanata may require sudo password (disabling works without prompt)

Configuration is split between `items/` (item definitions - what to show, where, update frequency) and `plugins/` (item logic - how to fetch and display data).

## Update Frequencies

| Item | Update Frequency | Notes |
|------|-----------------|-------|
| Apple Logo | Static | No updates |
| Front App | Event-based | On app switch |
| Apple Music | Event-based | On music state change |
| Calendar | 30 seconds | - |
| Volume | Event-based | On volume change, scroll, or click |
| Battery | 120 seconds | Also on wake/power change |
| CPU | 2 seconds | - |
| Memory | 10 seconds | - |
| Pomodoro | 1 second | When timer is running |
| Kanata | 30 seconds | Also on toggle event |

## Dependencies

- **Hack Nerd Font**: Required for icons throughout the bar
- **sketchybar-app-font**: Required for dynamic app icons (Front App item)
- **jq**: Required for Pomodoro timer JSON state management
- **Kanata**: Optional, only needed if using Kanata keyboard remapping
