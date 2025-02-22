-- Some are inspired by:
-- https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/rust.json

return {
	-- ::<TurboFish>
	s({ trig = ":turbofish", dscr = "Turbofish\n `::<_>`" }, { t({ "::<" }), i(0), t({ ">" }) }),

	-- format!
	s({ trig = "format", desc = "format!(...)" }, {
		t({ 'format!("{' }),
		i(1, "s"),
		t({ '}", ' }),
		i(2, "v"),
		t({ ");" }),
	}),

	-- format! a debug representation
	s({ trig = "formatdbg", desc = 'format!("{:?})", var);' }, {
		t({ 'format!("{:?}", ' }),
		i(1, "v"),
		t({ ");" }),
	}),

	-- println! a debug representation
	s({ trig = "println", desc = 'println!("{:?})", var);' }, {
		t({ 'println!("{:?}", ' }),
		i(1, "v"),
		t({ ");" }),
	}),

	-- vec
	s({ trig = "vec", desc = "vec![...]" }, {
		t({ "vec![" }),
		i(1, "i"),
		t({ "];" }),
	}),

	-- Atributes:
	s("derivedebug", t("#[derive(Debug)]")),

	s({ trig = "cfg", dscr = "Attribute: cfg" }, {
		t({ "#![cfg(" }),
		i(0),
		t({ ")]" }),
	}),

	-- Flow of Control:

	s({ trig = "for", dscr = "`for _ in _` loop", priority = 5000 }, {
		t({ "for " }),
		i(1, "pat"),
		t({ " in " }),
		i(2, "expr"),
		t({ " {", "\t" }),
		-- t { '	' },
		i(0),
		t({ "", "}" }),
	}),

	s("if", {
		t({ "if " }),
		i(1, "expr"),
		t({ " {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	s("else", {
		t({ "else {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	s({ trig = "match", dscr = "`match` with two matching arms." }, {
		t({ "match " }),
		i(1, "expr"),
		t({ " {", "\t" }),
		i(2, "Some(expr)"),
		t({ " => " }),
		i(3, "expr"),
		t({ ",", "\t" }),
		i(4, "None"),
		t({ " => " }),
		i(4, "expr"),
		t({ ",", "" }),
		t({ "}" }),
	}),

	s({ trig = "while-let", dscr = "while-let" }, {
		t({ "while let " }),
		i(1, "Some(pat)"),
		t({ " = " }),
		i(2, "expr"),
		t({ "", "" }),
		t({ "{", "\t" }),
		i(3, "unimplemented!();"),
		t({ "", "" }),
		t({ "}" }),
	}),
	-- Custom Types:

	s({ trig = "struct", dscr = "Classic `struct` that implements `std::fmt::Debug`" }, {
		t({ "#[derive(Debug)]", "" }),
		t({ "struct " }),
		i(1, "Name"),
		t({ " {", "\t" }),
		i(0),
		t({ "", "" }),
		t({ "}", "" }),
	}),

	s({ trig = "fnreturn", dscr = "Return function" }, {
		t({ "fn " }),
		i(1, "name"),
		t({ "(" }),
		i(2, "arg"),
		t({ ") -> " }),
		i(3, "ret_type"),
		t({ " {", "\t" }),
		i(4, "unimplemented!();"),
		t({ "", "}" }),
	}),

	-- Testing:

	s("test", {
		t({ "#[test]", "" }),
		t({ "fn " }),
		i(1, "test"),
		t({ "() {", "\t" }),
		t({ "assert!(" }),
		i(0, "bool"),
		t({ ");", "" }),
		t({ "}" }),
	}),

	s("testmod", {
		t({ "#[cfg(test)]", "" }),
		t({ "mod " }),
		i(1, "mod_test"),
		t({ " {", "\t" }),
		t({ "use super::*;", "\t" }),
		t({ "", "\t" }),
		t({ "#[test]", "\t" }),
		t({ "fn " }),
		i(2, "test"),
		t({ "() {", "\t\t" }),
		t({ "assert!(" }),
		i(0, "bool"),
		t({ ");", "\t" }),
		t({ "}", "" }),
		t({ "}" }),
	}),

	s({ trig = "asserteq", dscr = "assert_eq!(..., ...)" }, {
		t({ "assert_eq!(" }),
		i(1, "left"),
		t({ ", " }),
		i(2, "right"),
		t({ "};" }),
	}),
}
