# Performing basic macOS setup on a new machine

## Initial software update

Create one default account that you don't plan to use normally. Having this allows at least one
working login if you screw something up later.

Log in on the default account and run software update.

Create a new admin account that will be your daily driver

## Configure system preferences as desired

#### General
- Default web browser: Brave

#### Desktop & Screen Saver
- Placeholder

#### Dock
- Placeholder

#### Mission Control
- Placeholder

#### Security & Privacy
- General
  - Require password after 5 minutes after sleep
  - Disable automatic login
  - Allow apps downloaded from "App Store and identified developers"
- FileVault
  - Normally turned off
- Firewall
  - Turn On Firewall
- Privacy
  - Location Services
    - Turn off most things unless really needed
    - System Services has some convenience functions that maybe should be on
  - Contacts
    - Probably nothing enabled here
  - Calenders
  - Reminders
  - Photos
    - None of these turned on
  - Accessibility
    - On for Alfred, SizeUp
    - Possibly on for Logi Options for logitech mouse/keyboard if needed
  - Analytics
    - All turned off

#### Spotlight
- Search Results
  - Turn off most things other than files
  - Not needed if Alfred is used
  - Turn off "Allow Spotlight Succestions in Look up"
- Privacy
  - Consider adding sources root for personal projects to avoid unnecessary indexing, especially
    since it will include all node_modules, etc. which takes a long time to index each update

#### Notifications
- Placeholder

#### Displays
- Placeholder

#### Energy Saver
- Placeholder

#### Keyboard
- Keyboard
  - Key Repeat -> Fast
  - Delay Until Repeat -> Short
  - Modifier Keys: change CapsLock to Ctrl unless using Karabiner [with these instructions](https://medium.com/@pechyonkin/how-to-map-capslock-to-control-and-escape-on-mac-60523a64022b)
  - Text
    - Turn off "Add period with double-space"
    - Turn off "Use smart quotes and dashes"
  - Shortcuts
    - Check later for conflicting shortcuts and turn them off on case-by-case basis
  - Input sources
    - Add Colemak keyboard for fun and practice typing on it using TypeFu from App Store
  - Dictation
    - No changes; leave everything turned off

#### Mouse
- Placeholder

#### Trackpad
- Placeholder

#### iCloud
- Turn everything off except possibly Keychain and Find My Mac

#### App Store
- Consider turning on fully automatic updates
- Consider less restrictive password requirements

#### Sharing
- Set Computer Name
- Turn the rest off

#### Users & Groups
- Add profile photo if desired
- Login Options
  - Automatic Login -> Off
  - Display login window as -> List of users
  - Show the Sleep, Restart, and Shut Down buttons -> On
  - All the others -> Off

#### Siri
- All off

#### Date & Time
- Clock
  - Show date and time in menu bar
  - Display the time with seconds -> On
  - Use a 24-hour clock -> On
  - Show the day of the week -> On
  - Show date -> On

#### Accessibility
- Mouse & Trackpad > Trackpad Options > Enable dragging

## Configure Finder
- Open Finder preferences (Cmd+Comma)
  - General
    - Uncheck all but External Disks
    - New Finder windows show -> home directory
  - Sidebar
    - Uncheck all but:
        - Applications
        - Desktop
        - Documents
        - Downloads
        - [home directory]
  - Advanced:
    - Keep folders on top when sorting by name -> On
    - When performing a search -> Search the Current Folder

