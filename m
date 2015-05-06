Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 May 2015 11:36:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: change my email address
Message-ID: <20150506093653.GB22949@pd.tnic>
References: <1430892695-18876-1-git-send-email-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1430892695-18876-1-git-send-email-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, May 06, 2015 at 08:11:35AM +0200, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  MAINTAINERS | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 781e099..2943c62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3715,7 +3715,7 @@ S:	Maintained
>  F:	drivers/edac/ie31200_edac.c
>  
>  EDAC-MPC85XX
> -M:	Johannes Thumshirn <johannes.thumshirn@men.de>
> +M:	Johannes Thumshirn <jthumshirn@suse.de>
>  L:	linux-edac@vger.kernel.org
>  W:	bluesmoke.sourceforge.net
>  S:	Maintained
> @@ -6395,14 +6395,14 @@ F:	include/linux/mtd/
>  F:	include/uapi/mtd/
>  
>  MEN A21 WATCHDOG DRIVER
> -M:	Johannes Thumshirn <johannes.thumshirn@men.de>
> +M:	Johannes Thumshirn <jthumshirn@suse.de>
>  L:	linux-watchdog@vger.kernel.org
> -S:	Supported
> +S:	Maintained
>  F:	drivers/watchdog/mena21_wdt.c
>  
>  MEN CHAMELEON BUS (mcb)
> -M:	Johannes Thumshirn <johannes.thumshirn@men.de>
> -S:	Supported
> +M:	Johannes Thumshirn <jthumshirn@suse.de>
> +S:	Maintained
>  F:	drivers/mcb/
>  F:	include/linux/mcb.h

I wouldn't do that.

For the simple reason that company/corporate email addresses change
often and it would cause unnecessary churn and people sending you bug
reports to possibly deleted accounts and so on...

I'd rather use a public email account which is always accessible to you
and which doesn't change, even after you switch jobs.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
