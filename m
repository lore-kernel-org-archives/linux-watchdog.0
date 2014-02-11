Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39238 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556AbaBKUbP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 15:31:15 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so8151956pab.34
        for <linux-watchdog@vger.kernel.org>; Tue, 11 Feb 2014 12:31:15 -0800 (PST)
Date: Tue, 11 Feb 2014 12:31:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Michal Simek' <michal.simek@xilinx.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] watchdog: sp805_wdt: Use devm_ioremap_resource()
Message-ID: <20140211203112.GI11798@roeck-us.net>
References: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
 <001001cf2727$355d2ba0$a01782e0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001cf2727$355d2ba0$a01782e0$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 11, 2014 at 09:45:56PM +0900, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
