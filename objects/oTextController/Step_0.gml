var i = 0;
repeat array_length(TextTypistList)
{
	if TextSkipEnabled[i] && input_check_pressed("cancel")
	{
		TextWriterList[i].page(TextWriterList[i].get_page_count() - 1);
		TextTypistList[i].skip_to_pause();
	}
	var page = TextWriterList[i].get_page();
	if TextTypistList[i].get_state() == 1 and page < (TextWriterList[i].get_page_count() - 1)
			TextWriterList[i].page(page + 1)
	if TextTypistList[i].get_state() == 1
	{
		array_delete(TextTypistList, i, 1);
		array_delete(TextWriterList, i, 1);
	}
}