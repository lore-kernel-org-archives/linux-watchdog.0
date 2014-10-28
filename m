Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:57814 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750857AbaJ1W6x (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Oct 2014 18:58:53 -0400
Date: Tue, 28 Oct 2014 23:58:46 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	Naveen Krishna <naveenkrishna.ch@gmail.com>
Subject: Re: [PATCH] watchdog: s3c2410_wdt: Fix the mask bit offset for Exynos7
Message-ID: <20141028225846.GA2083@spo001.leaseweb.nl>
References: <1413562373-12734-1-git-send-email-a.kesavan@samsung.com> <CAM4voa=qwp09OJgmyM+YnYMLeAOMEV9R_2QMoLtuGDywrwqOZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM4voa=qwp09OJgmyM+YnYMLeAOMEV9R_2QMoLtuGDywrwqOZA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Abhilash,

> On Fri, Oct 17, 2014 at 9:42 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> > The watchdog mask bit offset listed for Exynos7 is incorrect.
> > Fix this.
> >
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > ---
> >  drivers/watchdog/s3c2410_wdt.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> > index 8532c3e..1626dc6 100644
> > --- a/drivers/watchdog/s3c2410_wdt.c
> > +++ b/drivers/watchdog/s3c2410_wdt.c
> > @@ -161,7 +161,7 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
> >  static const struct s3c2410_wdt_variant drv_data_exynos7 = {
> >         .disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
> >         .mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
> > -       .mask_bit = 0,
> > +       .mask_bit = 23,
> >         .rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
> >         .rst_stat_bit = 23,     /* A57 WDTRESET */
> >         .quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,
> 
> Naveen reviewed and ack'ed this fix. Can it be applied ?

Added to linux-watchdog-next.

Kind regards,
Wim.

