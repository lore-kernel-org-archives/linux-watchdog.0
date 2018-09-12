Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:50117 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeILQW6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Sep 2018 12:22:58 -0400
Date: Wed, 12 Sep 2018 13:18:52 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jeremy Gebben <jgebben@sweptlaser.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] rtc: abx80x: add basic watchdog support
Message-ID: <20180912111852.GD2760@piout.net>
References: <20180911172826.7195-1-jgebben@sweptlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911172826.7195-1-jgebben@sweptlaser.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/09/2018 11:28:24-0600, Jeremy Gebben wrote:
> This patch series adds watchdog support for abracon RTC chips which
> include basic watchdog functionality.
> 
> Thank you for reviewing.
> 
> Changes in v3 (all in patch 2):
> * fix CONFIG_WATCHDOG dependency again (hopefully correctly this time)
> * don't start hardware when set_timeout is called
> * remove unneeded WDOG_HW_RUNNING bit changes
> * fix abx80x_setup_watchdog()
> * fix formatting of multiline splits
>  
> Changes in v2:
> * split out priv structure into a separate patch
> * remove new Kconfig option
> * fix CONFIG_WATCHDOG dependency
> * fix WDT interrupt message
> 
> 
> Jeremy Gebben (2):
>   rtc: abx80x: use a 'priv' struct for client data
>   rtc: abx80x: add basic watchdog support
> 
>  drivers/rtc/Kconfig      |   1 +
>  drivers/rtc/rtc-abx80x.c | 143 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 132 insertions(+), 12 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
