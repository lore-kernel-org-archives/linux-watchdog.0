Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:42887 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab3J3FPn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 01:15:43 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so953432obb.4
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Oct 2013 22:15:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <526E68A9.8030002@roeck-us.net>
References: <1382941457-2826-1-git-send-email-sachin.kamat@linaro.org>
	<526E68A9.8030002@roeck-us.net>
Date: Wed, 30 Oct 2013 10:45:41 +0530
Message-ID: <CAK9yfHxDHoYaDS=8EH_omAiWtcwx4-4DOO6bvfJeOTqfBGDKiw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/watchdog: Update node name in samsung-wdt example
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Rob Landley <rob@landley.net>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 28 October 2013 19:07, Guenter Roeck <linux@roeck-us.net> wrote:
> On 10/27/2013 11:24 PM, Sachin Kamat wrote:
>>
>> Update the name as per DT naming convention.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>   .../devicetree/bindings/watchdog/samsung-wdt.txt   |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> index 4c798e3..0642fb8 100644
>> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
>> @@ -17,7 +17,7 @@ Optional properties:
>>
>>   Example:
>>
>> -watchdog {
>> +watchdog@101D0000 {
>>         compatible = "samsung,s3c2410-wdt";
>>         reg = <0x101D0000 0x100>, <0x10040408 0x4>, <0x1004040c 0x4>;
>>         interrupts = <0 42 0>;
>>
>
> Sachin,
>
> It appears that this patch depends on some other patch which is not upstream
> yet.

Yes you are right.

> It is not in -next either. Can you point to that other patch ?

This patch was based on a non-upstream patch. I have now posted the
right version.
Please ignore the current one. Sorry for the mess up.

-- 
With warm regards,
Sachin
