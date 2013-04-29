Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm21-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.176]:47415
	"EHLO nm21-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757537Ab3D2Qe7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 12:34:59 -0400
Date: Mon, 29 Apr 2013 09:34:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] watchdog: s3c2410_wdt: use
 dev_err()/dev_info() instead of pr_err()/pr_info()
Message-ID: <20130429163459.GG23799@roeck-us.net>
References: <000701ce44bb$96f4ecd0$c4dec670$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701ce44bb$96f4ecd0$c4dec670$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:26:12PM +0900, Jingoo Han wrote:
> dev_err()/dev_info() are more preferred than pr_err()/pr_info().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
