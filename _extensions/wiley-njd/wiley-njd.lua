
-- Convert `# Acknowledgments {.bmsection}` to `\bmsection*{Acknowledgments}`
--
-- this function will be executed for all Header elements in the document
Header = function(el)
  -- el.level == 1 makes it so you only catch "# ..." and not "## ...", etc
  -- el.classes is a pandoc List object, which has the method "includes"
  local bm_cmd = {
    [1] = "\\bmsection",
    [2] = "\\bmsubsection",
    [3] = "\\bmsubsubsection"
  }
  
  if el.classes:includes("bm") then
    if el.classes:includes("unnumbered") then
      -- pandoc.utils.stringify converts a pandoc value (in this case,
      -- the list of inlines that make up the header) into a plain string.
      local text = pandoc.utils.stringify(el.content)

      -- a RawBlock element contains a string that is passed through
      -- directly to the final element.
      local result = pandoc.RawBlock("latex", "" .. bm_cmd[el.level] .. "*{" .. text .. "}")
      return result
    else
      -- pandoc.utils.stringify converts a pandoc value (in this case,
      -- the list of inlines that make up the header) into a plain string.
      local text = pandoc.utils.stringify(el.content)

      -- a RawBlock element contains a string that is passed through
      -- directly to the final element.
      local result = pandoc.RawBlock("latex", "" .. bm_cmd[el.level] .. "{" .. text .. "}")
      return result
    end
  else
    -- a "return nil" statement is implied at the end of a lua function, but
    -- if you want to be explicit, you can add it.
    -- returning "nil" means "do not modify this element"
    return nil
  end
end