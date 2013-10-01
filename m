Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:59006 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab3JAPjf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Oct 2013 11:39:35 -0400
Date: Tue, 1 Oct 2013 08:39:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: watchdog: ts72xx_wdt: cleanup return codes in ioctl
Message-ID: <20131001153930.GA25875@roeck-us.net>
References: <20130823093832.GL31293@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130823093832.GL31293@elgon.mountain>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Aug 23, 2013 at 05:38:32PM -0000, Dan Carpenter wrote:
> There seems to be some confusion here which functions return positive
> numbers and which return negative error codes.
> 
> copy_to_user() returns the number of bytes remaining to be copied but we
> want to return -EFAULT.
> 
> The rest is just clean up.  get_user() actually returns zero on success
> and -EFAULT on error so we can preserve the error code.  The
> timeout_to_regval() function returns -EINVAL on failure, but we can
> propogate that back instead of hardcoding -EINVAL ourselves.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
