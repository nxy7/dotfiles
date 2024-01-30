/**
 * A Theme is a set of options that will be applied
 * ontop of the default values. see options.js for possible options
 */
import { Theme, WP } from './settings/theme.js';

export default [
    Theme({
        name: 'Nox',
        icon: '🌙',
        // 'desktop.wallpaper.img': WP + 'ivory.png',
        'desktop.wallpaper.fg': '$bg_color',
        'desktop.screen_corners': false,
        'bar.style': 'separated',
        'theme.widget.bg': '$accent',
        'theme.widget.opacity': 64,
        'desktop.drop_shadow': false,
        'border.width': 0,
        'border.opacity': 0,
        'theme.accent.gradient': 'to right, $accent, darken($accent, 6%)',
        'hypr.inactive_border': 'rgba(111111FF)',
        'bar.separators': false,
    }),
];
