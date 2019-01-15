Return-Path: <SRS0=A+Dz=PX=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A653DC43387
	for <linux-watchdog@archiver.kernel.org>; Tue, 15 Jan 2019 15:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5068320675
	for <linux-watchdog@archiver.kernel.org>; Tue, 15 Jan 2019 15:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vdorst.com header.i=@vdorst.com header.b="s6y5bZEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfAOP3Q (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:29:16 -0500
Received: from mail.0dd.nl ([5.2.79.48]:40142 "EHLO mail.0dd.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbfAOP3P (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Jan 2019 10:29:15 -0500
X-Greylist: delayed 65496 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 10:29:15 EST
Received: from mail.vdorst.com (mta.0dd.nl [IPv6:fd01::250])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.0dd.nl (Postfix) with ESMTPS id EDA1E5FED0;
        Tue, 15 Jan 2019 16:29:13 +0100 (CET)
Received: from www (www.vdorst.com [192.168.2.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.vdorst.com (Postfix) with ESMTPSA id 77146136B551;
        Tue, 15 Jan 2019 16:29:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.vdorst.com 77146136B551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdorst.com;
        s=default; t=1547566153;
        bh=CtqOFWEWKetUG8W7gjyhx30WNQlm/JUNoXvVz3AS5BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s6y5bZEl2lLIdCB6nPwyw5bAvxcCxJ9ZzzygRz7qTwKV6wOMJWWERHl7obYfT8wpA
         boQpcu5pHuk2/tK4qugL1pUvDHToSY4M4ZwFGGZ4ait0LKbAnp/qNUrNCVieBxMQyn
         QHYb+ubGr3XiEBdL84fnMNAExsBp/zi3OAw2xh6hIC15tsIF+w9MigPM/G5AnJaMxB
         /h9R6KGeRKOptTCni5i+1/6Mqgojk+nCH2xUhKyLM69+ovZhltNJWEpRA4A+4nImL1
         HmRxhpNlDr9llew1DzEev3sQqBJz6bJUqfxTwyEopb84s6afQtYXjifpTujIKNX8NF
         urWNAjwURzM3g==
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by
 www.vdorst.com (Horde Framework) with HTTPS; Tue, 15 Jan 2019 15:29:13 +0000
Date:   Tue, 15 Jan 2019 15:29:13 +0000
Message-ID: <20190115152913.Horde.lq_7NPUmj51AEcDDGP2xSEw@www.vdorst.com>
From:   =?utf-8?b?UmVuw6k=?= van Dorst <opensource@vdorst.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] watchdog: mt7621: Fix compiler error, missing include
References: <20190114211719.11461-1-opensource@vdorst.com>
 <a8b870f2-a50d-144e-cdca-b8a95d48846b@gmail.com>
In-Reply-To: <a8b870f2-a50d-144e-cdca-b8a95d48846b@gmail.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Quoting Matthias Brugger <matthias.bgg@gmail.com>:

> On 14/01/2019 22:17, René van Dorst wrote:
>> drivers/watchdog/mt7621_wdt.c:174:34: error: array type has  
>> incomplete element type 'struct of_device_id'
>>  static const struct of_device_id mt7621_wdt_match[] = {
>>                                   ^~~~~~~~~~~~~~~~
>> drivers/watchdog/mt7621_wdt.c:175:4: error: field name not in  
>> record or union initializer
>>   { .compatible = "mediatek,mt7621-wdt" },
>>     ^
>> drivers/watchdog/mt7621_wdt.c:175:4: note: (near initialization for  
>> 'mt7621_wdt_match')
>> drivers/watchdog/mt7621_wdt.c:174:34: warning: 'mt7621_wdt_match'  
>> defined but not used [-Wunused-variable]
>>  static const struct of_device_id mt7621_wdt_match[] = {
>>                                   ^~~~~~~~~~~~~~~~
>>
>
> Did this work in the past?
> I suppose so. Could you provide a fixes tag for stable.

I see that I am not the first who spotted this.  
https://patchwork.kernel.org/patch/10745049/

So better drop this one.

Greats,

René


> Thanks,
> Matthias
>
>> Signed-off-by: René van Dorst <opensource@vdorst.com>
>> ---
>>  drivers/watchdog/mt7621_wdt.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
>> index 5c4a764717c4..a3be7db9d76f 100644
>> --- a/drivers/watchdog/mt7621_wdt.c
>> +++ b/drivers/watchdog/mt7621_wdt.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/watchdog.h>
>>  #include <linux/moduleparam.h>
>> +#include <linux/of.h>
>>  #include <linux/platform_device.h>
>>
>>  #include <asm/mach-ralink/ralink_regs.h>
>>



