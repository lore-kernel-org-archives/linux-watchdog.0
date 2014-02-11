Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36973 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbaBKUVw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 15:21:52 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so7900689pdj.26
        for <linux-watchdog@vger.kernel.org>; Tue, 11 Feb 2014 12:21:51 -0800 (PST)
Date: Tue, 11 Feb 2014 12:21:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Mika Westerberg' <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] watchdog: ts72xx_wdt: make 'ts72xx_wdt_pdev' static
Message-ID: <20140211202149.GD11798@roeck-us.net>
References: <001a01cf26f6$d4636dd0$7d2a4970$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a01cf26f6$d4636dd0$7d2a4970$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 11, 2014 at 03:59:38PM +0900, Jingoo Han wrote:
> Make 'ts72xx_wdt_pdev' static, because it is used only in this
> file. It also fixes the following sparse warning.
> 
>   warning: symbol 'ts72xx_wdt_pdev' was not declared. Should it be static?
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
