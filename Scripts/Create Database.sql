USE [master]
GO
/****** Object:  Database [Dapper110]    Script Date: 03/04/2020 10:54:10 ******/
CREATE DATABASE [Dapper110]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Dapper110', FILENAME = N'C:\Databases\Dapper110.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Dapper110_log', FILENAME = N'C:\Databases\Dapper110_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Dapper110] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Dapper110].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Dapper110] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Dapper110] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Dapper110] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Dapper110] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Dapper110] SET ARITHABORT OFF 
GO
ALTER DATABASE [Dapper110] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Dapper110] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Dapper110] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Dapper110] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Dapper110] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Dapper110] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Dapper110] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Dapper110] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Dapper110] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Dapper110] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Dapper110] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Dapper110] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Dapper110] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Dapper110] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Dapper110] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Dapper110] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Dapper110] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Dapper110] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Dapper110] SET  MULTI_USER 
GO
ALTER DATABASE [Dapper110] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Dapper110] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Dapper110] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Dapper110] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Dapper110] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Dapper110] SET QUERY_STORE = OFF
GO
USE [Dapper110]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 03/04/2020 10:54:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 03/04/2020 10:54:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Street] [nvarchar](100) NULL,
	[ZipCode] [char](5) NULL,
	[CityId] [int] NULL,
	[Phone] [varchar](20) NULL,
	[ImageUrl] [varchar](1000) NULL,
	[WebSite] [varchar](1000) NULL,
 CONSTRAINT [PK_Restaurants] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 03/04/2020 10:54:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RestaurantId] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[Date] [datetime] NOT NULL,
	[Tags] [nvarchar](max) NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 03/04/2020 10:54:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Email] [varchar](50) NULL,
	[Role] [varchar](100) NULL,
	[Scope] [varchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cities] ON 
GO
INSERT [dbo].[Cities] ([Id], [Name]) VALUES (1, N'Taggia')
GO
INSERT [dbo].[Cities] ([Id], [Name]) VALUES (2, N'Arma di Taggia')
GO
INSERT [dbo].[Cities] ([Id], [Name]) VALUES (3, N'Bussana')
GO
INSERT [dbo].[Cities] ([Id], [Name]) VALUES (4, N'Sanremo')
GO
SET IDENTITY_INSERT [dbo].[Cities] OFF
GO
SET IDENTITY_INSERT [dbo].[Restaurants] ON 
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (1, N'I Portici', N'Via Soleri 14', N'18018', 1, N'0184 462007', N'https://media-cdn.tripadvisor.com/media/photo-s/14/98/89/c6/tavolate-sotto-i-portici.jpg', N'https://www.facebook.com/I-Portici-144037015705203/')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (2, N'Osteria del Cavallo Bianco', N'Via Rimembranza, 4', N'18018', 1, N'0184 460124
', N'https://media-cdn.tripadvisor.com/media/photo-s/09/95/35/ca/20151122-130521-largejpg.jpg', N'https://latopinadellavalleargentina.wordpress.com/2012/12/06/osteria-cavallo-bianco')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (3, N'Ristorante Pizzeria Solidago', N'Traversa I Stazione 24', N'18018', 2, N'0184 43108
', N'http://www.solidagohotel.com/images/sala_1.jpg', N'http://www.solidagohotel.com/')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (4, N'La Conchiglia', N'Via Lungomare 33', N'18018', 2, N'0184 43169
', N'https://scontent-mxp1-1.xx.fbcdn.net/v/t31.0-8/13071688_595137647322043_5443323663269873846_o.jpg?_nc_cat=108&_nc_ohc=ttC_qg3w84MAX9B5xmz&_nc_ht=scontent-mxp1-1.xx&oh=ff31ce457a9c7245661886fa562cafc0&oe=5F005511', N'https://www.facebook.com/RistoranteLaConchigliaArmadiTaggia')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (5, N'Ristorante Pizzeria La Darsena', N'Via Lungomare 213', N'18018', 2, N'0184 43579
', N'https://media-cdn.tripadvisor.com/media/photo-s/0a/b6/67/9d/la-darsena-ac.jpg', N'https://www.facebook.com/pages/category/Pizza-Place/Ristorante-Pizzeria-La-Darsena-Arma-di-Taggia-131118086961579/')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (6, N'Ristorante Castelin', N'Via Roma 9', N'18018', 1, N'0184 475500
', N'https://media-cdn.tripadvisor.com/media/photo-s/0b/84/e1/41/interno-del-bar.jpg', N'https://www.facebook.com/RistoranteCastelin')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (7, N'Ristorante Hotel Roma', N'Via della Cornice 10', N'18018', 2, N'0184 43076
', N'http://www.hotelarma.it/img/h4.jpg', N'http://www.albergoroma-franco.it/')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (8, N'Hostaria la Diligenza', N'Via Al Mare 125', N'18038', 3, N'0184 513022', N'https://media-cdn.tripadvisor.com/media/photo-s/06/6c/f8/bd/sala-interna-con-forno.jpg', N'https://www.facebook.com/Hostaria-della-diligenza-380337258806027/')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (9, N'Ristorante Da Rocco', N'Strada Villetta', N'18038', 4, N'0184 503208', N'https://scontent-mxp1-1.xx.fbcdn.net/v/t1.0-9/75429433_10206158713603682_1345040056091410432_o.jpg?_nc_cat=101&_nc_ohc=2uhhW1-w49UAX-aOfXy&_nc_ht=scontent-mxp1-1.xx&oh=7db4913f97b8146706ddccd493182071&oe=5EC6D67B', N'https://www.facebook.com/pages/Ristorante-Da-Rocco/130870023733965')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (10, N'Ristorante Pizzeria Napoletana', N'Via Cristoforo Colombo 280', N'18018', 2, N'0184 448433
', N'https://media-cdn.tripadvisor.com/media/photo-s/0d/5b/4d/21/da-cassini-a.jpg', N'https://www.tripadvisor.it/Restaurant_Review-g1400557-d2297138-Reviews-Ristorante_Pizzeria_Napoletana-Arma_di_Taggia_Italian_Riviera_Liguria.html')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (11, N'Ristorante Pizzeria Tre Poli', N'Via Privata Rio Masso 41', N'18038', 4, N'0184 660711', N'https://fastly.4sqi.net/img/general/width960/QWG1UW341X2LADW4LDCZMM4KGS2SMFGZJ5DHAEQ0V5YU5EP3.jpg', N'https://www.ristorantetrepoli.it/')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (12, N'Sinfonia Ristorante Pizzeria Live Music', N'Via Biancheri 24', N'18038', 3, N'0184 633590
', N'https://fastly.4sqi.net/img/general/width960/55714239_9UtdfsOBEC0ANkHn08hy9UsN5npWVF0xauFFFGJy6Ww.jpg', N'https://www.facebook.com/sinfoniabussana')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (13, N'Ristorante Pizzeria Punta Mare', N'Via Lungomare 1', N'18018', 2, N'0184 43510', N'https://media-cdn.tripadvisor.com/media/photo-s/01/f3/72/54/caption.jpg', N'https://www.tripadvisor.it/Restaurant_Review-g1400557-d2230335-Reviews-Ristorante_Pizzeria_Punta_Mare-Arma_di_Taggia_Italian_Riviera_Liguria.html')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (14, N'My Dream - Ristorante & Pizzeria', N'Via Lungomare 100', N'18018', 2, N'0184 460234
', N'https://media-cdn.tripadvisor.com/media/photo-s/0b/a7/8f/1e/my-dream-ristorante-pizzeria.jpg', N'https://www.tripadvisor.it/Restaurant_Review-g1400557-d10159661-Reviews-My_Dream_Ristorante_Pizzeria-Arma_di_Taggia_Italian_Riviera_Liguria.html')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Street], [ZipCode], [CityId], [Phone], [ImageUrl], [WebSite]) VALUES (15, N'L''Airone', N'Piazza Eroi Sanremesi 12', N'18038', 4, N'0184 531469', N'https://lh3.googleusercontent.com/p/AF1QipOkVhjtRHeaTwDRyMOuixVUqXLrNkiv4Hx2P-7m=w600-k', N'http://www.ristorantelairone.it/')
GO
SET IDENTITY_INSERT [dbo].[Restaurants] OFF
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 
GO
INSERT [dbo].[Reviews] ([Id], [UserId], [RestaurantId], [Rating], [Comment], [Date], [Tags]) VALUES (1, 1, 5, 5, N'La migliore pizzeria di Arma', CAST(N'2020-01-06T00:00:00.000' AS DateTime), N'[{ "Value": "#food"}, {"Value": "#dinner"}]')
GO
INSERT [dbo].[Reviews] ([Id], [UserId], [RestaurantId], [Rating], [Comment], [Date], [Tags]) VALUES (2, 2, 5, 3, N'Pizza buona, ma tempi di attesa parecchio lunghi', CAST(N'2020-01-02T00:00:00.000' AS DateTime), N'[{ "Value": "#pizza"}, {"Value": "#slurp"}, {"Value": "#waiting"}]')
GO
INSERT [dbo].[Reviews] ([Id], [UserId], [RestaurantId], [Rating], [Comment], [Date], [Tags]) VALUES (3, 6, 12, 1, N'Odio la musica mentre mangio. Il volume è talmente alto che non si riesce neanche a parlare con le persone vicine', CAST(N'2020-01-11T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Reviews] ([Id], [UserId], [RestaurantId], [Rating], [Comment], [Date], [Tags]) VALUES (4, 8, 15, 4, N'Buona pizza', CAST(N'2020-01-25T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Reviews] ([Id], [UserId], [RestaurantId], [Rating], [Comment], [Date], [Tags]) VALUES (5, 6, 11, 5, N'Il miglior ristorante della zona per chi ama le rostelle', CAST(N'2020-01-02T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Reviews] ([Id], [UserId], [RestaurantId], [Rating], [Comment], [Date], [Tags]) VALUES (6, 4, 4, 2, N'Una volta questo era un ristorante stellato. Ora è solo caro', CAST(N'2020-02-04T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Reviews] ([Id], [UserId], [RestaurantId], [Rating], [Comment], [Date], [Tags]) VALUES (7, 3, 5, 4, N'Buona cena a base di pesce', CAST(N'2020-02-11T00:00:00.000' AS DateTime), N'[{ "Value": "#fishfood"}, {"Value": "#dinner"}]')
GO
INSERT [dbo].[Reviews] ([Id], [UserId], [RestaurantId], [Rating], [Comment], [Date], [Tags]) VALUES (8, 5, 5, 5, N'C''è solo la Darsena', CAST(N'2020-02-10T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Reviews] ([Id], [UserId], [RestaurantId], [Rating], [Comment], [Date], [Tags]) VALUES (2002, 7, 11, 4, N'Ci vado da anni, la qualità è sempre altissima e il personale è molto cortese', CAST(N'2020-02-12T00:00:00.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [Name], [Email], [Role]) VALUES (1, N'Marco', N'marco.minerva@gmail.com', N'Administrator', 'RW')
GO
INSERT [dbo].[Users] ([Id], [Name], [Email], [Role]) VALUES (2, N'Andrea', NULL, N'User', 'R')
GO
INSERT [dbo].[Users] ([Id], [Name], [Email], [Role]) VALUES (3, N'Riccardo', NULL, N'User', 'R')
GO
INSERT [dbo].[Users] ([Id], [Name], [Email], [Role]) VALUES (4, N'Giuseppe', NULL, N'Reviewer', 'W')
GO
INSERT [dbo].[Users] ([Id], [Name], [Email], [Role]) VALUES (5, N'Michela', NULL, N'Contributor', 'W')
GO
INSERT [dbo].[Users] ([Id], [Name], [Email], [Role]) VALUES (6, N'Chiara', N'kikka@gmail.com', N'Reviewer', 'C')
GO
INSERT [dbo].[Users] ([Id], [Name], [Email], [Role]) VALUES (7, N'Adele', NULL, N'User, Reviewer', 'UNK')
GO
INSERT [dbo].[Users] ([Id], [Name], [Email], [Role]) VALUES (8, N'Luca', N'luca.rossi76@email.it', N'10', 'RW')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Restaurants]  WITH CHECK ADD  CONSTRAINT [FK_Restaurants_Cities] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Restaurants] CHECK CONSTRAINT [FK_Restaurants_Cities]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Restaurants] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurants] ([Id])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Restaurants]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Users]
GO
/****** Object:  StoredProcedure [dbo].[AddRestaurant]    Script Date: 03/04/2020 10:54:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddRestaurant]
	-- Add the parameters for the stored procedure here
	@name nvarchar(100), @street nvarchar(100) = NULL,
	@zipCode char(5) = NULL, @cityId int = NULL,
	@phone varchar(20) = NULL, @imageUrl varchar(1000) = NULL,
	@webSite varchar(1000) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO Restaurants(Name, Street, ZipCode, CityId, Phone, ImageUrl, WebSite)
		VALUES(@name, @street, @zipCode, @cityId, @phone, @imageUrl, @webSite)

	RETURN SCOPE_IDENTITY()
END
GO
USE [master]
GO
ALTER DATABASE [Dapper110] SET  READ_WRITE 
GO
