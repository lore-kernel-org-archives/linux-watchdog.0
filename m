Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47954 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdKEPNg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 5 Nov 2017 10:13:36 -0500
Date: Sun, 5 Nov 2017 07:13:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: watchdog: wdt_pci: mark expected switch fall-through
Message-ID: <20171105151335.GA27113@roeck-us.net>
References: <20171103230723.GA5105@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103230723.GA5105@embeddedor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 03, 2017 at 06:07:23PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wdt_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
> index bc7addc..10e2cda0 100644
> --- a/drivers/watchdog/wdt_pci.c
> +++ b/drivers/watchdog/wdt_pci.c
> @@ -430,7 +430,7 @@ static long wdtpci_ioctl(struct file *file, unsigned int cmd,
>  		if (wdtpci_set_heartbeat(new_heartbeat))
>  			return -EINVAL;
>  		wdtpci_ping();
> -		/* Fall */
> +		/* fall through */
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(heartbeat, p);
>  	default:
