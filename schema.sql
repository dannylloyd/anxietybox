USE [AnxietyBox]
GO
/****** Object:  Table [dbo].[accounts]    Script Date: 3/29/2016 9:15:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[accounts](
	[created_time] [datetime] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[count] [int] NOT NULL,
	[confirm] [uniqueidentifier] NOT NULL,
	[active] [bit] NOT NULL,
 CONSTRAINT [PK_accounts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[anxieties]    Script Date: 3/29/2016 9:15:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[anxieties](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NOT NULL,
	[tracker] [uniqueidentifier] NOT NULL,
	[description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_anxieties] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[replies]    Script Date: 3/29/2016 9:15:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[replies](
	[created_time] [datetime] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NOT NULL,
	[anxiety_id] [int] NOT NULL,
	[description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_replies] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[accounts] ADD  CONSTRAINT [DF_accounts_created_time]  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[accounts] ADD  CONSTRAINT [DF_accounts_count]  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[accounts] ADD  CONSTRAINT [DF_accounts_confirm2]  DEFAULT (newid()) FOR [confirm]
GO
ALTER TABLE [dbo].[accounts] ADD  CONSTRAINT [DF_accounts_active]  DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [dbo].[anxieties] ADD  CONSTRAINT [DF_anxieties_tracker]  DEFAULT (newid()) FOR [tracker]
GO
ALTER TABLE [dbo].[replies] ADD  CONSTRAINT [DF_replies_created_time]  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[anxieties]  WITH CHECK ADD  CONSTRAINT [FK_anxieties_accounts] FOREIGN KEY([account_id])
REFERENCES [dbo].[accounts] ([id])
GO
ALTER TABLE [dbo].[anxieties] CHECK CONSTRAINT [FK_anxieties_accounts]
GO
ALTER TABLE [dbo].[replies]  WITH CHECK ADD  CONSTRAINT [FK_replies_accounts] FOREIGN KEY([account_id])
REFERENCES [dbo].[accounts] ([id])
GO
ALTER TABLE [dbo].[replies] CHECK CONSTRAINT [FK_replies_accounts]
GO
ALTER TABLE [dbo].[replies]  WITH CHECK ADD  CONSTRAINT [FK_replies_anxieties] FOREIGN KEY([anxiety_id])
REFERENCES [dbo].[anxieties] ([id])
GO
ALTER TABLE [dbo].[replies] CHECK CONSTRAINT [FK_replies_anxieties]
GO
