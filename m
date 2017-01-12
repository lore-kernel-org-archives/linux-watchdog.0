Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38058 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750777AbdALKUu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Jan 2017 05:20:50 -0500
Date: Thu, 12 Jan 2017 10:04:28 +0000
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <patches@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 62/62] watchdog: wm831x_wdt: Convert to use device
 managed functions
Message-ID: <20170112100428.GC27100@localhost.localdomain>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-11-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1484100561-17638-11-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 10, 2017 at 06:09:16PM -0800, Guenter Roeck wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Replace 'val = e; return val;' with 'return e;'
> - Drop assignments to otherwise unused variables
> - Replace 'if (e) { return expr; }' with 'if (e) return expr;'
> - Drop remove function
> - Drop platform_set_drvdata()
> - Use devm_watchdog_register_driver() to register watchdog device
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Looks good to me:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
