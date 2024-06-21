/* eslint-disable no-unused-vars */
import matugen from "./matugen";
import hyprland from "./hyprland";
import gtk from "./gtk";
import lowBattery from "./battery";
import notifications from "./notifications";

export default function init() {
  try {
    gtk();
    matugen();
    // lowBattery();
    notifications();
    hyprland();

    autostart();
  } catch (error) {
    logError(error);
  }
}

function autostart() {
  // wallpaper.connect("changed", () => matugen())
  // options.autotheme.connect("changed", () => matugen())
  // exec-once = keepassxc
  //     exec-once = discord
  //     exec-once = slack
}
