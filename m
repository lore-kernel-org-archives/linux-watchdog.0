Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38131 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeIPGN1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Sep 2018 02:13:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id t84-v6so6037576pgb.5
        for <linux-watchdog@vger.kernel.org>; Sat, 15 Sep 2018 17:52:26 -0700 (PDT)
Date: Sat, 15 Sep 2018 17:52:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [v3, 3/4] documentation: watchdog: add documentation for
 armada-37xx-wdt
Message-ID: <20180916005224.GA31525@roeck-us.net>
References: <20180907130553.14271-4-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907130553.14271-4-marek.behun@nic.cz>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 07, 2018 at 03:05:52PM +0200, Marek Behún wrote:
> Add documentation for the kernel module parameters accepted by
> armada-37xx-wdt.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/watchdog-parameters.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 6d6200ea27b8..0b88e333f9e1 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -40,6 +40,11 @@ margin: Watchdog margin in seconds (default=60)
>  nowayout: Disable watchdog shutdown on close
>  	(default=kernel config parameter)
>  -------------------------------------------------
> +armada_37xx_wdt:
> +timeout: Watchdog timeout in seconds. (default=120)
> +nowayout: Disable watchdog shutdown on close
> +	(default=kernel config parameter)
> +-------------------------------------------------
>  at91rm9200_wdt:
>  wdt_time: Watchdog time in seconds. (default=5)
>  nowayout: Watchdog cannot be stopped once started
