Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39314 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752607Ab3J2Ho1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 03:44:27 -0400
Date: Tue, 29 Oct 2013 08:44:26 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] watchdog: ts72xx_wdt: cleanup return codes in ioctl
Message-ID: <20131029074426.GA19704@spo001.leaseweb.com>
References: <20130823093832.GL31293@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130823093832.GL31293@elgon.mountain>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Dan,

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

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

