Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:40098 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab3HBDtZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Aug 2013 23:49:25 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so183978pdc.33
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Aug 2013 20:49:24 -0700 (PDT)
Date: Thu, 1 Aug 2013 20:49:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Kevin Strasser' <kevin.strasser@linux.intel.com>
Subject: Re: [PATCH 1/2] watchdong: kempld_wdt: Add __user annotation
Message-ID: <20130802034924.GB26898@roeck-us.net>
References: <003201ce8e79$885e46f0$991ad4d0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003201ce8e79$885e46f0$991ad4d0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 01, 2013 at 02:39:46PM +0900, Jingoo Han wrote:
> Added __user annotation to fix the following sparse warnings.
> Also, it makes 'kempld_prescaler' static because it is used
> only in this file.
> 
> drivers/watchdog/kempld_wdt.c:70:11: warning: symbol 'kempld_prescaler' was not declared. Should it be static?
> drivers/watchdog/kempld_wdt.c:364:23: warning: incorrect type in initializer (different address spaces)
> drivers/watchdog/kempld_wdt.c:364:23:    expected int const [noderef] <asn:1>*register __p
> drivers/watchdog/kempld_wdt.c:364:23:    got int *<noident>
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
