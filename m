Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:48021 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751985Ab3EZNXF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 May 2013 09:23:05 -0400
Date: Sun, 26 May 2013 15:23:04 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: s3c2410_wdt: convert s3c2410wdt to dev_pm_ops
Message-ID: <20130526132304.GB6609@spo001.leaseweb.com>
References: <005e01ce2053$7e483980$7ad8ac80$%han@samsung.com> <005f01ce2053$a23cefc0$e6b6cf40$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005f01ce2053$a23cefc0$e6b6cf40$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> Instead of using legacy suspend/resume methods, using newer
> dev_pm_ops structure allows better control over power management.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/s3c2410_wdt.c |   18 ++++++++----------
>  1 files changed, 8 insertions(+), 10 deletions(-)
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.

