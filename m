Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:51259 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbdKNRbN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Nov 2017 12:31:13 -0500
Received: by mail-pf0-f196.google.com with SMTP id j28so12580120pfk.8
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Nov 2017 09:31:13 -0800 (PST)
Date: Tue, 14 Nov 2017 09:31:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 0/2] xen_wdt: use the watchdog subsystem
Message-ID: <20171114173111.GA2237@roeck-us.net>
References: <20171114162350.24283-1-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114162350.24283-1-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 14, 2017 at 04:23:48PM +0000, Radu Rendec wrote:
> Hi Guenter,
> 
> Attaching v3 of the xen_wdt patch, including the dev_info() fix. Please
> note that I had to make some additional changes to make this work - as
> described in my previous email (included below for your convenience).
> 
> 8<----------------------------------------------------------------------
> 
> On Sat, 2017-11-11 at 08:40 -0800, Guenter Roeck wrote:
> > dev_info has that odd "wdt: " header because DRV_NAME is set to "wdt",
> > which doesn't really make much sense. Please use something more sensible
> > for DRV_NAME and use dev_info.
> 
> The trouble is (was) that the device is matched against the driver by
> the name, so the device name has to be the same as the driver name.
> Then, regardless of what the name is, __dev_printk() will print it
> twice (once as the driver name and once as the device name).
> 
Isn't that rather because MODULE_ALIAS is missing in the driver ?

Guenter

> As a workaround, after looking at platform_match(), I added an id_table
> to the platform_driver struct and now the match is done by that. Then
> the driver name can be different.
> 
> I set the driver name to "xen_wdt" and the device name to "watchdog".
> Now the messages (using dev_info()) look like this:
> 
> xen_wdt watchdog: initialized (timeout=60s, nowayout=0)
> 
> At least this looks more meaningful; I hope it's ok.
> 
> 8<----------------------------------------------------------------------
> 
> Radu Rendec (2):
>   watchdog: xen_wdt: use the watchdog subsystem
>   watchdog: xen_wdt: remove info message and version number
> 
>  drivers/watchdog/xen_wdt.c | 258 +++++++++++----------------------------------
>  1 file changed, 59 insertions(+), 199 deletions(-)
> 
> -- 
> 2.13.6
> 
