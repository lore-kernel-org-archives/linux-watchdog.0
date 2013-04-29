Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm3.access.bullet.mail.mud.yahoo.com ([66.94.237.204]:35266
	"EHLO nm3.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757811Ab3D2Qlr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 12:41:47 -0400
Date: Mon, 29 Apr 2013 09:41:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] watchdog: wm831x_wdt: use
 devm_gpio_request_one()
Message-ID: <20130429164146.GI23799@roeck-us.net>
References: <000a01ce44bc$4ebef180$ec3cd480$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01ce44bc$4ebef180$ec3cd480$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:31:20PM +0900, Jingoo Han wrote:
> Use devm_gpio_request_one() to make cleanup paths simpler.
> Also, GPIOF_DIR_OUT | GPIOF_INIT_LOW is replaced with
> GPIOF_OUT_INIT_LOW.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
