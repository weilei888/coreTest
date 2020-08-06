using System;
using System.Collections.Generic;
using System.Text;

namespace Sample01
{
    /// <summary>
    /// 实体类
    /// </summary>
    public class Content
    {
        public int id { get; set; }
        public string title { get; set; }
        public string content { get; set; }
        public int status { get; set; }
        public DateTime add_time { get; set; } = DateTime.Now;
        public DateTime? modify_time { get; set; } //？运算符：可以为null的类型
    }
}
