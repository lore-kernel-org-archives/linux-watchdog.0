Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34803 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdGVVaN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Jul 2017 17:30:13 -0400
Date: Sat, 22 Jul 2017 14:30:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Fabio Estevam <festevam@gmail.com>, wim@iguana.be,
        linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com,
        justinpopo6@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 1/2] watchdog: renesas-wdt: Check the return value from
 clk_prepare_enable()
Message-ID: <20170722213011.GD2969@roeck-us.net>
References: <1500754979-19836-1-git-send-email-festevam@gmail.com>
 <20170722203159.GA6399@tetsubishi>
 <20170722212422.GB2969@roeck-us.net>
 <20170722212818.GA6979@tetsubishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170722212818.GA6979@tetsubishi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Jul 22, 2017 at 11:28:19PM +0200, Wolfram Sang wrote:
> 
> > It won't need clk_prepare_enable() anymore ?
> 
> Nope, RuntimePM does all the clock handling.
> 

What if runtime PM is disabled ?

Thanks,
Guenter
