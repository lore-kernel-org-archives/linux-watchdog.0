Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm19.access.bullet.mail.sp2.yahoo.com ([98.139.44.146]:24913
	"EHLO nm19.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932092Ab3D2RxA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 13:53:00 -0400
Date: Mon, 29 Apr 2013 10:52:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 2/7] watchdog: bcm63xx_wdt: use
 devm_ioremap_nocache()
Message-ID: <20130429175259.GB5183@roeck-us.net>
References: <000c01ce44bc$cfed7830$6fc86890$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000c01ce44bc$cfed7830$6fc86890$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:34:57PM +0900, Jingoo Han wrote:
> Use devm_ioremap_nocache() to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
