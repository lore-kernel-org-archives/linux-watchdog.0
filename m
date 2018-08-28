Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f171.google.com ([209.85.214.171]:43779 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2Ak3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 20:40:29 -0400
Date: Tue, 28 Aug 2018 13:47:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v2 1/4] watchdog: core: add mechanism to prevent
 removing if NOWAYOUT
Message-ID: <20180828204704.GA31691@roeck-us.net>
References: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
 <20180828191416.7781-2-wsa+renesas@sang-engineering.com>
 <20180828193320.GA22656@roeck-us.net>
 <20180828200739.ghu5trdp7jq6ixiz@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828200739.ghu5trdp7jq6ixiz@katana>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 28, 2018 at 10:07:40PM +0200, Wolfram Sang wrote:
> Hi Guenter,
> 
> > > +		__driver.remove = NULL; \
> > 
> > Does that really do any good ? If I understand correctly, the only
> > impact is that the platform driver remove function will believe that
> > nothing needs to be done on removal. See platform_drv_remove().
> 
> This might be biased for my use case. Not calling remove will also leave
> the clock for that module enabled. But true, the platform device will be
> removed and without proper cleanup, there could be dangling pointers.
> 

For many drivers the watchdog device would not be removed. That would
indeed be fatal.

> In general, what do you think of this approach if we'd left out the
> above line?
> 

LGTM without that line.

Thanks,
Guenter
