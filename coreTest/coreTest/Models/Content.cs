using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace coreTest.Models
{
    /// <summary>
    /// 2020.8.5
    /// 魏磊
    /// 内容实体
    /// </summary>
    public class Content
    {
        /// <summary>
        ///主键 
        /// </summary>
        public int ID { get; set; }
        /// <summary>
        /// 标题
        /// </summary>
        public string title { get; set; }
        /// <summary>
        /// 内容
        /// </summary>
        public string content { get; set; }
        /// <summary>
        /// 状态 1正常 0删除
        /// </summary>
        public int status { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime add_time { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime modify_time { get; set; }
    }
}
