char* getSubString(char* str, int start, int end)
{
    char* substr = calloc(end - start, sizeof(char));
    int iSubStr = 0;
    for(int i = start; i <= end; i++)
    {
        substr[iSubStr] = str[i];
        iSubStr++;
    }
    return substr;
}
