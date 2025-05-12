using CMM_Admin.Data;
using Microsoft.AspNetCore.StaticFiles;

namespace CMM_Admin.API;

public static class ArtifactApi
{
    public static void MapArtifactEndpoints(this IEndpointRouteBuilder app)
    {
        app.MapGet("/api/artifact/data/{id}", (string id, MuseumContext db) =>
        {
            var artifact = db.Artifacts.FirstOrDefault(m => m.ArtifactId == id);

            if (artifact is null)
            {
                return Results.NotFound(new { Message = $"Artifact with id {id} not found" });
            }

            var data = new
            {
                artifact.Name,
                artifact.Description,
                artifact.ArtifactId
            };

            return Results.Ok(data);
        });

        
        app.MapGet("/api/artifact/img/{id}", (string id) =>
        {
            var dirPath = Path.Combine(Directory.GetCurrentDirectory(), "Data", "img");
            var file = Directory.GetFiles(dirPath, $"{id}.*").FirstOrDefault();
            
            
            if (file == null)
            {
                return Results.NotFound(new { Message = "Image not found" });
            }

            var name = Path.GetFileName(file);
            
            var provider = new FileExtensionContentTypeProvider();

            if (!provider.TryGetContentType(name, out var contentType))
            {
                contentType = "application/octet-stream"; // safe fallback
            }

            var stream = File.OpenRead(file);
            return Results.File(stream, contentType, name);
        });
    }
}