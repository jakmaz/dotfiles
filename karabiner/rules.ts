import fs from "fs";
import type { KarabinerRules } from "./types";
import {
	app,
	createHyperSubLayers,
	open,
	raycast,
	shell,
	window,
	workspace,
} from "./utils";

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
		t: workspace("zen"),
		s: workspace("ghostty"),

		spacebar: raycast("stellate/mxstbr-commands/create-notion-todo"),

		// b = "B"rowse
		b: {
			m: open("https://github.com/jakmaz"),
			n: raycast("Keyruu/zen-browser/new-tab"),
			o: open("https://jakmaz.com"),
			r: open("https://reddit.com"),
			y: open("https://www.youtube.com"),
			l: open("https://www.linkedin.com"),
		},

		// A = App
		a: {
			l: workspace("firefox"),
			u: workspace("yaak"),
			y: workspace("beekeeper"),
			semocolon: app(""),
			m: workspace("obsidian"),
			n: workspace("whatsapp"),
			e: workspace("messenger"),
			i: workspace("mail"),
			o: app("Vesktop"),
			h: workspace("calendar"),
			comma: app("Preview"),
			period: workspace("finder"),
		},

		// w = "Window"
		w: {
			y: window("previous-display"),
			k: window("top-half"),
			j: window("bottom-half"),
			h: window("left-half"),
			l: window("right-half"),
			f: window("maximize"),
			e: {
				description: "Window: Previous Tab",
				to: [
					{
						key_code: "tab",
						modifiers: ["right_control", "right_shift"],
					},
				],
			},
			n: {
				description: "Window: Next Tab",
				to: [
					{
						key_code: "tab",
						modifiers: ["right_control"],
					},
				],
			},
			o: {
				description: "Window: Next Window",
				to: [
					{
						key_code: "grave_accent_and_tilde",
						modifiers: ["right_command"],
					},
				],
			},
			m: {
				description: "Window: Back",
				to: [
					{
						key_code: "open_bracket",
						modifiers: ["right_command"],
					},
				],
			},
			// Note: No literal connection. Both f and n are already taken.
			i: {
				description: "Window: Forward",
				to: [
					{
						key_code: "close_bracket",
						modifiers: ["right_command"],
					},
				],
			},
			d: {
				description: "Window: Close",
				to: [
					{
						key_code: "w",
						modifiers: ["right_command"],
					},
				],
			},
		},

		// d = Music
		d: {
			n: {
				to: [
					{
						key_code: "volume_decrement",
					},
				],
			},
			e: {
				to: [
					{
						key_code: "volume_increment",
					},
				],
			},
			i: raycast("fedevitaledev/music/toggle-play-pause?launchType=background"),
			h: raycast("fedevitaledev/music/previous-track?launchType=background"),
			comma: raycast("fedevitaledev/music/next-track?launchType=background"),
			l: raycast("fedevitaledev/music/play-library-album"),
			u: raycast("fedevitaledev/music/start-playlist"),
			y: raycast("fedevitaledev/music/favorite?launchType=background"),
			period: raycast(
				"fedevitaledev/music/add-to-playlist?launchType=background",
			),
		},

		// x = System
		x: {
			n: {
				to: [
					{
						key_code: "display_brightness_decrement",
					},
				],
			},
			e: {
				to: [
					{
						key_code: "display_brightness_increment",
					},
				],
			},
			// Logout
			o: {
				to: [
					{
						key_code: "q",
						modifiers: ["right_control", "right_command"],
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

		// r = "Raycast"
		r: {
			n: raycast("raycast/clipboard-history/clipboard-history"),
			e: raycast("raycast/file-search/search-files"),
			// n: open("raycast://script-commands/dismiss-notifications"),
			i: raycast("raycast/emoji-symbols/search-emoji-symbols"),
			c: raycast("raycast/raycast/confetti"),
			h: raycast("nhojb/brew/search"),
			comma: raycast("vercel/vercast/search-deployments"),
			period: raycast("raycast/github/my-latest-repositories"),
			l: raycast("raycast/raycast-focus/start-focus-session"),
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
					virtual_hid_keyboard: { keyboard_type_v2: "ansi" },
				},
			],
		},
		null,
		1,
	),
);
