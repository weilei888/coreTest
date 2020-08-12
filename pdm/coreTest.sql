/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2020/8/11 星期二 11:40:57                       */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Article') and o.name = 'FK_ARTICLE_ARTICLECA_ARTICLEC')
alter table Article
   drop constraint FK_ARTICLE_ARTICLECA_ARTICLEC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Manager') and o.name = 'FK_MANAGER_MANAGERRO_MANAGERR')
alter table Manager
   drop constraint FK_MANAGER_MANAGERRO_MANAGERR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ManagerLog') and o.name = 'FK_MANAGERL_MANAGERLO_MANAGER')
alter table ManagerLog
   drop constraint FK_MANAGERL_MANAGERLO_MANAGER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RolePemission') and o.name = 'FK_ROLEPEMI_MENUROLER_MENU')
alter table RolePemission
   drop constraint FK_ROLEPEMI_MENUROLER_MENU
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RolePemission') and o.name = 'FK_ROLEPEMI_ROLEPESSI_MANAGERR')
alter table RolePemission
   drop constraint FK_ROLEPEMI_ROLEPESSI_MANAGERR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Article')
            and   name  = 'ArticleCategoryRelationship_FK'
            and   indid > 0
            and   indid < 255)
   drop index Article.ArticleCategoryRelationship_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Article')
            and   type = 'U')
   drop table Article
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ArticleCategory')
            and   type = 'U')
   drop table ArticleCategory
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Manager')
            and   name  = 'ManagerRoleRelationship_FK'
            and   indid > 0
            and   indid < 255)
   drop index Manager.ManagerRoleRelationship_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Manager')
            and   type = 'U')
   drop table Manager
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ManagerLog')
            and   name  = 'ManagerLogRelationship_FK'
            and   indid > 0
            and   indid < 255)
   drop index ManagerLog.ManagerLogRelationship_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ManagerLog')
            and   type = 'U')
   drop table ManagerLog
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ManagerRole')
            and   type = 'U')
   drop table ManagerRole
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Menu')
            and   type = 'U')
   drop table Menu
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RolePemission')
            and   name  = 'RolePessionRelationship_FK'
            and   indid > 0
            and   indid < 255)
   drop index RolePemission.RolePessionRelationship_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RolePemission')
            and   name  = 'MenuRoleRelationship_FK'
            and   indid > 0
            and   indid < 255)
   drop index RolePemission.MenuRoleRelationship_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RolePemission')
            and   type = 'U')
   drop table RolePemission
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TaskInfo')
            and   type = 'U')
   drop table TaskInfo
go

/*==============================================================*/
/* Table: Article                                               */
/*==============================================================*/
create table Article (
   ID                   int                  not null,
   CategoryID           int                  not null,
   Title                varchar(128)         not null,
   ImageUrl             varchar(Max)         null,
   Content              text                 null,
   ViewCount            int                  not null,
   Sort                 int                  not null,
   Author               varchar(50)          null,
   Source               varchar(128)         null,
   SeoTitle             varchar(Max)         null,
   SeoKeyword           varchar(128)         null,
   SeoDescription       varchar(Max)         null,
   AddManagerID         int                  not null,
   AddTime              datetime             not null,
   ModifyManagerID      int                  null,
   ModifyTime           datetime             null,
   IsTop                bit                  not null,
   IsSlide              bit                  not null,
   IsRed                bit                  not null,
   IsPublish            bit                  not null,
   IsDeleted            bit                  not null,
   constraint PK_ARTICLE primary key nonclustered (ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Article') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Article' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '文章', 
   'user', @CurrentUser, 'table', 'Article'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'Article', 'column', 'ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'CategoryID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'CategoryID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分类ID',
   'user', @CurrentUser, 'table', 'Article', 'column', 'CategoryID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Title')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'Title'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分类标题',
   'user', @CurrentUser, 'table', 'Article', 'column', 'Title'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ImageUrl')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'ImageUrl'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '图片地址',
   'user', @CurrentUser, 'table', 'Article', 'column', 'ImageUrl'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Content')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'Content'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '文章内容',
   'user', @CurrentUser, 'table', 'Article', 'column', 'Content'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ViewCount')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'ViewCount'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '浏览次数',
   'user', @CurrentUser, 'table', 'Article', 'column', 'ViewCount'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Sort')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'Sort'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序数字',
   'user', @CurrentUser, 'table', 'Article', 'column', 'Sort'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Author')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'Author'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '作者',
   'user', @CurrentUser, 'table', 'Article', 'column', 'Author'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Source')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'Source'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '来源',
   'user', @CurrentUser, 'table', 'Article', 'column', 'Source'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'SeoTitle')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'SeoTitle'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'SEO标题',
   'user', @CurrentUser, 'table', 'Article', 'column', 'SeoTitle'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'SeoKeyword')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'SeoKeyword'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'SEO关键字',
   'user', @CurrentUser, 'table', 'Article', 'column', 'SeoKeyword'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'SeoDescription')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'SeoDescription'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'SEO描述',
   'user', @CurrentUser, 'table', 'Article', 'column', 'SeoDescription'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'AddManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加人',
   'user', @CurrentUser, 'table', 'Article', 'column', 'AddManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'AddTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加时间',
   'user', @CurrentUser, 'table', 'Article', 'column', 'AddTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModifyManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'ModifyManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改人',
   'user', @CurrentUser, 'table', 'Article', 'column', 'ModifyManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModifyTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'ModifyTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'Article', 'column', 'ModifyTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsTop')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsTop'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否置顶',
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsTop'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsSlide')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsSlide'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否轮播显示',
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsSlide'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsRed')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsRed'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否热门',
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsRed'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsPublish')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsPublish'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否发布',
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsPublish'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Article')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsDeleted')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsDeleted'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'Article', 'column', 'IsDeleted'
go

/*==============================================================*/
/* Index: ArticleCategoryRelationship_FK                        */
/*==============================================================*/
create index ArticleCategoryRelationship_FK on Article (
CategoryID ASC
)
go

/*==============================================================*/
/* Table: ArticleCategory                                       */
/*==============================================================*/
create table ArticleCategory (
   ID                   int                  not null,
   Title                varchar(128)         not null,
   ParentID             int                  not null,
   ClassList            varchar(256)         null,
   ClassLayer           int                  null,
   Sort                 int                  not null,
   ImageUrl             varchar(256)         null,
   SeoTitle             varchar(256)         null,
   SeoKeywords          varchar(256)         null,
   SeoDescription       varchar(Max)         null,
   IsDeleted            bit                  not null,
   constraint PK_ARTICLECATEGORY primary key nonclustered (ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('ArticleCategory') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'ArticleCategory' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '文章分类', 
   'user', @CurrentUser, 'table', 'ArticleCategory'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Title')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'Title'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分类标题',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'Title'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ParentID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ParentID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '父菜单ID',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ParentID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ClassList')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ClassList'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '类别ID列表（逗号隔开）',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ClassList'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ClassLayer')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ClassLayer'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '类别深度',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ClassLayer'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Sort')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'Sort'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序数字',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'Sort'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ImageUrl')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ImageUrl'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分类图标',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'ImageUrl'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'SeoTitle')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'SeoTitle'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分类SEO标题',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'SeoTitle'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'SeoKeywords')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'SeoKeywords'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分类SEO关键字',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'SeoKeywords'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'SeoDescription')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'SeoDescription'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'SEO描述',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'SeoDescription'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ArticleCategory')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsDeleted')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'IsDeleted'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'ArticleCategory', 'column', 'IsDeleted'
go

/*==============================================================*/
/* Table: Manager                                               */
/*==============================================================*/
create table Manager (
   ID                   int                  not null,
   RoleID               int                  not null,
   UserName             varchar(50)          not null,
   Password             varchar(50)          not null,
   Avatar               varchar(Max)         null,
   NickName             varchar(50)          null,
   Mobile               varchar(11)          null,
   Email                varchar(128)         null,
   LoginCount           int                  null,
   LoginLastIp          varchar(64)          null,
   LoginLastTime        datetime             null,
   AddManagerID         int                  not null,
   AddTime              datetime             not null,
   ModifyManagerID      int                  null,
   ModifyTime           datetime             null,
   IsLock               bit                  not null,
   IsDelete             bit                  not null,
   Remark               varchar(Max)         null,
   constraint PK_MANAGER primary key nonclustered (ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Manager') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Manager' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '后台管理员', 
   'user', @CurrentUser, 'table', 'Manager'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'RoleID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'RoleID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色ID',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'RoleID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'UserName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'UserName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户名',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'UserName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Password')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Password'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '密码',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Password'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Avatar')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Avatar'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '头像',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Avatar'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'NickName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'NickName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户昵称',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'NickName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Mobile')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Mobile'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '手机号码',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Mobile'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Email')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Email'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '邮箱',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Email'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'LoginCount')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'LoginCount'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '登录次数',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'LoginCount'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'LoginLastIp')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'LoginLastIp'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '最后一次登录IP',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'LoginLastIp'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'LoginLastTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'LoginLastTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '最后一次登录时间',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'LoginLastTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'AddManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加人',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'AddManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'AddTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加时间',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'AddTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModifyManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'ModifyManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改人',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'ModifyManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModifyTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'ModifyTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'ModifyTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsLock')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'IsLock'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否锁定',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'IsLock'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsDelete')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'IsDelete'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'IsDelete'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Manager')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Remark')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Remark'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', @CurrentUser, 'table', 'Manager', 'column', 'Remark'
go

/*==============================================================*/
/* Index: ManagerRoleRelationship_FK                            */
/*==============================================================*/
create index ManagerRoleRelationship_FK on Manager (
RoleID ASC
)
go

/*==============================================================*/
/* Table: ManagerLog                                            */
/*==============================================================*/
create table ManagerLog (
   ID                   int                  not null,
   ActionType           varchar(50)          null,
   AddManagerID         int                  not null,
   AddManagerNickName   varchar(50)          null,
   AddTime              datetime             not null,
   AddIp                varchar(50)          null,
   Remark               varchar(Max)         null,
   constraint PK_MANAGERLOG primary key nonclustered (ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('ManagerLog') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'ManagerLog' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '操作日志', 
   'user', @CurrentUser, 'table', 'ManagerLog'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerLog')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerLog')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ActionType')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'ActionType'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作类型',
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'ActionType'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerLog')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'AddManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作人',
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'AddManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerLog')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddManagerNickName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'AddManagerNickName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作人昵称',
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'AddManagerNickName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerLog')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'AddTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加时间',
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'AddTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerLog')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddIp')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'AddIp'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作IP',
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'AddIp'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerLog')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Remark')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'Remark'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', @CurrentUser, 'table', 'ManagerLog', 'column', 'Remark'
go

/*==============================================================*/
/* Index: ManagerLogRelationship_FK                             */
/*==============================================================*/
create index ManagerLogRelationship_FK on ManagerLog (
AddManagerID ASC
)
go

/*==============================================================*/
/* Table: ManagerRole                                           */
/*==============================================================*/
create table ManagerRole (
   ID                   int                  not null,
   RoleName             varchar(100)         not null,
   RoleType             int                  not null,
   isSystem             bit                  not null,
   AddManagerID         int                  not null,
   AddTime              datetime             not null,
   ModifyManagerID      int                  null,
   MadifyTime           datetime             null,
   IsDelete             bit                  null,
   Remark               varchar(Max)         not null,
   constraint PK_MANAGERROLE primary key nonclustered (ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('ManagerRole') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'ManagerRole' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '角色表', 
   'user', @CurrentUser, 'table', 'ManagerRole'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'RoleName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'RoleName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色名称',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'RoleName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'RoleType')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'RoleType'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色类型',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'RoleType'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'isSystem')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'isSystem'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否系统默认',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'isSystem'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'AddManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加人',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'AddManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'AddTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加时间',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'AddTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModifyManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'ModifyManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改人',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'ModifyManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'MadifyTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'MadifyTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'MadifyTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsDelete')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'IsDelete'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'IsDelete'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('ManagerRole')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Remark')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'Remark'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', @CurrentUser, 'table', 'ManagerRole', 'column', 'Remark'
go

/*==============================================================*/
/* Table: Menu                                                  */
/*==============================================================*/
create table Menu (
   ID                   int                  not null,
   ParentID             int                  not null,
   Name                 varchar(50)          not null,
   DisplayName          varchar(100)         null,
   IconUrl              varchar(256)         null,
   LinkUrl              varchar(256)         null,
   Sort                 int                  null,
   Pemission            varchar(256)         null,
   IsDisplay            bit                  not null,
   IsSystem             bit                  not null,
   AddManagerID         int                  not null,
   AddTime              datetime             not null,
   ModifyManagerID      int                  null,
   ModifyTime           datetime             null,
   IsDelete             bit                  not null,
   constraint PK_MENU primary key nonclustered (ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Menu') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Menu' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '菜单表', 
   'user', @CurrentUser, 'table', 'Menu'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ParentID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'ParentID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '父菜单ID',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'ParentID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '名称',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'DisplayName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'DisplayName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '显示名称',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'DisplayName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IconUrl')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'IconUrl'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '图标地址',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'IconUrl'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'LinkUrl')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'LinkUrl'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '链接地址',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'LinkUrl'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Sort')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'Sort'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序数字',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'Sort'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Pemission')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'Pemission'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作权限（按钮权限使用）',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'Pemission'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsDisplay')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'IsDisplay'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否显示',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'IsDisplay'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsSystem')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'IsSystem'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否系统默认',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'IsSystem'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'AddManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加人',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'AddManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'AddTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加时间',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'AddTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModifyManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'ModifyManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改人',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'ModifyManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ModifyTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'ModifyTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'ModifyTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Menu')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsDelete')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Menu', 'column', 'IsDelete'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'Menu', 'column', 'IsDelete'
go

/*==============================================================*/
/* Table: RolePemission                                         */
/*==============================================================*/
create table RolePemission (
   ID                   int                  not null,
   RoleID               int                  not null,
   MenuID               int                  not null,
   Pemission            varchar(Max)         null,
   constraint PK_ROLEPEMISSION primary key nonclustered (ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('RolePemission') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'RolePemission' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '角色权限表', 
   'user', @CurrentUser, 'table', 'RolePemission'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('RolePemission')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'RolePemission', 'column', 'ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'RolePemission', 'column', 'ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('RolePemission')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'RoleID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'RolePemission', 'column', 'RoleID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色ID',
   'user', @CurrentUser, 'table', 'RolePemission', 'column', 'RoleID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('RolePemission')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'MenuID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'RolePemission', 'column', 'MenuID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '权限ID',
   'user', @CurrentUser, 'table', 'RolePemission', 'column', 'MenuID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('RolePemission')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Pemission')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'RolePemission', 'column', 'Pemission'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作类型（功能权限）',
   'user', @CurrentUser, 'table', 'RolePemission', 'column', 'Pemission'
go

/*==============================================================*/
/* Index: MenuRoleRelationship_FK                               */
/*==============================================================*/
create index MenuRoleRelationship_FK on RolePemission (
MenuID ASC
)
go

/*==============================================================*/
/* Index: RolePessionRelationship_FK                            */
/*==============================================================*/
create index RolePessionRelationship_FK on RolePemission (
RoleID ASC
)
go

/*==============================================================*/
/* Table: TaskInfo                                              */
/*==============================================================*/
create table TaskInfo (
   ID                   int                  not null,
   Name                 varchar(128)         not null,
   "Group"              varchar(128)         not null,
   Deccription          varchar(Max)         null,
   Assembly             varchar(Max)         not null,
   ClassName            varchar(Max)         not null,
   Status               int                  not null,
   Cron                 varchar(128)         not null,
   StartTime            datetime             null,
   EndTime              datetime             null,
   NextTime             datetime             null,
   AddTime              datetime             null,
   AddManagerID         int                  not null,
   IsDeleted            bit                  not null,
   constraint PK_TASKINFO primary key nonclustered (ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('TaskInfo') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'TaskInfo' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '定时任务', 
   'user', @CurrentUser, 'table', 'TaskInfo'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '名称',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Group')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Group'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '分组',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Group'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Deccription')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Deccription'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '描述',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Deccription'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Assembly')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Assembly'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '程序集',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Assembly'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ClassName')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'ClassName'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '完整类名',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'ClassName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Status')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Status'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '任务状态',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Status'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Cron')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Cron'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Cron表达式',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'Cron'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'StartTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'StartTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '开始时间',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'StartTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'EndTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'EndTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '结束时间',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'EndTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'NextTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'NextTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '下次运行时间',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'NextTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddTime')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'AddTime'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加时间',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'AddTime'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'AddManagerID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'AddManagerID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '添加人',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'AddManagerID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('TaskInfo')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsDeleted')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'IsDeleted'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'TaskInfo', 'column', 'IsDeleted'
go

alter table Article
   add constraint FK_ARTICLE_ARTICLECA_ARTICLEC foreign key (CategoryID)
      references ArticleCategory (ID)
go

alter table Manager
   add constraint FK_MANAGER_MANAGERRO_MANAGERR foreign key (RoleID)
      references ManagerRole (ID)
go

alter table ManagerLog
   add constraint FK_MANAGERL_MANAGERLO_MANAGER foreign key (AddManagerID)
      references Manager (ID)
go

alter table RolePemission
   add constraint FK_ROLEPEMI_MENUROLER_MENU foreign key (MenuID)
      references Menu (ID)
go

alter table RolePemission
   add constraint FK_ROLEPEMI_ROLEPESSI_MANAGERR foreign key (RoleID)
      references ManagerRole (ID)
go

