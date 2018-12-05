Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46047 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLECsB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Dec 2018 21:48:01 -0500
Subject: Re: [PATCH 1/1] watchdog/hpwdt: Do not claim unsupported hardware
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543976538-75532-1-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bdd17fda-00ca-3c7a-81d7-fc08c8c21164@roeck-us.net>
Date: Tue, 4 Dec 2018 18:47:56 -0800
MIME-Version: 1.0
In-Reply-To: <1543976538-75532-1-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/4/18 6:22 PM, Jerry Hoemann wrote:
> Do not claim when SSID 0x0289 as the watchdog features
> are not enabled/validated by the firmware.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 9356230..b99ef0a4 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -281,6 +281,17 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   	    dev->subsystem_device == 0x1979)
>   		return -ENODEV;
>   
> +	/*
> +	 * Ignore unsupported hardware
> +	 */
> +	if (dev->vendor == PCI_VENDOR_ID_HP &&
> +	    dev->device == 0x3306 &&
> +	    dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR &&
> +	    dev->subsystem_device == 0x0289) {
> +		dev_info(&dev->dev, "Not supported on this platform\n");
> +		return -ENODEV;
> +	}
> +

Please use a pci_device_id table with PCI_DEVICE_SUB() to create
a blacklist, and pci_match_id() to match against it.

Thanks,
Guenter

>   	if (pci_enable_device(dev)) {
>   		dev_warn(&dev->dev,
>   			"Not possible to enable PCI Device: 0x%x:0x%x.\n",
> 
