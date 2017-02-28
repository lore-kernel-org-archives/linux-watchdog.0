Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44766 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdB1VeP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 16:34:15 -0500
Date: Tue, 28 Feb 2017 13:31:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] watchdog fixes for COMPILE_TEST change
Message-ID: <20170228213149.GA6651@roeck-us.net>
References: <20170228210123.3404816-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170228210123.3404816-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 28, 2017 at 10:01:15PM +0100, Arnd Bergmann wrote:
> Hi Guenter,
> 
> I noticed your change to enable lots of watchdog drivers for compile
> testing in linux-next today. While this is generally a great idea,
> I'm not entirely sure why this appeared during the merge window.
> 
Problem is that Wim doesn't apply patches to a tree which gets exposed
to -next. I'll have to discuss with him how to change that. The tree
has been exposed to 0day for quite some time, though, which did not
report any errors (nor did my own build tests). No idea how both me
and 0day missed all those problems.

Sorry :-(

Guenter

> I case you plan to have this merged into v4.11, please make sure
> to get the fixups in. I found eight drivers that now have incorrect
> dependencies. For two of them I changed the MFD code, for the others
> I just adapted the Kconfig dependencies, mostly by reverting
> part of your patch.
> 
>     Arnd
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
