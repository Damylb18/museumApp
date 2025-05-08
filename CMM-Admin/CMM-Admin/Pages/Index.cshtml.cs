using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CMM_Admin.Pages;

public class IndexModel : PageModel
{
    private readonly ILogger<IndexModel> _logger;

    public IndexModel(ILogger<IndexModel> logger)
    {
        _logger = logger;
    }

    public IActionResult OnGet()
    {
        if (User.IsInRole("Admin"))
        {
            return RedirectToPage("Artifacts/Index");
        }
        else
        {
            return RedirectToPage("Account/Login", new {area = "Identity"});
        }
        
    }
}