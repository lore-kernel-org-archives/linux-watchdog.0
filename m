Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36995 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbaBKU3x (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 15:29:53 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so8142332pab.16
        for <linux-watchdog@vger.kernel.org>; Tue, 11 Feb 2014 12:29:53 -0800 (PST)
Date: Tue, 11 Feb 2014 12:29:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'H Hartley Sweeten' <hsweeten@visionengravers.com>
Subject: Re: [PATCH 1/3] watchdog: ep93xx_wdt: Use devm_ioremap_resource()
Message-ID: <20140211202951.GG11798@roeck-us.net>
References: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 11, 2014 at 09:41:54PM +0900, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler,
> and remove redundant return value check of platform_get_resource()
> because the value is checked by devm_ioremap_resource().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
