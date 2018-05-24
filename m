Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46724 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965936AbeEXJ3N (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 May 2018 05:29:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id p12-v6so571781pff.13
        for <linux-watchdog@vger.kernel.org>; Thu, 24 May 2018 02:29:13 -0700 (PDT)
Subject: Re: [PATCH v7 0/5] watchdog: da9063: Fix timeout handling
To: Marco Felsch <m.felsch@pengutronix.de>, wim@linux-watchdog.org,
        support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
References: <20180524075609.19951-1-m.felsch@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2c6bc188-d4b3-864f-21e1-44b88c3d4da7@roeck-us.net>
Date: Thu, 24 May 2018 02:29:11 -0700
MIME-Version: 1.0
In-Reply-To: <20180524075609.19951-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/24/2018 12:56 AM, Marco Felsch wrote:
> The current set_timeout() handling can't change the timeout value if the
> watchdog is already running because the watchdog must be
> disabled before a new timeout value can be set. This sounds a bit
> strange but it is the only way to change the timeout value.
> 
> The watchdog also has a second quirk. The timeout value combines the
> timeout and the watchdog enable signal. So a value not equal zero
> indicates that the watchdog is running. This leads into problems if the
> watchdog is disabled and a new timeout value should be set because
> during setting the timeout value the watchdog gets enabled. The driver
> must check if the watchdog is disabled. In that case the timeout value
> must be stored to be available for the later wdt_start() call. If the
> watchdog is already running the driver must write the new timeout value
> immediately to the watchdog.
> 
> There was also a issue during the driver probe sequence. The driver must
> set a new timeout reference mark if the watchdog was enabled in a earlier
> stage e.g. the bootloader.
> 
> Marco Felsch (5):
>    watchdog: da9063: Fix setting/changing timeout
>    watchdog: da9063: Fix setting HW_RUNNING indication during wdt_start
>    watchdog: da9063: Fix updating timeout value
>    watchdog: da9063: Fix timeout handling during probe
>    watchdog: da9063: rename helper function to avoid misunderstandings
> 
>   drivers/watchdog/da9063_wdt.c | 69 ++++++++++++++++++++++++++++++++---
>   1 file changed, 63 insertions(+), 6 deletions(-)
> 
I am really missing the change log.

Guenter

