Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38345 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635AbaBKUap (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 15:30:45 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so8003223pdj.29
        for <linux-watchdog@vger.kernel.org>; Tue, 11 Feb 2014 12:30:44 -0800 (PST)
Date: Tue, 11 Feb 2014 12:30:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Aaro Koskinen' <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/3] watchdog: omap_wdt: Use devm_ioremap_resource()
Message-ID: <20140211203042.GH11798@roeck-us.net>
References: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
 <000f01cf2726$f7500210$e5f00630$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01cf2726$f7500210$e5f00630$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 11, 2014 at 09:44:12PM +0900, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler,
> and remove 'struct resource *mem' from 'struct omap_wdt_dev'
> and omap_wdt_probe(), resplectively. because the 'mem' variables
> are not used anymore. Also the redundant return value check of
> platform_get_resource() is removed, because the value is checked
> by devm_ioremap_resource().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
