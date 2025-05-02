using System.ComponentModel.DataAnnotations;

namespace CMM_Admin.Data.Models;

public class Artifact
{
    [Required]
    public int ArtifactId { get; init; }
    
    [Required]
    [MaxLength(200)]
    public required string ImagePath { get; set; }
    
    [Required]
    [MaxLength(500)]
    public required string Description { get; set; }
}