if instance_number(oTextController) > 1
{
	instance_destroy();
	exit;
}

TextWriterList = [];
TextTypistList = [];
TextPosition = [];
TextSkipEnabled = [];