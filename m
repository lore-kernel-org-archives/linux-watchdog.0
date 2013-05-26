Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:48020 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751985Ab3EZNW3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 May 2013 09:22:29 -0400
Date: Sun, 26 May 2013 15:22:28 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: use dev_err()/dev_info() instead of pr_err()/pr_info()
Message-ID: <20130526132228.GA6609@spo001.leaseweb.com>
References: <005e01ce2053$7e483980$7ad8ac80$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005e01ce2053$7e483980$7ad8ac80$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> dev_err()/dev_info() are more preferred than pr_err()/pr_info().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/s3c2410_wdt.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.

