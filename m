Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:47130 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbaEIRo1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 9 May 2014 13:44:27 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so3930276pdj.20
        for <linux-watchdog@vger.kernel.org>; Fri, 09 May 2014 10:44:26 -0700 (PDT)
Date: Fri, 9 May 2014 10:44:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yuantian.Tang@freescale.com
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com
Subject: Re: [PATCH 1/1] booke/watchdog: refine and clean up the codes
Message-ID: <20140509174415.GA5009@roeck-us.net>
References: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1399514666-2572-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 08, 2014 at 10:04:26AM +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> Basically, this patch does the following:
> 1. Move the codes of parsing boot parameters from setup-common.c
>    to driver. In this way, code reader can know directly that
>    there are boot parameters that can change the timeout.
> 2. Make boot parameter 'booke_wdt_period' effective.
>    currently, when driver is loaded, default timeout is always
>    being used in stead of booke_wdt_period.
> 3. Wrap up the watchdog timeout in device struct and clean up
>    unnecessary codes.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@freescale.com>
> Acked-by: Scott Wood <scottwood@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
