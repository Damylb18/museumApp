using Microsoft.IdentityModel.Tokens;

namespace CMM_Admin.Helpers;

public class ImageHandler
{
    private readonly List<string> _validExtensions = [".jpg", ".png"];
    private const int MaxSizeMb = 10;
    private string FileExtensionsString => string.Join(" ", _validExtensions);

    public ImageValidationResult CheckUpload(IFormFileCollection filesCollection)
    {
        if (filesCollection.IsNullOrEmpty())
            return new ImageValidationResult(false, "No image file provided");

        var file = filesCollection[0];

        if (!FileExtensionIsValid(file))
            return new ImageValidationResult(false, $"Invalid file. Accepted formats are {FileExtensionsString}");

        if (!FileIsWithinSizeLimit(file))
            return new ImageValidationResult(false, $"File size must be less than {MaxSizeMb}MB");

        if (FileIsEmpty(file))
            return new ImageValidationResult(false, "Provided file is empty");

        return new ImageValidationResult(true, null);
    }

    public async Task<ImageUploadResult> SaveImage(IFormFile file, string id)
        // Intended to be called only after CheckUpload
    {
        try
        {
            var targetDir = Path.Combine(AppContext.BaseDirectory, "Data", "img");
            Directory.CreateDirectory(targetDir);

            var fileExtension = Path.GetExtension(file.FileName);
            var newFileName = id + fileExtension;
            var targetPath = Path.Combine(targetDir, newFileName);

            await using var fileStream = new FileStream(targetPath, FileMode.Create);
            await file.CopyToAsync(fileStream);

            return new ImageUploadResult(true, targetPath, null);
        }
        catch (Exception e)
        {
            await Console.Error.WriteLineAsync($"Image save error: {e}");
            return new ImageUploadResult(false, null, "Image upload failed. Please try again");
        }
    }

    private bool FileIsWithinSizeLimit(IFormFile file)
    {
        const long MB = 1024 * 1024;
        return (file.Length <= MaxSizeMb * MB);
    }

    private bool FileIsEmpty(IFormFile file) => file.Length == 0;

    private bool FileExtensionIsValid(IFormFile file)
    {
        var extension = Path.GetExtension(file.FileName).ToLowerInvariant();
        return _validExtensions.Contains(extension);
    }
}