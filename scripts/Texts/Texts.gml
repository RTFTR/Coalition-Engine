function CreateTextWriter(x, y, text, skip_enabled = false)
{
	//Create the controller if it doesn't exist already
	if !instance_exists(oTextController) instance_create_depth(0, 0, 0, oTextController);
	with oTextController
	{
		array_push(TextPosition, [x, y]);
		array_push(TextWriterList, scribble(text));
		array_push(TextTypistList, scribble_typist());
		array_push(TextSkipEnabled, skip_enabled);
	}
	return [oTextController.TextTypistList[array_length(oTextController.TextTypistList) - 1],
			oTextController.TextWriterList[array_length(oTextController.TextWriterList) - 1]];
}