using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using Dapper;

namespace Sample01
{
    class Program
    {
        /// <summary>
        /// 数据库连接字符串
        /// </summary>
        private static readonly string connStr = "Data Source=127.0.0.1;User ID=sa;Password=123456;Initial Catalog=CMS;Max Pool Size=100;";
        //Pooling=false;就是关闭连接池的意思，默认为true，启用连接池：建立新连接时系统会先看里面有没有一样的连接，有就不用了新建了。
        //Inegrated Security=SSPI表示以当前系统用户去登录数据库服务器
        //Initial Catalog与Database一样，都表示要连接的数据库名
        //Data Source与server一样，都表示要连接的数据源
        //user id=uid，password=pwd


        /// <summary>
        /// Dapper的基本用法
        /// </summary>
        /// <param name="args"></param>
        static void Main(string[] args)
        {
            //insert();
            //mult_insert();
            //delete();
            //mult_delete();
            //update();
            //select();
            //mult_select();
            //insertComment();
            select_content_commemt();
            Console.ReadKey();
        }

        /// <summary>
        /// 插入：将一个Content对象插入数据库
        /// </summary>
        static void insert()
        {
            var content = new Content
            {
                title = "标题1",
                content = "内容1",
            };

            using (var conn = new SqlConnection(connStr))
            {
                string sql = @"insert into [Content](title,[content],status,add_time,modify_time)
                                values(@title,@content,@status,@add_time,@modify_time)";
                //@title意思是自动将对象content上的值绑定上去
                var result = conn.Execute(sql, content);//dapper语法，返回值为影响的行数
                Console.WriteLine($"insert:插入了{result}条数据！");
            }
        }

        /// <summary>
        /// 批量插入
        /// </summary>
        static void mult_insert()
        {
            var contents = new List<Content>()
            {
                new Content
                {
                title = "批量插入标题1",
                content = "批量插入内容1",
                },
                new Content
                {
                title = "批量插入标题2",
                content = "批量插入内容3",
                }
            };

            using (var conn = new SqlConnection(connStr))
            {
                string sql = @"insert into [Content](title,[content],status,add_time,modify_time)
                                values(@title,@content,@status,@add_time,@modify_time)";
                //@title意思是自动将对象content上的值绑定上去
                var result = conn.Execute(sql, contents);//dapper语法，返回值为影响的行数
                Console.WriteLine($"mult_insert:插入了{result}条数据！");
            }
        }

        /// <summary>
        /// 删除
        /// </summary>
        static void delete()
        {
            var content = new Content
            {
                id = 2,
            };

            using (var conn = new SqlConnection(connStr))
            {
                string sql = @"delete from [Content] where id=@id";
                //@title意思是自动将对象content上的值绑定上去
                var result = conn.Execute(sql, content);//dapper语法，返回值为影响的行数
                Console.WriteLine($"delete:删除了{result}条数据！");
            }
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        static void mult_delete()
        {
            var contents = new List<Content>()
            {
                new Content
                {
                    id=3,
                },
                new Content
                {
                    id=4,
                }
            };

            using (var conn = new SqlConnection(connStr))
            {
                string sql = @"delete from [Content] where id=@id";
                //@title意思是自动将对象content上的值绑定上去
                var result = conn.Execute(sql, contents);//dapper语法，返回值为影响的行数
                Console.WriteLine($"mult_delete:删除了{result}条数据！");
            }
        }

        /// <summary>
        /// 修改
        /// </summary>
        static void update()
        {
            var content = new Content
            {
                id = 1,
                title = "标题已修改",
                content = "内容已修改",
            };

            using (var conn = new SqlConnection(connStr))
            {
                string sql = @"update [Content] set title=@title,[content]=@content,modify_time=getdate() where id=@id";
                //@title意思是自动将对象content上的值绑定上去
                var result = conn.Execute(sql, content);//dapper语法，返回值为影响的行数
                Console.WriteLine($"update:修改了{result}条数据！");
            }
        }

        /// <summary>
        /// 查询
        /// </summary>
        static void select()
        {
            using (var conn = new SqlConnection(connStr))
            {
                string sql = @"select * from [Content] where id=@id";
                //@title意思是自动将对象content上的值绑定上去
                var result = conn.QueryFirstOrDefault<Content>(sql, new { id = 1 });//dapper语法，返回值为影响的行数
                Console.WriteLine($"select:查询到的数据为：{result}");
            }
        }

        /// <summary>
        /// 批量查询
        /// </summary>
        static void mult_select()
        {
            using (var conn = new SqlConnection(connStr))
            {
                string sql = @"select * from [Content] where id in @ids";
                //@title意思是自动将对象content上的值绑定上去
                var result = conn.QueryFirstOrDefault<Content>(sql, new { ids = new int[] { 1, 2 } });//dapper语法，返回值为影响的行数
                Console.WriteLine($"mult_select:查询到的数据为：{result}");
            }
        }

        /// <summary>
        /// 插入评论
        /// </summary>
        static void insertComment()
        {
            var comment = new Comment
            {
                content_id = 1,
                content = "评论1",
            };

            using (var conn = new SqlConnection(connStr))
            {
                string sql = @"insert into Comment(content_id,[content],add_time)
                                values(@content_id,@content,@add_time)";
                //@title意思是自动将对象content上的值绑定上去
                var result = conn.Execute(sql, comment);//dapper语法，返回值为影响的行数
                Console.WriteLine($"insertComment:插入了{result}条数据！");
            }
        }

        /// <summary>
        /// 综合查询   
        /// </summary>
        static void select_content_commemt()
        {
            using (var conn = new SqlConnection(connStr))
            {
                string sql = @"select * from [Content] where id=@id;
                                    select * from comment where content_id=@id;";
                //@title意思是自动将对象content上的值绑定上去
                using (var result = conn.QueryMultiple(sql, new { id = 1 }))
                {
                    var content = result.ReadFirstOrDefault<ContentWithComment>();
                    content.comments = result.Read<Comment>();
                    Console.WriteLine($"select_content_commemt:内容1的评论数量{content.comments.Count()}");
                }
            }
        }
    }
}
