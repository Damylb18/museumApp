using CMM_Admin.Data.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace CMM_Admin.Data;


public class MuseumContext : IdentityDbContext<IdentityUser>
{
    public MuseumContext() {}
    
    public MuseumContext(DbContextOptions<MuseumContext> options) : base(options) {}
    
    
    public DbSet<Artifact> Artifacts { get; set; }
}