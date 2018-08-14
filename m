Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44099 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQTC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Aug 2018 12:19:02 -0400
Subject: Re: [PATCH v2 4/5] watchdog: hpwdt: Module paramerter alias.
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-5-git-send-email-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d4e2d7cc-77ea-36c7-ca1d-89803450cf2a@roeck-us.net>
Date: Tue, 14 Aug 2018 06:31:48 -0700
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-5-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> Add module parameter "timeout" as an alias to "soft_margin."
> This aligns hpwdt usage more closely with other WDT while
> retaining backwards compatibility.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 69a88b1..eb947bc 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -367,6 +367,9 @@ static void hpwdt_exit(struct pci_dev *dev)
>   module_param(soft_margin, int, 0);
>   MODULE_PARM_DESC(soft_margin, "Watchdog timeout in seconds");
>   
> +module_param_named(timeout, soft_margin, int, 0);
> +MODULE_PARM_DESC(timeout, "Alias of soft_margin");
> +
>   module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>   		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> 
