using System.Text;
using Microsoft.IdentityModel.Tokens;

namespace CMM_Admin.Helpers;

public class ImageHandler
{
    private readonly List<string> _validExtensions = [".jpg", ".png"];
    private const int MaxSizeMb = 10;
    private string FileExtensionsString => string.Join(" ", _validExtensions);

    public string CheckUpload(IFormFileCollection filesCollection)
    {
        if (filesCollection.IsNullOrEmpty())
            return "No image file provided";
        
        var file = filesCollection[0];
        
        if (!FileExtensionIsValid(file))
            return $"Invalid file. Accepted formats are {FileExtensionsString}";

        if (!FileIsWithinSizeLimit(file))
            return $"File size must be less than {MaxSizeMb}MB";

        if (FileIsEmpty(file))
            return "Provided file is empty";

        return string.Empty;
    }
    

    private bool FileIsWithinSizeLimit(IFormFile file)
    {
        const long MB = 1024 * 1024;
        return (file.Length <= MaxSizeMb * MB);
    }

    private bool FileIsEmpty(IFormFile file) => file.Length == 0;

    private bool FileExtensionIsValid(IFormFile file)
    {
        var extension = Path.GetExtension(file.FileName);
        return _validExtensions.Contains(extension);
    }
}