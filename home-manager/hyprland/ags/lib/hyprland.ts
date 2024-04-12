import options from "options";
const { messageAsync } = await Service.import("hyprland");

const {
  hyprland,
  theme: {
    spacing,
    radius,
    border: { width },
    blur,
    shadows,
    dark: {
      primary: { bg: darkActive },
    },
    light: {
      primary: { bg: lightActive },
    },
    scheme,
  },
} = options;

const deps = [
  "hyprland",
  spacing.id,
  radius.id,
  blur.id,
  width.id,
  shadows.id,
  darkActive.id,
  lightActive.id,
  scheme.id,
];

function activeBorder() {
  const color = scheme.value === "dark" ? darkActive.value : lightActive.value;

  return color.replace("#", "");
}

function sendBatch(batch: string[]) {
  const cmd = batch
    .filter((x) => !!x)
    .map((x) => `keyword ${x}`)
    .join("; ");

  return messageAsync(`[[BATCH]]/${cmd}`);
}

async function setupHyprland() {
  const wm_gaps = Math.floor(hyprland.gaps.value * spacing.value);

  const shadowSettings = shadows.value
    ? [
        `decoration:drop_shadow yes`,
        `decoration:col.shadow_inactive = rgba(1E2029ee)`,
        `decoration:col.shadow = rgba(111111ee)`,
        `decoration:shadow_range = 27`,
        `decoration:shadow_offset = 10 10`,
        `decoration:shadow_render_power = 2`,
        `decoration:shadow_scale = 0.97`,
      ]
    : [`decoration:drop_shadow no`];

  sendBatch([
    `general:border_size ${width}`,
    `general:gaps_out ${wm_gaps}`,
    `general:gaps_in ${Math.floor(wm_gaps / 2)}`,
    `decoration:rounding ${radius}`,

    `dwindle:no_gaps_when_only ${hyprland.gapsWhenOnly.value ? 0 : 1}`,
    `master:no_gaps_when_only ${hyprland.gapsWhenOnly.value ? 0 : 1}`,
    ...shadowSettings,
  ]);

  await sendBatch(App.windows.map(({ name }) => `layerrule unset, ${name}`));

  if (blur.value > 0) {
    sendBatch(
      App.windows.flatMap(({ name }) => [
        `layerrule unset, ${name}`,
        `layerrule blur, ${name}`,
        `layerrule ignorealpha ${/* based on shadow color */ 0.29}, ${name}`,
      ]),
    );
  }
}

export default function init() {
  options.handler(deps, setupHyprland);
  setupHyprland();
}
