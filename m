Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F9DC4320A
	for <linux-watchdog@archiver.kernel.org>; Fri, 30 Jul 2021 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A6A60F9B
	for <linux-watchdog@archiver.kernel.org>; Fri, 30 Jul 2021 21:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhG3Vh4 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 30 Jul 2021 17:37:56 -0400
Received: from david.siemens.de ([192.35.17.14]:42303 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhG3Vhw (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 30 Jul 2021 17:37:52 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 16ULbSmE018382
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 23:37:28 +0200
Received: from [167.87.33.191] ([167.87.33.191])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 16ULbSA3026692;
        Fri, 30 Jul 2021 23:37:28 +0200
Subject: Re: [PATCH] watchdog: Respect handle_boot_enabled when setting last
 last_hw_keepalive
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
References: <fe8cf65f-f949-9326-8f32-fda7134c8da6@siemens.com>
 <211cd54b-29b4-e58a-341b-beffc05cfe85@roeck-us.net>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <def0c2e9-e035-7ffc-3216-27f461555ae5@siemens.com>
Date:   Fri, 30 Jul 2021 23:37:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <211cd54b-29b4-e58a-341b-beffc05cfe85@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 30.07.21 22:49, Guenter Roeck wrote:
> On 7/30/21 12:39 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We must not pet a running watchdog when handle_boot_enabled is off
>> because this requests to only start doing that via userspace, not during
>> probing.
>>
> 
> The scope of the changed function is quite limited. See the
> definition of watchdog_set_last_hw_keepalive(). On top of that,
> __watchdog_ping() does a bit more than just ping the watchdog,
> and it only pings the watchdog in limited circumstances. On top of that,
> the scope of handle_boot_enabled is different: If enabled, it tells
> the watchdog core to keep pinging a watchdog until userspace opens
> the device. This is about continuous pings, not about an initial one.
> Given that, I'd rather have the watchdog subsystem issue an additional
> ping than risking a regression.
> 
> The only driver calling watchdog_set_last_hw_keepalive() is rti_wdt.c.
> Does this patch solve a specific problem observed with that watchdog ?

Yes, it unbreaks support for handle_boot_enabled=no by not starting the
automatic pinging of the kernel until userspace opens the device.
Without this fix, the core will prematurely start kernel-side pinging,
and hanging userspace will never be detected.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
