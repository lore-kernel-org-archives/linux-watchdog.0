Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 8 Oct 2016 16:01:20 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: iTCO_wdt: constify iTCO_wdt_pm structure
Message-ID: <20161008140120.GB23290@spo001.leaseweb.nl>
References: <1472415986-16035-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472415986-16035-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Julia,

> iTCO_wdt_pm, of type struct dev_pm_ops, is never modified, so declare it as
> const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

This patch and your constify watchdog_ops structures were added to linux-watchdog-next almost 2 weeks ago.

Kind regards,
Wim.
