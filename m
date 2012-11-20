Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62341 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab2KTRJX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Nov 2012 12:09:23 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so6136905obb.19
        for <linux-watchdog@vger.kernel.org>; Tue, 20 Nov 2012 09:09:22 -0800 (PST)
Message-ID: <50ABB93F.5070109@gmail.com>
Date: Tue, 20 Nov 2012 11:09:19 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Fabio Porcedda <fabio.porcedda@gmail.com>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v5 1/8] dt: add helper inline for retrieving timeout-sec
 property
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com> <1353334243-16703-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1353334243-16703-2-git-send-email-fabio.porcedda@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/19/2012 08:10 AM, Fabio Porcedda wrote:
> The first user of this function is the watchdog framework.

I still have issues with this. In addition to questionable usefulness
outside the watchdog framework, I'm not even sure this is right for
watchdog framework. Watchdog timeout is not a description of h/w, but
user configuration. I think the existing mechanisms of module param or
kernel cmdline is the right way to handle this.

Rob

> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  include/linux/of.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index b4e50d5..d60fde9 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -477,4 +477,15 @@ static inline int of_property_read_u32(const struct device_node *np,
>  	return of_property_read_u32_array(np, propname, out_value, 1);
>  }
>  
> +/**
> + * of_get_timeout_sec() - Helper to read the timeout_sec property
> + * @np:		device node from which the property value is to be read.
> + * @timeout:	adress of the output value
> + */
> +static inline int of_get_timeout_sec(const struct device_node *np,
> +				     u32 *timeout)
> +{
> +	return of_property_read_u32(np, "timeout-sec", timeout);
> +}
> +
>  #endif /* _LINUX_OF_H */
> 

