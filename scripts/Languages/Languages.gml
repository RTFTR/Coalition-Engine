///Multi language support
enum LANGUAGE
{
	ENGLISH,
	CHINESE
}

enum LANGUAGE_TEXTS
{
	FONT,
	FONT_NO_BRACKET,
	SPARE,
	FLEE,
	WIN1,
	WIN2,
	WIN3,
	WIN4,
	INC_LOVE,
	PAGE0,
	PAGE1,
}

///@desc Loads the texts of different languages and store them inside the global array.
///		 Different language may have different spacing and line breaking, you have to change those yourself.
///		 You also have to manually add the range of the font during edit because the current font method doesn't support auto update.
///		 (Note that if you change the global.Language, you have to run this function again)
function LoadLanguageTexts()
{
	//Only create the array if it doesn't exist
	if !variable_global_exists("AllLanguageTexts")
	{
		global.AllLanguageTexts = [];
		var curLang = [];
		curLang[LANGUAGE_TEXTS.FONT] = "[fnt_dt_mono]";
		curLang[LANGUAGE_TEXTS.FONT_NO_BRACKET] = "fnt_dt_mono";
		curLang[LANGUAGE_TEXTS.SPARE] = "* Spare";
		curLang[LANGUAGE_TEXTS.FLEE] = "* Flee";
		curLang[LANGUAGE_TEXTS.WIN1] = "You WON!";
		curLang[LANGUAGE_TEXTS.WIN2] = "You earned ";
		curLang[LANGUAGE_TEXTS.WIN3] = " XP and ";
		curLang[LANGUAGE_TEXTS.WIN4] = " gold.";
		curLang[LANGUAGE_TEXTS.INC_LOVE] = "Your LOVE increased!";
		curLang[LANGUAGE_TEXTS.PAGE0] = "PAGE ";
		curLang[LANGUAGE_TEXTS.PAGE1] = "";
		global.AllLanguageTexts[LANGUAGE.ENGLISH] = curLang;
		curLang = [];
		curLang[LANGUAGE_TEXTS.FONT] = "[fnt_menu_chin]";
		curLang[LANGUAGE_TEXTS.FONT_NO_BRACKET] = "fnt_menu_chin";
		curLang[LANGUAGE_TEXTS.SPARE] = "* 饶恕";
		curLang[LANGUAGE_TEXTS.FLEE] = "* 逃跑";
		curLang[LANGUAGE_TEXTS.WIN1] = "你赢了!";
		curLang[LANGUAGE_TEXTS.WIN2] = "你得到了 ";
		curLang[LANGUAGE_TEXTS.WIN3] = " 个金币以及 ";
		curLang[LANGUAGE_TEXTS.WIN4] = " 点经验值。";
		curLang[LANGUAGE_TEXTS.INC_LOVE] = "你的 LOVE 提升了!";
		curLang[LANGUAGE_TEXTS.PAGE0] = "第 ";
		curLang[LANGUAGE_TEXTS.PAGE1] = "页";
		global.AllLanguageTexts[LANGUAGE.CHINESE] = curLang;
		curLang = -1;
	}
}