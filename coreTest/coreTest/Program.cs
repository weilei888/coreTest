using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace coreTest
{
    public class Program
    {
        /// <summary>
        /// Main方法，程序的入口方法
        /// </summary>
        /// <param name="args"></param>
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args) //调用下面的方法，返回一个IWebHostBuilder对象
                .Build() //用上面返回的返回一个IWebHostBuilder对象创建一个IWebHost
                .Run(); //运行上面创建的IWebHost对象从而运行我们的web应用程序，换句话说就是启动一个一直运行监听http请求的任务
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args) //使用默认的配置信息来初始化一个新的IWebHostBuilder实例
           //新添加代码
            .ConfigureAppConfiguration((hostingContent, config) =>
            {
                var env = hostingContent.HostingEnvironment;
                config.AddJsonFile("appsetting.json", optional: true, reloadOnChange: true)
                            .AddJsonFile($"appsetting.{env.EnvironmentName}.json", optional: true, reloadOnChange: true)
                            .AddJsonFile("Content.json", optional: false, reloadOnChange: false) //加载自定义的配置文件，reloadOnChange为true则有变化自动重新加载，false则不能重新加载
                            .AddEnvironmentVariables();
            })
            //新添加结束
            .UseStartup<Startup>(); //为WebHost 指定了Startup类
    }
}
