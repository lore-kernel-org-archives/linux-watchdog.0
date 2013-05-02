Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm9.access.bullet.mail.sp2.yahoo.com ([98.139.44.136]:39958
	"EHLO nm9.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759001Ab3EBNbf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 May 2013 09:31:35 -0400
Date: Thu, 2 May 2013 06:31:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V3 7/7] watchdog: ts72xx_wdt: use devm_*() functions
Message-ID: <20130502133137.GA14103@roeck-us.net>
References: <000a01ce46f9$334257f0$99c707d0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01ce46f9$334257f0$99c707d0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 02, 2013 at 02:52:16PM +0900, Jingoo Han wrote:
> Use devm_*() functions to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>
