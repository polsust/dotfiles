return {
  "rmagatti/alternate-toggler",
  keys = {
    { "gs", function() require("alternate-toggler").toggleAlternate() end },
  },
  opts = {
    alternates = {
      ["yes"] = "no",
      ["==="] = "!==",
      ["=="] = "!=",
      [">="] = "<=",
      ["private"] = "public",
      ["start"] = "end",
      ["desc"] = "asc",
      ["descend"] = "ascend",
      ["active"] = "inactive",
      ["true,"] = "false,",
      ["true"] = "false",
      ["local"] = "global",
      ["on"] = "off",
      ["ON"] = "OFF",
    },
  },
}
