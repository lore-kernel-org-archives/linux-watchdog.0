Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:51523 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbaBKUJz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 15:09:55 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so7964391pde.7
        for <linux-watchdog@vger.kernel.org>; Tue, 11 Feb 2014 12:09:55 -0800 (PST)
Date: Tue, 11 Feb 2014 12:09:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/8] watchdog: Remove unnecessary OOM messages
Message-ID: <20140211200952.GA11798@roeck-us.net>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 11, 2014 at 03:46:43PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. For example,
> k.alloc and v.alloc failures use dump_stack().
> 
> Jingoo Han (8):
>       watchdog: at32ap700x: Remove unnecessary OOM messages
>       watchdog: ts72xx_wdt: make 'ts72xx_wdt_pdev' static
>       watchdog: bcm2835: Remove unnecessary OOM messages
>       watchdog: da9052: Remove unnecessary OOM messages
>       watchdog: da9055: Remove unnecessary OOM messages
>       watchdog: pcwd_usb: Remove unnecessary OOM messages
>       watchdog: sp805_wdt: Remove unnecessary OOM messages
>       watchdog: ts72xx_wdt: Remove unnecessary OOM messages
>       watchdog: wm831x: Remove unnecessary OOM messages
> 
For the series:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
