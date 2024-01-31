/**
 * An object holding Options that are Variables with cached values.
 *
 * to update an option at runtime simply run
 * ags -r "options.path.to.option.setValue('value')"
 *
 * resetting:
 * ags -r "options.reset()"
 */

import { Option, resetOptions, getValues, apply, getOptions } from './settings/option.js';
import { USER } from 'resource:///com/github/Aylur/ags/utils.js';
import themes from './themes.js';
import Utils from 'resource:///com/github/Aylur/ags/utils.js';

const path = `/home/${Utils.USER}/.local/share/ags/colors.json`;
const colors = JSON.parse(Utils.readFile(path));

export default {
  reset: resetOptions,
  values: getValues,
  apply: apply,
  list: getOptions,

  spacing: Option(7),
  padding: Option(10),
  radii: Option(7),

  popover_padding_multiplier: Option(1.4, {
    'category': 'General',
    'note': 'popover-padding: padding × this',
    'type': 'float',
    'unit': '',
  }),

  color: {
    primary: Option(`#${colors.base06}`, { 'scss': 'primary' }),
    light: Option(`#${colors.base06}`, { 'scss': 'light' }),
    secondary: Option(`#${colors.base06}`, { 'scss': 'secondary' }),
    accent: Option(`#${colors.base06}`, { 'scss': 'accent' }),
    background: Option(`#${colors.base00}`, { 'scss': 'bg-color' }),
    foreground: Option(`#${colors.base05}`, { 'scss': 'fg-color' }),
    red: Option(`#${colors.red}`, { 'scss': 'red' }),
    green: Option(`#${colors.green}`, { 'scss': 'green' }),
    yellow: Option(`#${colors.yellow}`, { 'scss': 'yellow' }),
    blue: Option(`#${colors.blue}`, { 'scss': 'blue' }),
    magenta: Option(`#${colors.magenta}`, { 'scss': 'magenta' }),
    teal: Option(`#${colors.teal}`, { 'scss': 'teal' }),
    orange: Option(`#${colors.orange}`, { 'scss': 'orange' }),
  },

  theme: {
    name: Option(themes[0].name, {
      'category': 'exclude',
      'note': 'Name to show as active in quicktoggles',
    }),

    icon: Option(themes[0].icon, {
      'category': 'exclude',
      'note': 'Icon to show as active in quicktoggles',
    }),

    scheme: Option('dark', {
      'enums': ['dark', 'light'],
      'type': 'enum',
      'note': "Color scheme to set on Gtk apps: 'ligth' or 'dark'",
      'title': 'Color Scheme',
      'scss': 'color-scheme',
    }),
    accent: {
      accent: Option('$accent', {
        'category': 'Theme',
        'title': 'Accent Color',
        'scss': 'accent',
      }),
      fg: Option('#141414', {
        'category': 'Theme',
        'title': 'Accent Foreground Color',
        'scss': 'accent-fg',
      }),
      gradient: Option('to right, $accent, lighten($accent, 6%)', {
        'category': 'Theme',
        'title': 'Accent Linear Gradient',
        'scss': 'accent-gradient',
      }),
    },

    widget: {
      opacity: Option(94, {
        'category': 'Theme',
        'title': 'Widget Background Opacity',
        'unit': '',
        'scss': 'widget-opacity',
      }),
    },
  },

  border: {
    opacity: Option(97, {
      'category': 'Border',
      'title': 'Border Opacity',
      'unit': '',
    }),
    width: Option(0, {
      'category': 'Border',
      'title': 'Border Width',
    }),
  },

  hypr: {
    inactive_border: Option('rgba(333333ff)', {
      'category': 'Border',
      'title': 'Border on Inactive Windows',
      'scss': 'exclude',
    }),
    wm_gaps_multiplier: Option(2.4, {
      'category': 'General',
      'scss': 'wm-gaps-multiplier',
      'note': 'wm-gaps: padding × this',
      'type': 'float',
      'unit': '',
    }),
  },

  // TODO: use this on revealers
  transition: Option(200, {
    'category': 'exclude',
    'note': 'Transition time on aminations in ms, e.g on hover',
    'unit': 'ms',
  }),

  font: {
    font: Option('Ubuntu Nerd Font', {
      'type': 'font',
      'title': 'Font',
      'scss': 'font',
    }),
    mono: Option('Ubuntu Nerd Font', {
      'title': 'Monospaced Font',
      'scss': 'mono-font',
    }),
    size: Option(13, {
      'scss': 'font-size',
      'unit': 'pt',
    }),
  },

  applauncher: {
    width: Option(500),
    height: Option(500),
    anchor: Option(['top']),
    icon_size: Option(52),
  },

  bar: {
    position: Option('bottom', {
      'enums': ['top', 'bottom'],
      'type': 'enum',
    }),
    style: Option('floating', {
      'enums': ['floating', 'normal', 'separated'],
      'type': 'enum',
    }),
    flat_buttons: Option(true, { 'scss': 'bar-flat-buttons' }),
    separators: Option(true),
    icon: Option('distro-icon', {
      'note': '"distro-icon" or a single font',
    }),
  },

  battery: {
    show_percentage: Option(true, {
      'persist': true,
      'noReload': false,
      'category': 'exclude',
    }),
    bar: {
      show_icon: Option(true, { 'category': 'Bar' }),
      width: Option(70, { 'category': 'Bar' }),
      height: Option(14, { 'category': 'Bar' }),
      full: Option(false, { 'category': 'Bar' }),
    },
    low: Option(30, { 'category': 'Bar' }),
    medium: Option(50, { 'category': 'Bar' }),
  },

  desktop: {
    wallpaper: {
      fg: Option('$primary', { 'scss': 'wallpaper-fg' }),
      img: Option("~/.local/share/wallpapers/1.jpg", {
        'scssFormat': v => `"${v}"`,
        'type': 'img',
      }),
    },
    avatar: Option(`/var/lib/AccountsService/icons/${USER}`, {
      'scssFormat': v => `"${v}"`,
      'type': 'img',
      'note': 'displayed in quicksettings and locksreen',
    }),
    screen_corners: Option(true, { 'scss': 'screen-corners' }),
    clock: {
      enable: Option(true),
      position: Option('center center', {
        'note': 'halign valign',
      }),
    },
    drop_shadow: Option(true, { 'scss': 'drop-shadow' }),
    shadow: Option('rgba(0, 0, 0, .6)', { 'scss': 'shadow' }),
    dock: {
      icon_size: Option(56),
      pinned_apps: Option([
        'firefox',
        'org.wezfurlong.wezterm',
        'org.gnome.Nautilus',
        'org.gnome.Calendar',
        'obsidian',
        'transmission-gtk',
        'caprine',
        'teams-for-linux',
        'discord',
        'spotify',
        'com.usebottles.bottles',
        'org.gnome.Software',
      ], { 'scss': 'exclude' }),
    },
  },

  notifications: {
    black_list: Option(['Spotify'], { 'note': 'app-name | entry' }),
    position: Option(['top', 'right'], { 'note': 'anchor' }),
    width: Option(450),
  },

  dashboard: {
    sys_info_size: Option(70, {
      'category': 'Desktop',
      'scss': 'sys-info-size',
    }),
  },

  mpris: {
    black_list: Option(['Caprine'], {
      'category': 'Bar',
      'title': 'List of blacklisted mpris players',
      'note': 'filters for bus-name, name, identity, entry',
    }),
    preferred: Option('spotify', {
      'category': 'Bar',
      'title': 'Preferred player',
    }),
  },

  workspaces: Option(9, {
    'category': 'Bar',
    'title': 'No. workspaces on bar and overview',
    'note': 'Set it to 0 to make it dynamic',
  }),

  temperature: '/sys/class/thermal/thermal_zone0/temp',
  systemFetchInterval: 5000,
  brightnessctlKBD: 'asus::kbd_backlight',
  substitutions: {
    icons: [
      ['transmission-gtk', 'transmission'],
      ['blueberry.py', 'bluetooth'],
      ['Caprine', 'facebook-messenger'],
      ['', 'preferences-desktop-display'],
    ],
    titles: [
      ['com.github.Aylur.ags', 'AGS'],
      ['transmission-gtk', 'Transmission'],
      ['com.obsproject.Studio', 'OBS'],
      ['com.usebottles.bottles', 'Bottles'],
      ['com.github.wwmm.easyeffects', 'Easy Effects'],
      ['org.gnome.TextEditor', 'Text Editor'],
      ['org.gnome.design.IconLibrary', 'Icon Library'],
      ['blueberry.py', 'Blueberry'],
      ['org.wezfurlong.wezterm', 'Wezterm'],
      ['com.raggesilver.BlackBox', 'BlackBox'],
      ['firefox', 'Firefox'],
      ['org.gnome.Nautilus', 'Files'],
      ['libreoffice-writer', 'Writer'],
      ['', 'Desktop'],
    ],
  },
};
