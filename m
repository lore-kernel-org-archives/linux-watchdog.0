Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:51418 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbaIRPfP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Sep 2014 11:35:15 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so1643947pdb.39
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Sep 2014 08:35:14 -0700 (PDT)
Date: Thu, 18 Sep 2014 08:35:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingchang Lu <jingchang.lu@freescale.com>
Cc: wim@iguana.be, shawn.guo@freescale.com, arnd@arndb.de,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2] watchdog: imx2_wdt: add restart handler support
Message-ID: <20140918153510.GC11881@roeck-us.net>
References: <1410506676-24205-1-git-send-email-jingchang.lu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410506676-24205-1-git-send-email-jingchang.lu@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 12, 2014 at 03:24:36PM +0800, Jingchang Lu wrote:
>   Register the watchdog as the system restart function
> to the new introducing kernel restart call chain in the
> driver instead of providing the restart in machine desc.
>   This restart handler function is from the mxc_restart()
> in arch/arm/mach-imx/system.c
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>

Looks good to me.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
