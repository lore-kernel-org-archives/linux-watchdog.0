Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:51943 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeASH7o (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 19 Jan 2018 02:59:44 -0500
Date: Fri, 19 Jan 2018 08:26:39 +0100
From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: remove at32ap700x_wdt
Message-ID: <20180119072639.7ntdmsok55snvuxk@samfundet.no>
References: <20180118195256.5663-1-clabbe.montjoie@gmail.com>
 <20180118200832.GA29961@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118200832.GA29961@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Around Thu 18 Jan 2018 12:08:32 -0800 or thereabout, Guenter Roeck wrote:
> On Thu, Jan 18, 2018 at 08:52:56PM +0100, Corentin Labbe wrote:
>> Since AVR32 is gone, this driver is useless.
>> 
> 
> Quite true.
> 
>> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

>> ---
>>  drivers/watchdog/Kconfig          |   9 -
>>  drivers/watchdog/Makefile         |   3 -
>>  drivers/watchdog/at32ap700x_wdt.c | 433 --------------------------------------
>>  3 files changed, 445 deletions(-)
>>  delete mode 100644 drivers/watchdog/at32ap700x_wdt.c

<snipp diff>

-- 
mvh
Hans-Christian Noren Egtvedt
