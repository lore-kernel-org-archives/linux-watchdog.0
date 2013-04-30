Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm15.access.bullet.mail.sp2.yahoo.com ([98.139.44.142]:25550
	"EHLO nm15.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751364Ab3D3FcP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Apr 2013 01:32:15 -0400
Date: Mon, 29 Apr 2013 22:32:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 4/7] watchdog: nuc900_wdt: use devm_*() functions
Message-ID: <20130430053214.GA4559@roeck-us.net>
References: <001101ce455f$c441cf60$4cc56e20$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001101ce455f$c441cf60$4cc56e20$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 30, 2013 at 02:01:25PM +0900, Jingoo Han wrote:
> Use devm_*() functions to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Changes since v1:
> - used sizeof(*nuc900_wdt) instead of sizeof(struct nuc900_wdt)
> - declared 'nuc900_wdt->res' variable as logical variable
> 
You mean 'local'.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
