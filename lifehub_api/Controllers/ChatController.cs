using Microsoft.AspNetCore.Mvc;
using LifeHub.Api.Data;
using LifeHub.Api.Models;
using LifeHub.Api.Services;

namespace LifeHub.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ChatController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        // private readonly IAiService _aiService; // Will inject this later when implemented

        public ChatController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpPost("message")]
        public async Task<IActionResult> SendMessage([FromBody] ChatRequest request)
        {
            // 1. Save user message to database
            var userMessage = new ChatMessage 
            { 
                UserId = request.UserId, 
                Role = "user", 
                Content = request.Message 
            };
            _context.ChatMessages.Add(userMessage);
            await _context.SaveChangesAsync();

            // 2. Call AI Service (Mocked for now)
            // var aiResponseText = await _aiService.GetChatResponseAsync(request.Message);
            var aiResponseText = $"This is a mocked AI response to: {request.Message}";

            // 3. Save AI message to database
            var aiMessage = new ChatMessage 
            { 
                UserId = request.UserId, 
                Role = "ai", 
                Content = aiResponseText 
            };
            _context.ChatMessages.Add(aiMessage);
            await _context.SaveChangesAsync();

            return Ok(new { response = aiResponseText });
        }
    }

    public class ChatRequest
    {
        public int UserId { get; set; }
        public string Message { get; set; } = string.Empty;
    }
}
