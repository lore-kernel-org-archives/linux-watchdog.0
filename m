Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:39663 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbaJTNmB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Oct 2014 09:42:01 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so3585951qcz.23
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Oct 2014 06:41:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <544158B7.5090000@roeck-us.net>
References: <1413562373-12734-1-git-send-email-a.kesavan@samsung.com> <544158B7.5090000@roeck-us.net>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Mon, 20 Oct 2014 19:11:39 +0530
Message-ID: <CAHfPSqDctPDGsXQ3PUBPv_c+UCtEut-DGVmN0AtY1kb13vFzwg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: s3c2410_wdt: Fix the mask bit offset for Exynos7
To: Guenter Roeck <linux@roeck-us.net>
Cc: Abhilash Kesavan <a.kesavan@samsung.com>,
	linux-watchdog@vger.kernel.org, wim@iguana.be,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Guenter,

On 17 October 2014 23:28, Guenter Roeck <linux@roeck-us.net> wrote:
> On 10/17/2014 09:12 AM, Abhilash Kesavan wrote:
>>
>> The watchdog mask bit offset listed for Exynos7 is incorrect.
>> Fix this.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>   drivers/watchdog/s3c2410_wdt.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/s3c2410_wdt.c
>> b/drivers/watchdog/s3c2410_wdt.c
>> index 8532c3e..1626dc6 100644
>> --- a/drivers/watchdog/s3c2410_wdt.c
>> +++ b/drivers/watchdog/s3c2410_wdt.c
>> @@ -161,7 +161,7 @@ static const struct s3c2410_wdt_variant
>> drv_data_exynos5420 = {
>>   static const struct s3c2410_wdt_variant drv_data_exynos7 = {
>>         .disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
>>         .mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
>> -       .mask_bit = 0,
>> +       .mask_bit = 23,
>>         .rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
>>         .rst_stat_bit = 23,     /* A57 WDTRESET */
>>         .quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,
>>
>
> Naveen, can you confirm / Ack ?

Sorry for the delay.

Acked-by: Naveen Krishna Chatradhi <naveenkrishna.ch@gmail.com

>
> Thanks,
> Guenter
>



-- 
Shine bright,
(: Nav :)
