Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mo4.mail-out.ovh.net ([178.32.228.4]:55379 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208Ab2JELg1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Oct 2012 07:36:27 -0400
Received: from mail97.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 364D91050521
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Oct 2012 13:25:25 +0200 (CEST)
Date: Fri, 5 Oct 2012 13:16:42 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 1/4] watchdog: core: dt: add support for the
 timeout-sec dt property
Message-ID: <20121005111642.GA12462@game.jcrosoft.org>
References: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
 <1349432169-13006-2-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1349432169-13006-2-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12:16 Fri 05 Oct     , Fabio Porcedda wrote:
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  Documentation/watchdog/watchdog-kernel-api.txt |  4 ++++
>  drivers/watchdog/watchdog_core.c               | 27 ++++++++++++++++++++++++++
>  include/linux/watchdog.h                       |  4 ++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
> index 086638f..2208db7 100644
> --- a/Documentation/watchdog/watchdog-kernel-api.txt
> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> @@ -212,3 +212,7 @@ driver specific data to and a pointer to the data itself.
>  The watchdog_get_drvdata function allows you to retrieve driver specific data.
>  The argument of this function is the watchdog device where you want to retrieve
>  data from. The function returns the pointer to the driver specific data.
> +
> +The watchdog_init_timeout function allows you to initialize the timeout field
> +using the module timeout parameter or retrieving the timeout-sec property from
> +the device tree.
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 3796434..646be48 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -143,6 +143,33 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
>  }
>  EXPORT_SYMBOL_GPL(watchdog_unregister_device);
>  
> +/**
> + * watchdog_init_timeout() - initialize the timeout field
> + * @parm_timeout: timeout module parameter, it takes precedence over the
> + *                timeout-sec property.
> + * @node: Retrieve the timeout-sec property only if the parm_timeout
> + *        is out of bounds.
> + */
> +void watchdog_init_timeout(struct watchdog_device *wdd,
> +			   unsigned int parm_timeout, struct device_node *node)
> +{
> +	unsigned int t = 0;
> +
> +	if ((parm_timeout >= wdd->min_timeout) &&
> +	    (parm_timeout <= wdd->max_timeout)) {
> +		wdd->timeout = parm_timeout;
> +		return;
> +	}
> +
> +	if (!node)
> +		return;
> +
> +	of_property_read_u32(node, "timeout-sec", &t);
why I bother to comment
*make this of generic* this is not watchdog specific other driver can use it

Best Regards,
J.
