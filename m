Return-Path: <SRS0=e0s2=AY=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C01C433E0
	for <linux-watchdog@archiver.kernel.org>; Mon, 13 Jul 2020 12:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1004E2072D
	for <linux-watchdog@archiver.kernel.org>; Mon, 13 Jul 2020 12:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eoHLS5q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgGMMr0 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:47:26 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50190 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMMr0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 13 Jul 2020 08:47:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06DCjMF1081857;
        Mon, 13 Jul 2020 07:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594644322;
        bh=JDddS/CKP2aCXQxfKTiZYR2CGGt0uUybu6BJkOhnB5c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eoHLS5q4DfkBay2eQllhJynAnyjaqY6KLYu+GkV+FlhcYH7SAFvJEJU7XE7GvkaYY
         p0a48Z7vDuocQAIIWNnLPO5fDCF9nVv6Al2OHkSBmbAGyuymaPavfi0gqFr13KZfSw
         7tacFAbnzbzfJ2W7IUN/IrQM98FsnZp9uyj+Tobg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06DCjMkf121480
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 07:45:22 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 13
 Jul 2020 07:45:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 13 Jul 2020 07:45:22 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06DCjJKb020275;
        Mon, 13 Jul 2020 07:45:21 -0500
Subject: Re: [PATCHv2 2/5] watchdog: add support for adjusting last known HW
 keepalive time
To:     Guenter Roeck <linux@roeck-us.net>, <wim@linux-watchdog.org>,
        <linux-watchdog@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jan.kiszka@siemens.com>
References: <20200703120406.7092-1-t-kristo@ti.com>
 <20200703120406.7092-3-t-kristo@ti.com>
 <faeebfbb-cb8c-e31e-50ef-af42e1b11e0e@roeck-us.net>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <43dcd981-806a-dda5-39f6-6a0e42081d76@ti.com>
Date:   Mon, 13 Jul 2020 15:45:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <faeebfbb-cb8c-e31e-50ef-af42e1b11e0e@roeck-us.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 05/07/2020 17:58, Guenter Roeck wrote:
> On 7/3/20 5:04 AM, Tero Kristo wrote:
>> Certain watchdogs require the watchdog only to be pinged within a
>> specific time window, pinging too early or too late cause the watchdog
>> to fire. In cases where this sort of watchdog has been started before
>> kernel comes up, we must adjust the watchdog keepalive window to match
>> the actually running timer, so add a new driver API for this purpose.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/watchdog/watchdog_dev.c | 23 +++++++++++++++++++++++
>>   include/linux/watchdog.h        |  2 ++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>> index bc1cfa288553..5848551cf29d 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -1138,6 +1138,29 @@ void watchdog_dev_unregister(struct watchdog_device *wdd)
>>   	watchdog_cdev_unregister(wdd);
>>   }
>>   
>> +/*
>> + *	watchdog_set_last_hw_keepalive: set last HW keepalive time for watchdog
>> + *
>> + *	Adjusts the last known HW keepalive time for a watchdog timer.
>> + *	This is needed in case where watchdog has been started before
>> + *	kernel by someone like bootloader, and it can't be pinged
> 
> ... needed if the watchdog is already running when the probe function
> is called, and ...
> 
>> + *	immediately. This adjusts the watchdog ping period to match
>> + *	the currently running timer.
> 
> It doesn't adjust the ping period.
> 
>> + */
> 
> last_ping_ms needs to be documented (the last heartbeat was last_ping_ms
> milliseconds ago ?), both here and in Documentation/watchdog/watchdog-kernel-api.rst.
> It needs to be documented that the function must be called immediately
> after watchdog registration, and that min_hw_heartbeat_ms must
> be set for it to be useful.
> 
>> +int watchdog_set_last_hw_keepalive(struct watchdog_device *wdd,
>> +				   unsigned int last_ping_ms)
>> +{
>> +	struct watchdog_core_data *wd_data = wdd->wd_data;
> 
> This needs a NULL check, in case it is called before watchdog driver
> registration.

Ok will fix all the above in next revision.

-Tero

> 
>> +	ktime_t now;
>> +
>> +	now = ktime_get();
>> +
>> +	wd_data->last_hw_keepalive = ktime_sub(now, ms_to_ktime(last_ping_ms));
>> +
>> +	return __watchdog_ping(wdd);
>> +}
>> +EXPORT_SYMBOL_GPL(watchdog_set_last_hw_keepalive);
>> +
>>   /*
>>    *	watchdog_dev_init: init dev part of watchdog core
>>    *
>> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
>> index 1464ce6ffa31..9b19e6bb68b5 100644
>> --- a/include/linux/watchdog.h
>> +++ b/include/linux/watchdog.h
>> @@ -210,6 +210,8 @@ extern int watchdog_init_timeout(struct watchdog_device *wdd,
>>   extern int watchdog_register_device(struct watchdog_device *);
>>   extern void watchdog_unregister_device(struct watchdog_device *);
>>   
>> +int watchdog_set_last_hw_keepalive(struct watchdog_device *, unsigned int);
>> +
>>   /* devres register variant */
>>   int devm_watchdog_register_device(struct device *dev, struct watchdog_device *);
>>   
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
