using CMM_Admin.API;
using CMM_Admin.Data;
using CMM_Admin.Helpers;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;


var builder = WebApplication.CreateBuilder(args);

// Construct absolute database path
var dbDir = Path.Combine(AppContext.BaseDirectory, "Data");
Directory.CreateDirectory(dbDir);
var dbPath = Path.Combine(dbDir, "app.db");
var absConnectionString = $"Data Source={dbPath}";

// Add db context to the container
builder.Services.AddDbContext<MuseumContext>(options =>
    // options.UseSqlite(builder.Configuration.GetConnectionString("Database"))
    options.UseSqlite(absConnectionString)
);


builder.Services.AddTransient<ImageHandler>();


builder.Services
    .AddIdentity<IdentityUser, IdentityRole>(options =>
        {
            options.SignIn.RequireConfirmedAccount = true;
            options.Stores.MaxLengthForKeys = 128;
            options.Password.RequireUppercase = false;
            options.Password.RequireNonAlphanumeric = false;
            options.Password.RequireDigit = false;
        }
    )
    .AddEntityFrameworkStores<MuseumContext>()
    .AddRoles<IdentityRole>()
    .AddDefaultTokenProviders();

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("RequireAdmin", policyBuilder => policyBuilder.RequireRole("Admin"));
});

builder.Services.AddRazorPages().AddRazorPagesOptions(options =>
{
    options.Conventions.AuthorizeFolder("/Artifacts", "RequireAdmin");
});


var app = builder.Build();


// Create DB and initialise admin user

using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var context = services.GetRequiredService<MuseumContext>();
    context.Database.Migrate();
    var userManager = services.GetRequiredService<UserManager<IdentityUser>>();
    var roleManager = services.GetRequiredService<RoleManager<IdentityRole>>();
    AdminUserInitialiser.Initialise(context, userManager, roleManager).Wait();
}

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();
app.MapRazorPages();


// Minimal API
app.MapArtifactEndpoints();

app.Run();