Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33368 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbcIIE2d (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Sep 2016 00:28:33 -0400
Subject: Re: [PATCH 1/2] watchdog: tegra: constify watchdog_ops structures
To: Julia Lawall <Julia.Lawall@lip6.fr>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1472751326-22897-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472751326-22897-2-git-send-email-Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <99bd0133-90f8-8a9e-9046-cd771af8430b@roeck-us.net>
Date: Thu, 8 Sep 2016 21:28:28 -0700
MIME-Version: 1.0
In-Reply-To: <1472751326-22897-2-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/01/2016 10:35 AM, Julia Lawall wrote:
> Check for watchdog_ops structures that are only stored in the ops field of
> a watchdog_device structure.  This field is declared const, so watchdog_ops
> structures that have this property can be declared as const also.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_ops i@p = { ... };
>
> @ok@
> identifier r.i;
> struct watchdog_device e;
> position p;
> @@
> e.ops = &i@p;
>
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct watchdog_ops e;
> @@
> e@i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct watchdog_ops i = { ... };
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/tegra_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
> index 9ec5760..2d53c3f 100644
> --- a/drivers/watchdog/tegra_wdt.c
> +++ b/drivers/watchdog/tegra_wdt.c
> @@ -178,7 +178,7 @@ static const struct watchdog_info tegra_wdt_info = {
>  	.identity	= "Tegra Watchdog",
>  };
>
> -static struct watchdog_ops tegra_wdt_ops = {
> +static const struct watchdog_ops tegra_wdt_ops = {
>  	.owner = THIS_MODULE,
>  	.start = tegra_wdt_start,
>  	.stop = tegra_wdt_stop,
>
>

