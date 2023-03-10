USE [master]
GO
/****** Object:  Database [TestTaskBalance]    Script Date: 21.12.2022 19:49:46 ******/
CREATE DATABASE [TestTaskBalance]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestTaskBalance', FILENAME = N'D:\M_SQL_Server\SQL\MSSQL15.MSQL\MSSQL\DATA\TestTaskBalance.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestTaskBalance_log', FILENAME = N'D:\M_SQL_Server\SQL\MSSQL15.MSQL\MSSQL\DATA\TestTaskBalance_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TestTaskBalance] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestTaskBalance].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestTaskBalance] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestTaskBalance] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestTaskBalance] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestTaskBalance] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestTaskBalance] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestTaskBalance] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestTaskBalance] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestTaskBalance] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestTaskBalance] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestTaskBalance] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestTaskBalance] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestTaskBalance] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestTaskBalance] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestTaskBalance] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestTaskBalance] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestTaskBalance] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestTaskBalance] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestTaskBalance] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestTaskBalance] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestTaskBalance] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestTaskBalance] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestTaskBalance] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestTaskBalance] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestTaskBalance] SET  MULTI_USER 
GO
ALTER DATABASE [TestTaskBalance] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestTaskBalance] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestTaskBalance] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestTaskBalance] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestTaskBalance] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestTaskBalance] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TestTaskBalance', N'ON'
GO
ALTER DATABASE [TestTaskBalance] SET QUERY_STORE = OFF
GO
USE [TestTaskBalance]
GO
/****** Object:  Table [dbo].[Billing_types]    Script Date: 21.12.2022 19:49:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Billing_types](
	[type_id] [int] IDENTITY(1,1) NOT NULL,
	[type_title] [varchar](50) NULL,
 CONSTRAINT [PK_Billing_types] PRIMARY KEY CLUSTERED 
(
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Billings]    Script Date: 21.12.2022 19:49:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Billings](
	[billing_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[billing_type] [int] NULL,
	[billing_sum] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Billings] PRIMARY KEY CLUSTERED 
(
	[billing_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_positions]    Script Date: 21.12.2022 19:49:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_positions](
	[position_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[service_id] [int] NULL,
	[order_price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Order_positions] PRIMARY KEY CLUSTERED 
(
	[position_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 21.12.2022 19:49:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[order_cost] [decimal](18, 0) NULL,
	[order_date] [datetime] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 21.12.2022 19:49:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[service_id] [int] IDENTITY(1,1) NOT NULL,
	[service_title] [varchar](max) NULL,
	[service_price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Services] PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 21.12.2022 19:49:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[user_name] [varchar](max) NULL,
	[user_surname] [varchar](max) NULL,
	[user_patronymic] [varchar](max) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Billings]  WITH CHECK ADD  CONSTRAINT [FK_Billings_Billing_types] FOREIGN KEY([billing_type])
REFERENCES [dbo].[Billing_types] ([type_id])
GO
ALTER TABLE [dbo].[Billings] CHECK CONSTRAINT [FK_Billings_Billing_types]
GO
ALTER TABLE [dbo].[Billings]  WITH CHECK ADD  CONSTRAINT [FK_Billings_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Billings] CHECK CONSTRAINT [FK_Billings_Users]
GO
ALTER TABLE [dbo].[Order_positions]  WITH CHECK ADD  CONSTRAINT [FK_Order_positions_Orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[Order_positions] CHECK CONSTRAINT [FK_Order_positions_Orders]
GO
ALTER TABLE [dbo].[Order_positions]  WITH CHECK ADD  CONSTRAINT [FK_Order_positions_Services] FOREIGN KEY([service_id])
REFERENCES [dbo].[Services] ([service_id])
GO
ALTER TABLE [dbo].[Order_positions] CHECK CONSTRAINT [FK_Order_positions_Services]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
USE [master]
GO
ALTER DATABASE [TestTaskBalance] SET  READ_WRITE 
GO
