var i = 0, writer;
repeat array_length(TextWriterList)
{
	writer = TextWriterList[i];
	writer.draw(TextPosition[i][0], TextPosition[i][0], TextTypistList[i]);
}