Return-Path: <SRS0=HvdG=SI=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B2AC10F06
	for <linux-watchdog@archiver.kernel.org>; Sat,  6 Apr 2019 14:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88A5213A2
	for <linux-watchdog@archiver.kernel.org>; Sat,  6 Apr 2019 14:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hofmannsweb.com header.i=@hofmannsweb.com header.b="O5/ysyUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDFORH (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 6 Apr 2019 10:17:07 -0400
Received: from 178.27.4.93.rev.sfr.net ([93.4.27.178]:39734 "EHLO
        hofmannsweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDFORG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 6 Apr 2019 10:17:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by hofmannsweb.com (Postfix) with ESMTP id 04DF8310B81;
        Sat,  6 Apr 2019 16:17:06 +0200 (CEST)
Received: from hofmannsweb.com ([127.0.0.1])
        by localhost (hofmannsweb.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aceTHrKl1Nil; Sat,  6 Apr 2019 16:17:04 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by hofmannsweb.com (Postfix) with ESMTP id 713B2310B7D;
        Sat,  6 Apr 2019 16:17:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 hofmannsweb.com 713B2310B7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hofmannsweb.com;
        s=5A2CD3FC-E3ED-11E4-B8B6-D3B199B2F681; t=1554560224;
        bh=yvmx51Vt7ZVxmiJF/8hf04yG9nrdKKqiubWV/6KhcIE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=O5/ysyUnDQ0v6Gf4HG4cjbBC5xqj8SLgQaWGmIVQthwmbYamjnbP2S5eliefsX4zg
         ezCI5w0RvTm33rz9P2s6AUd1A+v6Z58KM/RUqPL7A1w67XsIA8eUSsek5b+1A187dp
         9jSvtixpxi/REvcLQqR/pfMIqi1xC4sGDx5yncCc=
X-Virus-Scanned: amavisd-new at hofmannsweb.com
Received: from hofmannsweb.com ([127.0.0.1])
        by localhost (hofmannsweb.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fFLvEUNe30Ja; Sat,  6 Apr 2019 16:17:04 +0200 (CEST)
Received: from hofmannsweb.com (hofmannsweb.com [192.168.1.10])
        by hofmannsweb.com (Postfix) with ESMTP id 5470D310B7A;
        Sat,  6 Apr 2019 16:17:04 +0200 (CEST)
Date:   Sat, 6 Apr 2019 16:17:04 +0200 (CEST)
From:   Georg Hofmann <georg@hofmannsweb.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
Message-ID: <2141975119.2003.1554560224141.JavaMail.zimbra@hofmannsweb.com>
In-Reply-To: <2a7af85e-486d-26dc-17bf-9f6e2c3ddf8a@roeck-us.net>
References: <1274287303.1911.1554545863744.JavaMail.zimbra@hofmannsweb.com> <2a7af85e-486d-26dc-17bf-9f6e2c3ddf8a@roeck-us.net>
Subject: Re: [PATCH] Fix set_timeout for big timeout values
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.1.11]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF66 (Mac)/8.8.11_GA_3787)
Thread-Topic: Fix set_timeout for big timeout values
Thread-Index: qg/ZjL1JV+AsJcUo00k9tUvKDi6dmw==
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

----- Original Message -----
> From: "Guenter Roeck" <linux@roeck-us.net>
> To: "Georg Hofmann" <georg@hofmannsweb.com>, wim@linux-watchdog.org
> Cc: linux-watchdog@vger.kernel.org
> Sent: Saturday, April 6, 2019 3:25:44 PM
> Subject: Re: [PATCH] Fix set_timeout for big timeout values

> On 4/6/19 3:17 AM, Georg Hofmann wrote:
>> This patch implements the documented behavior: if max_hw_heartbeat_ms is
>> implemented, the minimum of the set_timeout argument and
>> max_hw_heartbeat_ms should be used.
>> Previously only the first 7 bits were used and the input argument was
>> returned.
>> 
>> Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>
>> ---
>>   drivers/watchdog/imx2_wdt.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
>> index 2b52514..3c13adc 100644
>> --- a/drivers/watchdog/imx2_wdt.c
>> +++ b/drivers/watchdog/imx2_wdt.c
>> @@ -178,9 +178,11 @@ static void __imx2_wdt_set_timeout(struct watchdog_device
>> *wdog,
>>   static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
>>   				unsigned int new_timeout)
>>   {
>> -	__imx2_wdt_set_timeout(wdog, new_timeout);
>> +	unsigned int actual;
>>   
>> -	wdog->timeout = new_timeout;
>> +	actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
>> +	__imx2_wdt_set_timeout(wdog, actual);
>> +	wdog->timeout = actual;
> 
> That defeats the purpose of having an internal maximum. wdog->timeout
> should still be set to the requested value.
> 
> Guenter

Hi,

I don't understand, the internal maximum is max_hw_heartbeat_ms.
I have used the same code as other watchdog drivers 
(e.g. aspeed_wdt.c, loongson1_wdt.c, ...).

I have submitted this patch because I was writing a userspace
 program and I expected a different behavior on the ioctl.
The watchdog documentation says (Documentation/watchdog/watchdog-api.txt):
Setting and getting the timeout:

For some drivers it is possible to modify the watchdog timeout on the
fly with the SETTIMEOUT ioctl, those drivers have the WDIOF_SETTIMEOUT
flag set in their option field.  The argument is an integer
representing the timeout in seconds.  The driver returns the real
timeout used in the same variable, and this timeout might differ from
the requested one due to limitation of the hardware.

    int timeout = 45;
    ioctl(fd, WDIOC_SETTIMEOUT, &timeout);
    printf("The timeout was set to %d seconds\n", timeout);

This example might actually print "The timeout was set to 60 seconds"
if the device has a granularity of minutes for its timeout.

As the watchdog core driver reads the timeout just after write, I have
to set the applied value to timeout.

Initially I thought I should get a error message if the timeout can't
be applied, but the documentation describes another behavior.

Georg
