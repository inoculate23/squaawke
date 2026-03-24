{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 8,
            "minor": 6,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            100.0,
            100.0,
            900.0,
            760.0
        ],
        "bglocked": 0,
        "openinpresentation": 0,
        "default_fontsize": 14.0,
        "default_fontface": 0,
        "default_fontname": "Arial",
        "gridon": 1,
        "gridsize": [
            15.0,
            15.0
        ],
        "gridsnaponopen": 1,
        "objectsnapdelay": 400,
        "snap": 0,
        "internalsegmentation": 0,
        "showontab": 0,
        "boxes": [
            {
                "box": {
                    "bgcolor": [
                        0.12,
                        0.12,
                        0.12,
                        1.0
                    ],
                    "id": "obj-title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        15.0,
                        12.0,
                        500.0,
                        34.0
                    ],
                    "text": "DEMUCS STEM SEPARATOR",
                    "fontname": "Arial Bold",
                    "fontsize": 22.0,
                    "textcolor": [
                        0.9,
                        0.75,
                        0.2,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-subtitle",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        15.0,
                        46.0,
                        600.0,
                        20.0
                    ],
                    "text": "Drop audio file below  \u00b7  Select model  \u00b7  Hit Separate  \u00b7  Play stems",
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.6,
                        0.6,
                        0.6,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-node",
                    "maxclass": "newobj",
                    "text": "node.script demucs_bridge.js",
                    "patching_rect": [
                        300.0,
                        680.0,
                        260.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-route",
                    "maxclass": "newobj",
                    "text": "route status progress stems twostems error done",
                    "patching_rect": [
                        300.0,
                        630.0,
                        420.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 7,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "bang"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-dropfile",
                    "maxclass": "dropfile",
                    "patching_rect": [
                        15.0,
                        78.0,
                        560.0,
                        60.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "bgcolor": [
                        0.15,
                        0.15,
                        0.15,
                        1.0
                    ],
                    "bordercolor": [
                        0.4,
                        0.4,
                        0.4,
                        1.0
                    ],
                    "hint": "Drop audio file here (wav, mp3, flac, aiff)",
                    "fontsize": 14.0
                }
            },
            {
                "box": {
                    "id": "obj-filepath-store",
                    "maxclass": "newobj",
                    "text": "s filepath",
                    "patching_rect": [
                        15.0,
                        148.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 0,
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-filepath-display",
                    "maxclass": "textedit",
                    "patching_rect": [
                        15.0,
                        150.0,
                        560.0,
                        22.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "fontsize": 13.0,
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                    ],
                    "textcolor": [
                        0.7,
                        0.9,
                        0.7,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-model-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        15.0,
                        183.0,
                        80.0,
                        20.0
                    ],
                    "text": "Model:",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.8,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-model-menu",
                    "maxclass": "umenu",
                    "patching_rect": [
                        75.0,
                        181.0,
                        200.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "items": [
                        "htdemucs",
                        "htdemucs_ft",
                        "htdemucs_6s",
                        "mdx_extra",
                        "mdx_extra_q"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-mode-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        290.0,
                        183.0,
                        80.0,
                        20.0
                    ],
                    "text": "Mode:",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.8,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-mode-menu",
                    "maxclass": "umenu",
                    "patching_rect": [
                        340.0,
                        181.0,
                        230.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "items": [
                        "4-stem (drums bass vocals other)",
                        "2-stem: vocals / no_vocals",
                        "2-stem: drums / no_drums",
                        "2-stem: bass / no_bass"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-outdir-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        15.0,
                        217.0,
                        70.0,
                        20.0
                    ],
                    "text": "Output:",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.8,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-outdir-field",
                    "maxclass": "textedit",
                    "patching_rect": [
                        80.0,
                        215.0,
                        400.0,
                        22.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "text": "/tmp/demucs_out",
                    "fontsize": 13.0,
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                    ],
                    "textcolor": [
                        0.7,
                        0.7,
                        1.0,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.15,
                        0.45,
                        0.15,
                        1.0
                    ],
                    "id": "obj-separate-btn",
                    "maxclass": "button",
                    "patching_rect": [
                        490.0,
                        178.0,
                        85.0,
                        62.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "hint": "Separate stems",
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-separate-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        484.0,
                        245.0,
                        97.0,
                        20.0
                    ],
                    "text": "  SEPARATE",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.4,
                        0.9,
                        0.4,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.45,
                        0.15,
                        0.15,
                        1.0
                    ],
                    "id": "obj-cancel-btn",
                    "maxclass": "button",
                    "patching_rect": [
                        590.0,
                        178.0,
                        60.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "hint": "Cancel"
                }
            },
            {
                "box": {
                    "id": "obj-cancel-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        590.0,
                        210.0,
                        60.0,
                        20.0
                    ],
                    "text": "  CANCEL",
                    "fontsize": 11.0,
                    "textcolor": [
                        0.9,
                        0.4,
                        0.4,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-cancel-msg",
                    "maxclass": "message",
                    "text": "cancel",
                    "patching_rect": [
                        590.0,
                        240.0,
                        60.0,
                        22.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-status-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        15.0,
                        248.0,
                        60.0,
                        20.0
                    ],
                    "text": "Status:",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.6,
                        0.6,
                        0.6,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-status-display",
                    "maxclass": "textedit",
                    "patching_rect": [
                        75.0,
                        246.0,
                        500.0,
                        22.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "text": "Ready \u2014 drop a file to begin",
                    "fontsize": 13.0,
                    "bgcolor": [
                        0.08,
                        0.08,
                        0.08,
                        1.0
                    ],
                    "textcolor": [
                        0.4,
                        0.9,
                        0.4,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-progress",
                    "maxclass": "newobj",
                    "text": "number",
                    "patching_rect": [
                        590.0,
                        248.0,
                        60.0,
                        22.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-progress-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        655.0,
                        248.0,
                        30.0,
                        20.0
                    ],
                    "text": "%",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.6,
                        0.6,
                        0.6,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-divider",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        15.0,
                        274.0,
                        860.0,
                        1.0
                    ],
                    "text": "",
                    "bgcolor": [
                        0.3,
                        0.3,
                        0.3,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-stems-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        15.0,
                        280.0,
                        200.0,
                        22.0
                    ],
                    "text": "STEMS \u2014 individual playback",
                    "fontname": "Arial Bold",
                    "fontsize": 14.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.8,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-buf-drums",
                    "maxclass": "newobj",
                    "text": "buffer~ buf_drums",
                    "patching_rect": [
                        15.0,
                        700.0,
                        160.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-buf-bass",
                    "maxclass": "newobj",
                    "text": "buffer~ buf_bass",
                    "patching_rect": [
                        185.0,
                        700.0,
                        155.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-buf-vocals",
                    "maxclass": "newobj",
                    "text": "buffer~ buf_vocals",
                    "patching_rect": [
                        350.0,
                        700.0,
                        165.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-buf-other",
                    "maxclass": "newobj",
                    "text": "buffer~ buf_other",
                    "patching_rect": [
                        525.0,
                        700.0,
                        160.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-groove-drums",
                    "maxclass": "newobj",
                    "text": "groove~ buf_drums 1",
                    "patching_rect": [
                        15.0,
                        430.0,
                        155.0,
                        24.0
                    ],
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-groove-bass",
                    "maxclass": "newobj",
                    "text": "groove~ buf_bass 1",
                    "patching_rect": [
                        185.0,
                        430.0,
                        150.0,
                        24.0
                    ],
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-groove-vocals",
                    "maxclass": "newobj",
                    "text": "groove~ buf_vocals 1",
                    "patching_rect": [
                        350.0,
                        430.0,
                        160.0,
                        24.0
                    ],
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-groove-other",
                    "maxclass": "newobj",
                    "text": "groove~ buf_other 1",
                    "patching_rect": [
                        525.0,
                        430.0,
                        155.0,
                        24.0
                    ],
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-label-drums",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        15.0,
                        308.0,
                        155.0,
                        22.0
                    ],
                    "text": "DRUMS",
                    "fontname": "Arial Bold",
                    "fontsize": 16.0,
                    "textcolor": [
                        1.0,
                        0.5,
                        0.3,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-label-bass",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        185.0,
                        308.0,
                        155.0,
                        22.0
                    ],
                    "text": "BASS",
                    "fontname": "Arial Bold",
                    "fontsize": 16.0,
                    "textcolor": [
                        0.5,
                        0.7,
                        1.0,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-label-vocals",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        350.0,
                        308.0,
                        165.0,
                        22.0
                    ],
                    "text": "VOCALS",
                    "fontname": "Arial Bold",
                    "fontsize": 16.0,
                    "textcolor": [
                        0.7,
                        1.0,
                        0.5,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-label-other",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        525.0,
                        308.0,
                        155.0,
                        22.0
                    ],
                    "text": "OTHER",
                    "fontname": "Arial Bold",
                    "fontsize": 16.0,
                    "textcolor": [
                        0.9,
                        0.9,
                        0.3,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-vol-drums",
                    "maxclass": "slider",
                    "patching_rect": [
                        15.0,
                        335.0,
                        155.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "min": 0.0,
                    "max": 1.0,
                    "floatoutput": 1,
                    "size": 1.0,
                    "knobcolor": [
                        1.0,
                        0.5,
                        0.3,
                        1.0
                    ],
                    "bgcolor": [
                        0.15,
                        0.15,
                        0.15,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-vol-bass",
                    "maxclass": "slider",
                    "patching_rect": [
                        185.0,
                        335.0,
                        150.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "min": 0.0,
                    "max": 1.0,
                    "floatoutput": 1,
                    "size": 1.0,
                    "knobcolor": [
                        0.5,
                        0.7,
                        1.0,
                        1.0
                    ],
                    "bgcolor": [
                        0.15,
                        0.15,
                        0.15,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-vol-vocals",
                    "maxclass": "slider",
                    "patching_rect": [
                        350.0,
                        335.0,
                        160.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "min": 0.0,
                    "max": 1.0,
                    "floatoutput": 1,
                    "size": 1.0,
                    "knobcolor": [
                        0.7,
                        1.0,
                        0.5,
                        1.0
                    ],
                    "bgcolor": [
                        0.15,
                        0.15,
                        0.15,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-vol-other",
                    "maxclass": "slider",
                    "patching_rect": [
                        525.0,
                        335.0,
                        155.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "min": 0.0,
                    "max": 1.0,
                    "floatoutput": 1,
                    "size": 1.0,
                    "knobcolor": [
                        0.9,
                        0.9,
                        0.3,
                        1.0
                    ],
                    "bgcolor": [
                        0.15,
                        0.15,
                        0.15,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-mute-drums",
                    "maxclass": "toggle",
                    "patching_rect": [
                        15.0,
                        375.0,
                        30.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "checkedcolor": [
                        1.0,
                        0.5,
                        0.3,
                        1.0
                    ],
                    "uncheckedcolor": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-mute-drums-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        50.0,
                        378.0,
                        50.0,
                        20.0
                    ],
                    "text": "on/off",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.6,
                        0.6,
                        0.6,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-mute-bass",
                    "maxclass": "toggle",
                    "patching_rect": [
                        185.0,
                        375.0,
                        30.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "checkedcolor": [
                        0.5,
                        0.7,
                        1.0,
                        1.0
                    ],
                    "uncheckedcolor": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-mute-bass-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        220.0,
                        378.0,
                        50.0,
                        20.0
                    ],
                    "text": "on/off",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.6,
                        0.6,
                        0.6,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-mute-vocals",
                    "maxclass": "toggle",
                    "patching_rect": [
                        350.0,
                        375.0,
                        30.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "checkedcolor": [
                        0.7,
                        1.0,
                        0.5,
                        1.0
                    ],
                    "uncheckedcolor": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-mute-vocals-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        385.0,
                        378.0,
                        50.0,
                        20.0
                    ],
                    "text": "on/off",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.6,
                        0.6,
                        0.6,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-mute-other",
                    "maxclass": "toggle",
                    "patching_rect": [
                        525.0,
                        375.0,
                        30.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "checkedcolor": [
                        0.9,
                        0.9,
                        0.3,
                        1.0
                    ],
                    "uncheckedcolor": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-mute-other-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        560.0,
                        378.0,
                        50.0,
                        20.0
                    ],
                    "text": "on/off",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.6,
                        0.6,
                        0.6,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-gate-drums",
                    "maxclass": "newobj",
                    "text": "gate~ 1",
                    "patching_rect": [
                        15.0,
                        470.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-gate-bass",
                    "maxclass": "newobj",
                    "text": "gate~ 1",
                    "patching_rect": [
                        185.0,
                        470.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-gate-vocals",
                    "maxclass": "newobj",
                    "text": "gate~ 1",
                    "patching_rect": [
                        350.0,
                        470.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-gate-other",
                    "maxclass": "newobj",
                    "text": "gate~ 1",
                    "patching_rect": [
                        525.0,
                        470.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-gain-drums",
                    "maxclass": "newobj",
                    "text": "*~ 1.0",
                    "patching_rect": [
                        15.0,
                        503.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-gain-bass",
                    "maxclass": "newobj",
                    "text": "*~ 1.0",
                    "patching_rect": [
                        185.0,
                        503.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-gain-vocals",
                    "maxclass": "newobj",
                    "text": "*~ 1.0",
                    "patching_rect": [
                        350.0,
                        503.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-gain-other",
                    "maxclass": "newobj",
                    "text": "*~ 1.0",
                    "patching_rect": [
                        525.0,
                        503.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-transport-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        700.0,
                        280.0,
                        170.0,
                        22.0
                    ],
                    "text": "TRANSPORT",
                    "fontname": "Arial Bold",
                    "fontsize": 14.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.8,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-play-btn",
                    "maxclass": "button",
                    "patching_rect": [
                        700.0,
                        308.0,
                        50.0,
                        50.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "bgcolor": [
                        0.15,
                        0.5,
                        0.15,
                        1.0
                    ],
                    "hint": "Play"
                }
            },
            {
                "box": {
                    "id": "obj-play-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        703.0,
                        362.0,
                        50.0,
                        20.0
                    ],
                    "text": "  PLAY",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.4,
                        0.9,
                        0.4,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-stop-btn",
                    "maxclass": "button",
                    "patching_rect": [
                        760.0,
                        308.0,
                        50.0,
                        50.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "bgcolor": [
                        0.5,
                        0.15,
                        0.15,
                        1.0
                    ],
                    "hint": "Stop"
                }
            },
            {
                "box": {
                    "id": "obj-stop-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        763.0,
                        362.0,
                        50.0,
                        20.0
                    ],
                    "text": "  STOP",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.9,
                        0.4,
                        0.4,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-loop-toggle",
                    "maxclass": "toggle",
                    "patching_rect": [
                        700.0,
                        390.0,
                        30.0,
                        30.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "checkedcolor": [
                        0.5,
                        0.8,
                        1.0,
                        1.0
                    ],
                    "uncheckedcolor": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-loop-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        735.0,
                        393.0,
                        60.0,
                        20.0
                    ],
                    "text": "Loop",
                    "fontsize": 13.0,
                    "textcolor": [
                        0.7,
                        0.7,
                        0.7,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-msg-play",
                    "maxclass": "message",
                    "text": "1",
                    "patching_rect": [
                        700.0,
                        430.0,
                        30.0,
                        22.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-msg-stop",
                    "maxclass": "message",
                    "text": "0",
                    "patching_rect": [
                        760.0,
                        430.0,
                        30.0,
                        22.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-dac",
                    "maxclass": "newobj",
                    "text": "ezdac~",
                    "patching_rect": [
                        200.0,
                        590.0,
                        80.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 0,
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-unpack",
                    "maxclass": "newobj",
                    "text": "unpack s s s s",
                    "patching_rect": [
                        15.0,
                        610.0,
                        200.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-pre-drums",
                    "maxclass": "newobj",
                    "text": "prepend read",
                    "patching_rect": [
                        15.0,
                        643.0,
                        110.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-pre-bass",
                    "maxclass": "newobj",
                    "text": "prepend read",
                    "patching_rect": [
                        185.0,
                        643.0,
                        110.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-pre-vocals",
                    "maxclass": "newobj",
                    "text": "prepend read",
                    "patching_rect": [
                        350.0,
                        643.0,
                        110.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-pre-other",
                    "maxclass": "newobj",
                    "text": "prepend read",
                    "patching_rect": [
                        525.0,
                        643.0,
                        110.0,
                        24.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-mix-db",
                    "maxclass": "newobj",
                    "text": "+~",
                    "patching_rect": [
                        15.0,
                        540.0,
                        40.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-mix-vo",
                    "maxclass": "newobj",
                    "text": "+~",
                    "patching_rect": [
                        185.0,
                        540.0,
                        40.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-mix-final",
                    "maxclass": "newobj",
                    "text": "+~",
                    "patching_rect": [
                        100.0,
                        572.0,
                        40.0,
                        24.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-pre-filepath",
                    "maxclass": "newobj",
                    "text": "prepend filepath",
                    "patching_rect": [
                        15.0,
                        268.0,
                        120.0,
                        22.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-pre-model",
                    "maxclass": "newobj",
                    "text": "prepend model",
                    "patching_rect": [
                        75.0,
                        210.0,
                        110.0,
                        22.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-pre-outdir",
                    "maxclass": "newobj",
                    "text": "prepend outdir",
                    "patching_rect": [
                        80.0,
                        240.0,
                        110.0,
                        22.0
                    ],
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            },
            {
                "box": {
                    "id": "obj-msg-separate",
                    "maxclass": "message",
                    "text": "separate",
                    "patching_rect": [
                        490.0,
                        248.0,
                        80.0,
                        22.0
                    ],
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "fontsize": 13.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-node",
                        0
                    ],
                    "destination": [
                        "obj-route",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-dropfile",
                        0
                    ],
                    "destination": [
                        "obj-filepath-display",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-dropfile",
                        0
                    ],
                    "destination": [
                        "obj-filepath-store",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-route",
                        0
                    ],
                    "destination": [
                        "obj-status-display",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-route",
                        1
                    ],
                    "destination": [
                        "obj-progress",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-groove-drums",
                        0
                    ],
                    "destination": [
                        "obj-gate-drums",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-groove-bass",
                        0
                    ],
                    "destination": [
                        "obj-gate-bass",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-groove-vocals",
                        0
                    ],
                    "destination": [
                        "obj-gate-vocals",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-groove-other",
                        0
                    ],
                    "destination": [
                        "obj-gate-other",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-mute-drums",
                        0
                    ],
                    "destination": [
                        "obj-gate-drums",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-mute-bass",
                        0
                    ],
                    "destination": [
                        "obj-gate-bass",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-mute-vocals",
                        0
                    ],
                    "destination": [
                        "obj-gate-vocals",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-mute-other",
                        0
                    ],
                    "destination": [
                        "obj-gate-other",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-gate-drums",
                        0
                    ],
                    "destination": [
                        "obj-gain-drums",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-gate-bass",
                        0
                    ],
                    "destination": [
                        "obj-gain-bass",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-gate-vocals",
                        0
                    ],
                    "destination": [
                        "obj-gain-vocals",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-gate-other",
                        0
                    ],
                    "destination": [
                        "obj-gain-other",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-vol-drums",
                        0
                    ],
                    "destination": [
                        "obj-gain-drums",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-vol-bass",
                        0
                    ],
                    "destination": [
                        "obj-gain-bass",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-vol-vocals",
                        0
                    ],
                    "destination": [
                        "obj-gain-vocals",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-vol-other",
                        0
                    ],
                    "destination": [
                        "obj-gain-other",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-play-btn",
                        0
                    ],
                    "destination": [
                        "obj-msg-play",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-stop-btn",
                        0
                    ],
                    "destination": [
                        "obj-msg-stop",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-msg-play",
                        0
                    ],
                    "destination": [
                        "obj-groove-drums",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-msg-play",
                        0
                    ],
                    "destination": [
                        "obj-groove-bass",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-msg-play",
                        0
                    ],
                    "destination": [
                        "obj-groove-vocals",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-msg-play",
                        0
                    ],
                    "destination": [
                        "obj-groove-other",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-msg-stop",
                        0
                    ],
                    "destination": [
                        "obj-groove-drums",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-msg-stop",
                        0
                    ],
                    "destination": [
                        "obj-groove-bass",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-msg-stop",
                        0
                    ],
                    "destination": [
                        "obj-groove-vocals",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-msg-stop",
                        0
                    ],
                    "destination": [
                        "obj-groove-other",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-loop-toggle",
                        0
                    ],
                    "destination": [
                        "obj-groove-drums",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-loop-toggle",
                        0
                    ],
                    "destination": [
                        "obj-groove-bass",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-loop-toggle",
                        0
                    ],
                    "destination": [
                        "obj-groove-vocals",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-loop-toggle",
                        0
                    ],
                    "destination": [
                        "obj-groove-other",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-cancel-btn",
                        0
                    ],
                    "destination": [
                        "obj-cancel-msg",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-cancel-msg",
                        0
                    ],
                    "destination": [
                        "obj-node",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-route",
                        2
                    ],
                    "destination": [
                        "obj-unpack",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-unpack",
                        0
                    ],
                    "destination": [
                        "obj-pre-drums",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-unpack",
                        1
                    ],
                    "destination": [
                        "obj-pre-bass",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-unpack",
                        2
                    ],
                    "destination": [
                        "obj-pre-vocals",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-unpack",
                        3
                    ],
                    "destination": [
                        "obj-pre-other",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-pre-drums",
                        0
                    ],
                    "destination": [
                        "obj-buf-drums",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-pre-bass",
                        0
                    ],
                    "destination": [
                        "obj-buf-bass",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-pre-vocals",
                        0
                    ],
                    "destination": [
                        "obj-buf-vocals",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-pre-other",
                        0
                    ],
                    "destination": [
                        "obj-buf-other",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-gain-drums",
                        0
                    ],
                    "destination": [
                        "obj-mix-db",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-gain-bass",
                        0
                    ],
                    "destination": [
                        "obj-mix-db",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-gain-vocals",
                        0
                    ],
                    "destination": [
                        "obj-mix-vo",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-gain-other",
                        0
                    ],
                    "destination": [
                        "obj-mix-vo",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-mix-db",
                        0
                    ],
                    "destination": [
                        "obj-mix-final",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-mix-vo",
                        0
                    ],
                    "destination": [
                        "obj-mix-final",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-mix-final",
                        0
                    ],
                    "destination": [
                        "obj-dac",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-mix-final",
                        0
                    ],
                    "destination": [
                        "obj-dac",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-dropfile",
                        0
                    ],
                    "destination": [
                        "obj-pre-filepath",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-pre-filepath",
                        0
                    ],
                    "destination": [
                        "obj-node",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-model-menu",
                        1
                    ],
                    "destination": [
                        "obj-pre-model",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-pre-model",
                        0
                    ],
                    "destination": [
                        "obj-node",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-outdir-field",
                        0
                    ],
                    "destination": [
                        "obj-pre-outdir",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-pre-outdir",
                        0
                    ],
                    "destination": [
                        "obj-node",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-separate-btn",
                        0
                    ],
                    "destination": [
                        "obj-msg-separate",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-msg-separate",
                        0
                    ],
                    "destination": [
                        "obj-node",
                        0
                    ]
                }
            }
        ]
    }
}