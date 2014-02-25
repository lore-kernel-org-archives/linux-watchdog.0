Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24523 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbaBYUKy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Feb 2014 15:10:54 -0500
Date: Tue, 25 Feb 2014 15:10:51 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND] watchdog: orion_wdt: Use %pa to print
 'phys_addr_t'
Message-ID: <20140225201051.GB1872@titan.lakedaemon.net>
References: <1393345053-16964-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393345053-16964-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fabio,

Thanks for the resend.

On Tue, Feb 25, 2014 at 01:17:33PM -0300, Fabio Estevam wrote:
> When building an ARM multi_v7_defconfig with LPAE option selected we get the
> following build warning:
> 
> drivers/watchdog/orion_wdt.c:272:2: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'phys_addr_t' [-Wformat=]
> 
> Fix it by using %pa to print 'phys_addr_t'.
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Acked-by: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/watchdog/orion_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/watchdog.

thx,

Jason.
