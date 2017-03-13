Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbdCMGrR (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 13 Mar 2017 02:47:17 -0400
MIME-Version: 1.0
In-Reply-To: <d91a14cc-d741-f4ff-7411-64d4862b6e50@roeck-us.net>
References: <20170311174255.23327-1-krzk@kernel.org> <20170311174255.23327-2-krzk@kernel.org>
 <d91a14cc-d741-f4ff-7411-64d4862b6e50@roeck-us.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 13 Mar 2017 08:47:13 +0200
Message-ID: <CAJKOXPdg4eUUB64GZJK2+AOfsQxLHPh6qceZGJfYfhOA=Gvqbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] watchdog: s3c2410: Constify local structures
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Mar 12, 2017 at 10:56 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 03/11/2017 09:42 AM, Krzysztof Kozlowski wrote:
>>
>> Structures watchdog_device, watchdog_ops and s3c2410_wdt_variant are not
>> modified so they can be made const to increase code safeness.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  drivers/watchdog/s3c2410_wdt.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/watchdog/s3c2410_wdt.c
>> b/drivers/watchdog/s3c2410_wdt.c
>> index 6ed97596ca80..5eaec319e499 100644
>> --- a/drivers/watchdog/s3c2410_wdt.c
>> +++ b/drivers/watchdog/s3c2410_wdt.c
>> @@ -131,7 +131,7 @@ struct s3c2410_wdt {
>>         unsigned long           wtdat_save;
>>         struct watchdog_device  wdt_device;
>>         struct notifier_block   freq_transition;
>> -       struct s3c2410_wdt_variant *drv_data;
>> +       const struct s3c2410_wdt_variant *drv_data;
>>         struct regmap *pmureg;
>>  };
>>
>> @@ -401,7 +401,7 @@ static const struct watchdog_ops s3c2410wdt_ops = {
>>         .restart = s3c2410wdt_restart,
>>  };
>>
>> -static struct watchdog_device s3c2410_wdd = {
>> +static const struct watchdog_device s3c2410_wdd = {
>>         .info = &s3c2410_wdt_ident,
>>         .ops = &s3c2410wdt_ops,
>>         .timeout = S3C2410_WATCHDOG_DEFAULT_TIME,
>> @@ -507,15 +507,15 @@ static inline unsigned int
>> s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>>         return 0;
>>  }
>>
>> -static inline struct s3c2410_wdt_variant *
>> +static inline const struct s3c2410_wdt_variant *
>>  s3c2410_get_wdt_drv_data(struct platform_device *pdev)
>>  {
>>         if (pdev->dev.of_node) {
>>                 const struct of_device_id *match;
>>                 match = of_match_node(s3c2410_wdt_match,
>> pdev->dev.of_node);
>> -               return (struct s3c2410_wdt_variant *)match->data;
>> +               return (const struct s3c2410_wdt_variant *)match->data;
>
>
> The const in this typecast isn't necessary.
>
>>         } else {
>> -               return (struct s3c2410_wdt_variant *)
>> +               return (const struct s3c2410_wdt_variant *)
>
>
> Same here. Transition to const is automatic.

Right, I'll fix this and resend.

Best regards,
Krzysztof
