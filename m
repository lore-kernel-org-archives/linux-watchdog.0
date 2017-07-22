Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58832 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdGVVYZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Jul 2017 17:24:25 -0400
Date: Sat, 22 Jul 2017 14:24:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Fabio Estevam <festevam@gmail.com>, wim@iguana.be,
        linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com,
        justinpopo6@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 1/2] watchdog: renesas-wdt: Check the return value from
 clk_prepare_enable()
Message-ID: <20170722212422.GB2969@roeck-us.net>
References: <1500754979-19836-1-git-send-email-festevam@gmail.com>
 <20170722203159.GA6399@tetsubishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170722203159.GA6399@tetsubishi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Jul 22, 2017 at 10:31:59PM +0200, Wolfram Sang wrote:
> On Sat, Jul 22, 2017 at 05:22:58PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> > 
> > clk_prepare_enable() may fail, so we should better check its return value
> > and propagate it in the case of error.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> True. Yet, I have a patch in preparation which fully switches to
> RuntimePM which will make manual clk handling superfluous.
> 

It won't need clk_prepare_enable() anymore ?

Guenter
