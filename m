Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45635 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcGQSou (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 14:44:50 -0400
Subject: Re: [PATCH v2 1/1] watchdog: add support for MCP78S chipset in nv_tco
To: Alexey Kunitskiy <alexey.kv@gmail.com>
References: <20160715115334.680ab21a@hades.home>
 <20160716171540.GA29247@roeck-us.net> <20160717101453.4e3e8d2a@hades.home>
 <578B972E.60209@roeck-us.net> <20160717193424.245516db@hades.home>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578BD21E.9020405@roeck-us.net>
Date: Sun, 17 Jul 2016 11:44:46 -0700
MIME-Version: 1.0
In-Reply-To: <20160717193424.245516db@hades.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/17/2016 09:34 AM, Alexey Kunitskiy wrote:
> Add support for MCP78S chipset in nv_tco watchdog driver
>
> Signed-off-by: Aleksey Kunitskiy <alexey.kv@gmail.com>
>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Note that new patch revisions should never be sent as reply, and that "Regards, ..."
ended up in the description when applying the patch. I'll include the patch in
my pull request to Wim, but please keep in mind that patches may get lost if
sent as reply to previous e-mails.

Thanks,
Guenter

> diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
> --- a/drivers/watchdog/nv_tco.c
> +++ b/drivers/watchdog/nv_tco.c
> @@ -294,6 +294,8 @@
>   	  PCI_ANY_ID, PCI_ANY_ID, },
>   	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS,
>   	  PCI_ANY_ID, PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS,
> +	  PCI_ANY_ID, PCI_ANY_ID, },
>   	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS,
>   	  PCI_ANY_ID, PCI_ANY_ID, },
>   	{ 0, },			/* End of list */
>
>
> -----------------
> Regards,
> Aleksey Kunitskiy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

