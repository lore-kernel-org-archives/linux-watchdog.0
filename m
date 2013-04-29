Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm10-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.122]:38370
	"EHLO nm10-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758272Ab3D2QiR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 12:38:17 -0400
Date: Mon, 29 Apr 2013 09:38:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] watchdog: s3c2410_wdt: convert s3c2410wdt to
 dev_pm_ops
Message-ID: <20130429163817.GH23799@roeck-us.net>
References: <000801ce44bb$a877ce00$f9676a00$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000801ce44bb$a877ce00$f9676a00$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:26:41PM +0900, Jingoo Han wrote:
> Instead of using legacy suspend/resume methods, using newer
> dev_pm_ops structure allows better control over power management.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
