Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37082 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbcGQOdZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 10:33:25 -0400
Subject: Re: [PATCH v2 1/1] watchdog: add support for MCP78S chipset in nv_tco
To: Alexey Kunitskiy <alexey.kv@gmail.com>
References: <20160715115334.680ab21a@hades.home>
 <20160716171540.GA29247@roeck-us.net> <20160717101453.4e3e8d2a@hades.home>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578B972E.60209@roeck-us.net>
Date: Sun, 17 Jul 2016 07:33:18 -0700
MIME-Version: 1.0
In-Reply-To: <20160717101453.4e3e8d2a@hades.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/17/2016 12:14 AM, Alexey Kunitskiy wrote:
> On Sat, 16 Jul 2016 10:15:40 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> On Fri, Jul 15, 2016 at 11:53:34AM +0300, Alexey Kunitskiy wrote:
>>> Add support for MCP78S chipset in nv_tco watchdog driver
>>> Patch tested successfully on 4.1.27 kernel and ASUS M4N78-AM V2
>>> motherboard
>>>
>>> Signed-off-by: Aleksey Kunitskiy <alexey.kv@gmail.com>
>>>
>>
>> The patch must be based on an old kernel; the driver was enhanced
>> about a year ago to add support for a different chip. That change is
>> not included in your patch, causing it to fail to apply.
>>
>> Also, your patch does not follow the normal patch format, and thus
>> fails to apply when using "git am", which complains that the
>> to-be-patched file does not exist.
>>
>> Please make sure that the patch applies cleeanly to the latest
>> upstream kernel.
>
> I've just followed guide in kernel doc to generate patch using 'diff -up'. Please find a new one atop of mainline kernel:
>
> diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
> --- a/drivers/watchdog/nv_tco.c
> +++ b/drivers/watchdog/nv_tco.c

That is better. Notice the difference: The file names start with "a/" and "b/".
Your previous patch started with "drivers/", and the file names differed.
In that situation, git doesn't know how to apply the patch.

Can you send it as a clean patch, one that can be applied without editing ?

Thanks,
Guenter

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
> Signed-off-by: Aleksey Kunitskiy <alexey.kv@gmail.com>
>
>>
>> Thanks,
>> Guenter
>>
>>>
>>> -----------------
>>> Regards,
>>> Aleksey Kunitskiy
>>> ---
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-watchdog" in the body of a message to
>>> majordomo@vger.kernel.org More majordomo info at
>>> http://vger.kernel.org/majordomo-info.html
>>>
>>> --- drivers/watchdog/nv_tco.c.orig	2016-07-14
>>> 22:28:15.721583870 +0300 +++ drivers/watchdog/nv_tco.c
>>> 2016-07-14 22:28:48.838310400 +0300 @@ -294,6 +294,8 @@ static
>>> const struct pci_device_id tco_pc PCI_ANY_ID, PCI_ANY_ID, },
>>>   	{ PCI_VENDOR_ID_NVIDIA,
>>> PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS, PCI_ANY_ID, PCI_ANY_ID, },
>>> +	{ PCI_VENDOR_ID_NVIDIA,
>>> PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS,
>>> +	  PCI_ANY_ID, PCI_ANY_ID, },
>>>   	{ 0, },			/* End of list */
>>>   };
>>>   MODULE_DEVICE_TABLE(pci, tco_pci_tbl);
>
>
>
>
> -----------------
> Regards,
> Aleksey Kunitskiy
>

