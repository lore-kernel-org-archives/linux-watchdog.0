Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:57251 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab3CRIoj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Mar 2013 04:44:39 -0400
Received: by mail-ob0-f180.google.com with SMTP id ef5so4940912obb.39
        for <linux-watchdog@vger.kernel.org>; Mon, 18 Mar 2013 01:44:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAK9yfHx85WWx=UMWVDN=1e=h=FtmbOwrc35oG1mwRep6gjskVA@mail.gmail.com>
References: <1362373604-26771-1-git-send-email-sachin.kamat@linaro.org>
	<20130304065308.GA16261@avionic-0098.mockup.avionic-design.de>
	<CAK9yfHx85WWx=UMWVDN=1e=h=FtmbOwrc35oG1mwRep6gjskVA@mail.gmail.com>
Date: Mon, 18 Mar 2013 14:14:38 +0530
Message-ID: <CAK9yfHwQZwG+Qqc69xsTWOoosVjSS50NnAfN0QgFuDVfzzwCHA@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: s3c2410_wdt: Convert to devm_ioremap_resource()
From: Sachin Kamat <sachin.kamat@linaro.org>
To: wim@iguana.be, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11 March 2013 14:59, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi Wim,
>
> On 4 March 2013 12:23, Thierry Reding <thierry.reding@avionic-design.de> wrote:
>> On Mon, Mar 04, 2013 at 10:36:41AM +0530, Sachin Kamat wrote:
>>> Use the newly introduced devm_ioremap_resource() instead of
>>> devm_request_and_ioremap() which provides more consistent error handling.
>>>
>>> devm_ioremap_resource() provides its own error messages; so all explicit
>>> error messages can be removed from the failure code paths.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>> Cc: Thierry Reding <thierry.reding@avionic-design.de>
>>> ---
>>>  drivers/watchdog/s3c2410_wdt.c |    7 +++----
>>>  1 files changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
>>> index c1a221c..ee03135 100644
>>> --- a/drivers/watchdog/s3c2410_wdt.c
>>> +++ b/drivers/watchdog/s3c2410_wdt.c
>>> @@ -330,10 +330,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>>       }
>>>
>>>       /* get the memory region for the watchdog timer */
>>> -     wdt_base = devm_request_and_ioremap(dev, wdt_mem);
>>> -     if (wdt_base == NULL) {
>>> -             dev_err(dev, "failed to devm_request_and_ioremap() region\n");
>>> -             ret = -ENOMEM;
>>> +     wdt_base = devm_ioremap_resource(dev, wdt_mem);
>>> +     if (IS_ERR(wdt_base)) {
>>> +             ret = PTR_ERR(wdt_base);
>>>               goto err;
>>>       }
>>>
>>
>> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
>
> Did you get a chance to check this series?

ping..
