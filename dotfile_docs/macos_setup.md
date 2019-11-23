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
- Privacy
  - Consider adding sources root for personal projects to avoid unnecessary indexing, especially
    since it will include all node_modules, etc. which takes a long time to index each update


