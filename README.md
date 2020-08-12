# Core学习项目：内容管理系统
## 1、Sample01：Dapper快速入门，控制台应用程序，内容及评论的增删改查
Dapper.NET下的一个轻量级ORM框架，属于半自动的，其实体类需要自己写。

## 2、PDM文件夹是数据库设计软件PowerDesigner
coreTest.cmd是概念模型：产品方能看懂  
coreTest.lmd是逻辑模型：程序员能看懂  
coreTest.pmd是物理模型：计算机能看懂  
方式一：先建立cdm的实体和关系，然后生成pdm，修改外键code，然后生成lpd，最后生成sql.sql  
方式二：先建立ldm，再生成pdm，最后生成sql.sql  

## 3、coreTest项目源码
### 开发工具：使用VS2017进行NET Core的开发
### 数据库工具：SqlServer2008r2
### 数据库设计工具：PowerDesigner
### 源码管理工具：git
### 技术栈：ASP.NET Core 2.1+...未完待续
### [源代码下载地址](https://github.com/weilei888/coreTest)

## 4、开发框架
1、UI：用户UI层，用户界面，包含前台网站和后台  
2、Application：提供对用户界面的接口访问，起到用户界面跟数据库操作解耦的作用  
3、Repository：仓储层，跟数据库的交互  
4、Entity：实体对象层，感觉有点多余，因为实际页面中需要的数据跟数据库中的数据并不完全一致，而页面中包含了更多的信息，
		那我们怎么往视图传数据呢，这就有了ViewModel的概念，定义一个ViewModel包含了实际页面需要的所有数据。  
5、Infrastructure：基础设施层，代码的核心层，实现了通用的方法：比如帮助类、对字符串的一些扩展、序列化与反序列化、HTTP请求、过滤器、日志功能、中间件的扩展等  
6、Test：测试层，包含了单元测试及集成测试

## 4、git使用命令
git add .：添加暂存区所有修改的文档  
git add Sample01/ ：添加新文件夹到暂存区  
git add 1.cs：添加新文件或者修改文件到暂存区  
git status：查看本地仓库状态：红色部分表示已经修改，绿色标书已经添加到了暂存区  
git commit -m "修改提示"：把暂存区的代码提交到本地仓库  
git status：再次查看状态  
git push coreTest master：把本地代码提交到远程仓库的默认master分支  
git push coreTest Sample01：把本地代码提交到远程仓库的默认Sample01分支，如没有自动创建  
git checkout -b Sample02：本地仓库上创建并切换到Sample02分支  
git checkout master：切换本地分支  




