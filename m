Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59717 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbcKNBmW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 13 Nov 2016 20:42:22 -0500
Subject: Re: [PATCH] watchdog: qcom: fix kernel panic due to external abort on
 non-linefetch
To: Christian Lamparter <chunkeey@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20161114011116.26210-1-chunkeey@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Matthew McClintock <mmcclint@codeaurora.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d9d6b6f5-0bef-aa7a-2bb1-92218cff43b3@roeck-us.net>
Date: Sun, 13 Nov 2016 17:42:14 -0800
MIME-Version: 1.0
In-Reply-To: <20161114011116.26210-1-chunkeey@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/13/2016 05:11 PM, Christian Lamparter wrote:
> This patch fixes a off-by-one in the "watchdog: qcom: add option for
> standalone watchdog not in timer block" patch that causes the
> following panic on boot:
>
>> Unhandled fault: external abort on non-linefetch (0x1008) at 0xc8874002
>> pgd = c0204000
>> [c8874002] *pgd=87806811, *pte=0b017653, *ppte=0b017453
>> Internal error: : 1008 [#1] SMP ARM
>> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.8.6 #0
>> Hardware name: Generic DT based system
>> PC is at 0xc02222f4
>> LR is at 0x1
>> pc : [<c02222f4>]    lr : [<00000001>]    psr: 00000113
>> sp : c782fc98  ip : 00000003  fp : 00000000
>> r10: 00000004  r9 : c782e000  r8 : c04ab98c
>> r7 : 00000001  r6 : c8874002  r5 : c782fe00  r4 : 00000002
>> r3 : 00000000  r2 : c782fe00  r1 : 00100000  r0 : c8874002
>> Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 10c5387d  Table: 8020406a  DAC: 00000051
>> Process swapper/0 (pid: 1, stack limit = 0xc782e210)
>> Stack: (0xc782fc98 to 0xc7830000)
>> [...]
>
> The WDT_STS (status) needs to be translated via wdt_addr as well.
>
> fixes: f0d9d0f4b44a ("watchdog: qcom: add option for standalone watchdog not in timer block")
> Cc: stable@vger.kernel.org # 4.8
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/qcom-wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 5796b5d..4f47b5e 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -209,7 +209,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>  	wdt->wdd.parent = &pdev->dev;
>  	wdt->layout = regs;
>
> -	if (readl(wdt->base + WDT_STS) & 1)
> +	if (readl(wdt_addr(wdt, WDT_STS)) & 1)
>  		wdt->wdd.bootstatus = WDIOF_CARDRESET;
>
>  	/*
>

