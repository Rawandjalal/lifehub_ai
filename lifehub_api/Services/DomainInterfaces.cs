using System.Threading.Tasks;

namespace LifeHub.Api.Services
{
    public interface IAiService
    {
        Task<string> GetChatResponseAsync(string prompt);
        Task<string> SummarizeNoteAsync(string content);
    }
    
    public interface IStorageService
    {
        Task<string> UploadFileAsync(byte[] fileBytes, string fileName);
        Task<bool> DeleteFileAsync(string fileUrl);
    }
}
