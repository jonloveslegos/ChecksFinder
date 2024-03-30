var filename = file_find_first("*",0)
while (filename != "")
{
    if (string_count("obtain",filename) > 0)
    {
        file_delete(filename)
    }
    filename = file_find_next()
}
file_find_close();
var file = file_find_first("*", 0);
while (file != "")
{
    if (string_count("send",file) > 0)
        file_delete(file)
    file = file_find_next();
}
file_find_close();

