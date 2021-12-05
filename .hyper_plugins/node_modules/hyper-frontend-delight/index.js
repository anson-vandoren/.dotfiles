'use strict'
const foregroundColor = '#adadad'
const backgroundColor = '#1b1c1d'
const black = '#242526'
const brightBlack = '#5fac6d'
const red = '#f8511b'
const brightRed = '#f74319'
const green = '#565747'
const brightGreen = '#74ec4c'
const yellow = '#fa771d'
const brightYellow = '#fdc325'
const blue = '#2c70b7'
const brightBlue = '#3393ca'
const magenta = '#f02e4f'
const brightMagenta = '#e75e4f'
const cyan = '#3ca1a6'
const brightCyan = '#4fbce6'
const white = '#adadad'
const brightWhite = '#8c735b'
const borderColor = '#1b1c1d'
const cursorColor = '#cdcdcd'
const activeTab = backgroundColor
const inactiveTab = '#242527'
const dividerColor = '#242527'

exports.decorateConfig = config => {
  return Object.assign({}, config, {
    backgroundColor,
    foregroundColor,
    borderColor,
    cursorColor,
    colors: [
      // normal
      black,
      red,
      green,
      yellow,
      blue,
      magenta,
      cyan,
      white,

      // bright
      brightBlack,
      brightRed,
      brightGreen,
      brightYellow,
      brightBlue,
      brightMagenta,
      brightCyan,
      brightWhite
    ],
    css: `
      ${config.css || ''}
      .splitpane_divider {
        background-color: ${dividerColor} !important;
      }
      .tabs_list {
        background-color: ${inactiveTab} !important;
      }

      .tabs_list,
      .tab_tab {
        border-color: transparent !important;
      }
      .tab_tab {
        background-color: ${inactiveTab} !important;
      }
      .tab_tab:hover {
        background-color: ${activeTab} !important;
        border-bottom: 1px solid ${activeTab} !important;
        border-color: ${activeTab} !important;
      }
      .tab_tab.tab_active {
        background-color: ${activeTab} !important;
        border-color: ${borderColor} !important;
        border-bottom: 0 !important;
      }
      .tab_tab.tab_active:hover {
        background-color: ${activeTab};
      }
      .tab_active::before {
        border-bottom: 1px solid ${activeTab} !important;
        bottom: 0;
      }
    `
  })
}
