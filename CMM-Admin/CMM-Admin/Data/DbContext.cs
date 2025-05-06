using CMM_Admin.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace CMM_Admin.Data;


public class MuseumContext : DbContext
{
    public MuseumContext() {}
    
    public MuseumContext(DbContextOptions<MuseumContext> options) : base(options) {}
    
    
    public DbSet<Artifact> Artifacts { get; set; }
}