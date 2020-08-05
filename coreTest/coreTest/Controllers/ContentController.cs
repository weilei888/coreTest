using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using coreTest.Models;
using Microsoft.Extensions.Options;

namespace coreTest.Controllers
{
    public class ContentController : Controller
    {
        private readonly List<Content> contents;
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="option"></param>
        public ContentController(IOptions<List<Content>> option)
        {
            contents = option.Value;
        }

        public IActionResult Index()
        {
            //var contents = new List<Content>();
            //for (int i = 1; i < 11; i++)
            //{
            //    contents.Add(new Content { ID = i, title = $"{i}的标题", content = $"{i}的内容", add_time = DateTime.Now.AddDays(-i) });
            //}
            //return View(new ContentViewModel { Contents = contents });
            return View(new ContentViewModel { Contents = contents });
        }
    }
}