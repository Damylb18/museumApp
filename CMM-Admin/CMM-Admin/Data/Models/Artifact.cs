using System.ComponentModel.DataAnnotations;

namespace CMM_Admin.Data.Models;

public class Artifact
{
    [MaxLength(100)] public required string ArtifactId { get; set; } = "";
    
    [Required]
    [MaxLength(100)]
    public required string Name { get; set; }
    
    [MaxLength(200)] public required string ImagePath { get; set; } = "";
    
    [Required]
    [MaxLength(500)]
    public required string Description { get; set; }
}