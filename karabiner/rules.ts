import fs from "fs";
import { KarabinerRules } from "./types";
import { createHyperSubLayers, app, open, window, shell } from "./utils";

const rules: KarabinerRules[] = [
  // Define the Hyper key itself
  {
    description: "Hyper Key (⌃⌥⇧⌘)",
    manipulators: [
      {
        description: "Right Command -> Hyper Key",
        from: {
          key_code: "right_command",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            set_variable: {
              name: "hyper",
              value: 1,
            },
          },
        ],
        to_after_key_up: [
          {
            set_variable: {
              name: "hyper",
              value: 0,
            },
          },
        ],
        to_if_alone: [
          {
            key_code: "escape",
          },
        ],
        type: "basic",
      },
      //      {
      //        type: "basic",
      //        description: "Disable CMD + Tab to force Hyper Key usage",
      //        from: {
      //          key_code: "tab",
      //          modifiers: {
      //            mandatory: ["left_command"],
      //          },
      //        },
      //        to: [
      //          {
      //            key_code: "tab",
      //          },
      //        ],
      //      },
    ],
  },
  ...createHyperSubLayers({
    // Vim nagivation
    m: {
      to: [{ key_code: "left_arrow" }],
    },
    n: {
      to: [{ key_code: "down_arrow" }],
    },
    e: {
      to: [{ key_code: "up_arrow" }],
    },
    i: {
      to: [{ key_code: "right_arrow" }],
    },
    o: {
      to: [{ key_code: "tab" }],
    },

    // Single keystroke
    t: app("Zen"),
    s: app("Ghostty"),

    spacebar: open(
      "raycast://extensions/stellate/mxstbr-commands/create-notion-todo"
    ),

    // b = "B"rowse
    b: {
      m: open("https://github.com/jakmaz"),
      t: open("https://x.com"),
      r: open("https://reddit.com"),
    },

    // A = App
    a: {
      t: app("Firefox"),
      n: app("Messenger"),
      e: app("WhatsApp"),
      i: app("Mail"),
      o: app("Vesktop"),
      h: app("Obsidian"),
      // ,: app("Preview"),
      // .: app("Finder"),
      // f: app("Finder"0
      // p: app("Spotify"),
      // // "W"hatsApp has been replaced by Texts
      // w: open("Texts"),
    },

    // TODO: This doesn't quite work yet.
    // l = "Layouts" via Raycast's custom window management
    // l: {
    //   // Coding layout
    //   c: shell`
    //     open -a "Visual Studio Code.app
    //     sleep 0.2
    //     open -g "raycast://customWindowManagementCommand?position=topLeft&relativeWidth=0.5"
    //     open -a "Terminal.app"
    //     sleep 0.2
    //     open -g "raycast://customWindowManagementCommand?position=topRight&relativeWidth=0.5"
    //   `,
    // },

    // w = "Window"
    w: {
      semicolon: {
        description: "Window: Hide",
        to: [
          {
            key_code: "h",
            modifiers: ["right_command"],
          },
        ],
      },
      y: window("previous-display"),
      o: window("next-display"),
      k: window("top-half"),
      j: window("bottom-half"),
      h: window("left-half"),
      l: window("right-half"),
      f: window("maximize"),
      u: {
        description: "Window: Previous Tab",
        to: [
          {
            key_code: "tab",
            modifiers: ["right_control", "right_shift"],
          },
        ],
      },
      i: {
        description: "Window: Next Tab",
        to: [
          {
            key_code: "tab",
            modifiers: ["right_control"],
          },
        ],
      },
      n: {
        description: "Window: Next Window",
        to: [
          {
            key_code: "grave_accent_and_tilde",
            modifiers: ["right_command"],
          },
        ],
      },
      b: {
        description: "Window: Back",
        to: [
          {
            key_code: "open_bracket",
            modifiers: ["right_command"],
          },
        ],
      },
      // Note: No literal connection. Both f and n are already taken.
      m: {
        description: "Window: Forward",
        to: [
          {
            key_code: "close_bracket",
            modifiers: ["right_command"],
          },
        ],
      },
    },

    // o = "System"
    f: {
      u: {
        to: [
          {
            key_code: "volume_increment",
          },
        ],
      },
      j: {
        to: [
          {
            key_code: "volume_decrement",
          },
        ],
      },
      i: {
        to: [
          {
            key_code: "display_brightness_increment",
          },
        ],
      },
      k: {
        to: [
          {
            key_code: "display_brightness_decrement",
          },
        ],
      },
      l: {
        to: [
          {
            key_code: "q",
            modifiers: ["right_control", "right_command"],
          },
        ],
      },
      p: {
        to: [
          {
            key_code: "play_or_pause",
          },
        ],
      },
      semicolon: {
        to: [
          {
            key_code: "fastforward",
          },
        ],
      },
      e: open(
        `raycast://extensions/thomas/elgato-key-light/toggle?launchType=background`
      ),
      // "D"o not disturb toggle
      d: open(
        `raycast://extensions/yakitrak/do-not-disturb/toggle?launchType=background`
      ),
      // "T"heme
      t: open(`raycast://extensions/raycast/system/toggle-system-appearance`),
      c: open("raycast://extensions/raycast/system/open-camera"),
      // 'v'oice
      v: {
        to: [
          {
            key_code: "spacebar",
            modifiers: ["left_option"],
          },
        ],
      },
    },

    // v = "moVe" which isn't "m" because we want it to be on the left hand
    v: {
      // Magicmove via homerow.app
      m: {
        to: [{ key_code: "f", modifiers: ["right_control"] }],
        // TODO: Trigger Vim Easymotion when VSCode is focused
      },
      // Scroll mode via homerow.app
      s: {
        to: [{ key_code: "j", modifiers: ["right_control"] }],
      },
      d: {
        to: [{ key_code: "d", modifiers: ["right_shift", "right_command"] }],
      },
      u: {
        to: [{ key_code: "page_down" }],
      },
      i: {
        to: [{ key_code: "page_up" }],
      },
    },

    // C = Capture
    c: {
      // Native capture tool
      m: {
        to: [
          {
            key_code: "m",
            modifiers: [
              "left_control",
              "left_shift",
              "left_command",
              "left_option",
            ],
          },
        ],
      },
      // Shottr active window
      n: {
        to: [
          {
            key_code: "n",
            modifiers: [
              "left_control",
              "left_shift",
              "left_command",
              "left_option",
            ],
          },
        ],
      },
      // Shottr selection
      e: {
        to: [
          {
            key_code: "e",
            modifiers: [
              "left_control",
              "left_shift",
              "left_command",
              "left_option",
            ],
          },
        ],
      },
      // Open Shottr (to edit)
      i: {
        to: [
          {
            key_code: "i",
            modifiers: [
              "left_control",
              "left_shift",
              "left_command",
              "left_option",
            ],
          },
        ],
      },
      // Shottr quick selection OCR
      o: {
        to: [
          {
            key_code: "o",
            modifiers: [
              "left_control",
              "left_shift",
              "left_command",
              "left_option",
            ],
          },
        ],
      },
    },

    // c = Capture
    // c: {
    // p: {
    //   to: [{ key_code: "play_or_pause" }],
    // },
    // n: {
    //   to: [{ key_code: "fastforward" }],
    // },
    // b: {
    //   to: [{ key_code: "rewind" }],
    // },
    // },

    // r = "Raycast"
    r: {
      n: open(
        "raycast://extensions/raycast/clipboard-history/clipboard-history"
      ),
      e: open("raycast://extensions/raycast/file-search/search-files"),
      // n: open("raycast://script-commands/dismiss-notifications"),
      i: open(
        "raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"
      ),
      c: open("raycast://extensions/raycast/raycast/confetti"),
      a: open("raycast://extensions/raycast/raycast-ai/ai-chat"),
      k: open(
        "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-1"
      ),
      h: open(
        "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-2"
      ),
    },
  }),
];

fs.writeFileSync(
  "karabiner.json",
  JSON.stringify(
    {
      global: {
        show_in_menu_bar: false,
      },
      profiles: [
        {
          name: "Default",
          complex_modifications: {
            rules,
          },
          virtual_hid_keyboard: { keyboard_type_v2: "iso" },
        },
      ],
    },
    null,
    1
  )
);
