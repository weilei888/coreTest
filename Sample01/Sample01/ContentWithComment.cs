using System;
using System.Collections.Generic;
using System.Text;

namespace Sample01
{
    public class ContentWithComment
    {
        public int id { get; set; }
        public string title { get; set; }
        public string content { get; set; }
        public int status { get; set; }
        public DateTime add_time { get; set; } = DateTime.Now;
        public DateTime? modify_time { get; set; } //？运算符：可以为null的类型
        public IEnumerable<Comment> comments { get; set; }
    }
}
