using Microsoft.AspNetCore.Identity;

namespace CMM_Admin.Data;

public static class AdminUserInitialiser
{
    public static async Task Initialise(MuseumContext context,
        UserManager<IdentityUser> userManager,
        RoleManager<IdentityRole> roleManager)
    {
        await context.Database.EnsureCreatedAsync();
        
        const string adminRole = "Admin";
        const string username = "admin";
        const string password = "humble.flanked.repackage.unpiloted.sulfide";

        //Create admin role if not exists
        if (!await roleManager.RoleExistsAsync(adminRole))
        {
            await roleManager.CreateAsync(new IdentityRole(adminRole));
        }
        
        //Create admin user if not exist
        if (await userManager.FindByNameAsync("cmm-admin") == null)
        {
            var adminUser = new IdentityUser
            {
                UserName = username,
                EmailConfirmed = true,
                LockoutEnabled = false
            };

            var result = await userManager.CreateAsync(adminUser);
            if (result.Succeeded)
            {
                await userManager.AddPasswordAsync(adminUser, password);
                await userManager.AddToRoleAsync(adminUser, adminRole);
            }
        }
    }
}