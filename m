Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55502 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084Ab2JJO3y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Oct 2012 10:29:54 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so524900obb.19
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Oct 2012 07:29:53 -0700 (PDT)
Message-ID: <5075865C.3010606@gmail.com>
Date: Wed, 10 Oct 2012 09:29:48 -0500
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
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH v4 1/8] dt: add helper inline for retrieving timeout-sec
 property
References: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com> <1349784251-28261-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349784251-28261-2-git-send-email-fabio.porcedda@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/09/2012 07:04 AM, Fabio Porcedda wrote:
> The first user of this function is the watchdog framework.

Who is the 2nd user because I don't see any others. I don't see this
being a widely used property.

Rob

> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  include/linux/of.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 72843b7..5870818 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -470,4 +470,15 @@ static inline int of_property_read_u32(const struct device_node *np,
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

