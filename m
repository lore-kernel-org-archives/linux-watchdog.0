Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:41509 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbaIVQRq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Sep 2014 12:17:46 -0400
Date: Mon, 22 Sep 2014 09:17:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: wim@iguana.be, groeck7@gmail.com, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: Add power management support.
Message-ID: <20140922161741.GA16555@roeck-us.net>
References: <1411380052-48655-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411380052-48655-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 22, 2014 at 06:00:52PM +0800, Xiubo Li wrote:
> Add power management operations(suspend and resume) as part of
> dev_pm_ops for IMX2 watchdog driver.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
