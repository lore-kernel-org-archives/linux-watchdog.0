Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64565 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaFJT02 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 Jun 2014 15:26:28 -0400
Received: by mail-pa0-f45.google.com with SMTP id hz1so1036909pad.32
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Jun 2014 12:26:27 -0700 (PDT)
Date: Tue, 10 Jun 2014 12:26:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v2] watchdog: imx2_wdt: adds big endianness support.
Message-ID: <20140610192619.GD7773@roeck-us.net>
References: <1401763514-32589-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1401763514-32589-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 03, 2014 at 10:45:14AM +0800, Xiubo Li wrote:
> This watchdog driver will be working on IMX2+, Vybrid, LS1, LS2+
> platforms, and will be in different endianness mode in those SoCs:
> 
>     SoCs       WDT endian mode
> ------------------------------------
>     IMX2+           LE
>     Vybird          LE
>     LS1             BE
>     LS2             LE
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
