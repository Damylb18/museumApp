using CMM_Admin.Data;

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
                Name = artifact.Name,
                Description = artifact.Description,
                Img = artifact.ImagePath
            };

            return Results.Ok(data);
        });

        // TODO Write image api
        
        // app.MapGet("/api/artifact/img/{id:int}", (int id) =>
        // {
        //     var fileBytes = System.IO.File.ReadAllBytes(
        //         "/home/jonty/Chester/Cheshire-Military-Museum/museum-app/CMM-Admin/CMM-Admin/Data/img/6d5f6273-2b38-4faf-9cc1-84616ac34fc3.png");
        //     return Results.File(fileBytes, "image/jpeg", "test-img.jpg");
        // });
    }
}