Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42026 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeB0RTR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Feb 2018 12:19:17 -0500
Date: Tue, 27 Feb 2018 09:19:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [PATCH] watchdog: renesas_wdt: adapt timer setup to recommended
 procedure
Message-ID: <20180227171915.GC1212@roeck-us.net>
References: <20180226214905.24516-1-wsa+renesas@sang-engineering.com>
 <20180226223853.GC5924@roeck-us.net>
 <20180227130058.pmgo33zjvbxwmlad@ninjato>
 <86da4e12-0d0c-c07a-eecd-76466f713da1@roeck-us.net>
 <20180227162256.fgyd3oikydrq3e7i@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227162256.fgyd3oikydrq3e7i@katana>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 27, 2018 at 05:22:56PM +0100, Wolfram Sang wrote:
> 
> > the core gets it wrong. Just add a note to the probe function where cks is
> > initialized that RWTCSRA_TME must not be set, and that RWTCSRA_TME must be
> > cleared before changing the divider.
> 
> But we would still need to disable TME sperately if the caclulated cks
> is not the same value as the current register value (be it power-on
> default or something the firmware did set). Because we shall not disable
> TME and modify cks at the same time.
> 
AFAICS this only applies if the watchdog is already running at boot,
which is not currently supported to start with.

Guenter
