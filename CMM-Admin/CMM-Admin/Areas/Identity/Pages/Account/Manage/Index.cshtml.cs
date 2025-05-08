// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

#nullable disable

using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Encodings.Web;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CMM_Admin.Areas.Identity.Pages.Account.Manage
{
    public class IndexModel(UserManager<IdentityUser> userManager, SignInManager<IdentityUser> signInManager)
        : PageModel
    {
        public string Username { get; set; }

        [TempData]
        public string StatusMessage { get; set; }

        [BindProperty]
        public InputModel Input { get; set; }

        public class InputModel
        {
            [EmailAddress]
            [Display(Name = "Email")]
            public string Email { get; set; }
        }
        

        private async Task LoadAsync(IdentityUser user)
        {
            var userName = await userManager.GetUserNameAsync(user);
            var email = await userManager.GetEmailAsync(user);

            Username = userName;

            Input = new InputModel
            {
                Email = email
            };
        }

        public async Task<IActionResult> OnGetAsync()
        {
            var user = await userManager.GetUserAsync(User);
            if (user == null)
            {
                return NotFound($"Unable to load user with ID '{userManager.GetUserId(User)}'.");
            }

            await LoadAsync(user);
            return Page();
        }

        // public async Task<IActionResult> OnPostAsync()
        public void OnPost()
        {
            // var user = await userManager.GetUserAsync(User);
            // if (user == null)
            // {
            //     return NotFound($"Unable to load user with ID '{userManager.GetUserId(User)}'.");
            // }
            //
            // if (!ModelState.IsValid)
            // {
            //     await LoadAsync(user);
            //     return Page();
            // }
            //
            // var email = await userManager.GetEmailAsync(user);
            // if (Input.Email != email)
            // {
            //     var setEmailResult = await userManager.SetEmailAsync(user, Input.Email);
            //     if (!setEmailResult.Succeeded)
            //     {
            //         StatusMessage = "Unexpected error when trying to set email.";
            //         return RedirectToPage();
            //     }
            // }
            //
            // await signInManager.RefreshSignInAsync(user);
            // StatusMessage = "Your profile has been updated";
            // return RedirectToPage();
        }
    }
}