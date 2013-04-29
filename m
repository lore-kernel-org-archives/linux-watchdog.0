Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm16-vm0.access.bullet.mail.mud.yahoo.com ([66.94.236.19]:46685
	"EHLO nm16-vm0.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754931Ab3D2SL7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 14:11:59 -0400
Date: Mon, 29 Apr 2013 11:05:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 5/7] watchdog: rc32434_wdt: use
 devm_ioremap_nocache() functions
Message-ID: <20130429180502.GE5183@roeck-us.net>
References: <000f01ce44bc$f1342570$d39c7050$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01ce44bc$f1342570$d39c7050$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:35:53PM +0900, Jingoo Han wrote:
> Use devm_ioremap_nocache() functions to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
