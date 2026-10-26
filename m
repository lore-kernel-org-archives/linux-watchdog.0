Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052550;
	b=Va4IHjocJRF1uG1nX2bb8mbDD17sWru4sxulzuRkbDilOOMWgPlbkJW1SgaehVs4D2h8
	 8WsJDzeEd185M5HsJG8glsL885E/udFh1e8dhk6ccmvW0Ykg3g4nAcb7ydukFXDMvBhYs
	 ulKnrcAMtJVLN0lGbPeWzqM2uAnCYBxhv8B//us/4FFgx/rMXtDpGg6/hGRc4BsCPgznN
	 XHMK0ecOjmhMxQFPLlyHRDQ55k0/oRqJqVPDulH9j1QymXkDmPfVNnbr8N4A9zd6vvWFy
	 S8rWjqACsXw45F5n18DwJu41/F8QCFZofMUIdlhNtCZHrXR2VEl2+6nn3kRZIDS/T1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052550;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=FNwW0nyhMLg4KJlCauTn+tJuiWsniccUKxCVBBhuIX4=;
	b=HumE/WQrtP5dXt/znV8mx5TIytchX8hkNcA8knERXiNpEZY5a7XwNFYpAkoj+EbuHtCv
	 UU2BbZsMtOGIqUEHHfyUFsWmAAObZROEN1XkYIoXuq+jNnpEjgjSxHEYwZupjdTKw70Wo
	 5aZmExYFQoHY+j5vUB1GOVg2rBw6MVbBxnQQRBc/9Rk/TWqmLq86isHIVVOc5n2fpzv0t
	 2NJL8uMJ4QGjD4dZJdbwW+57uV5aUJwPs/0Q22naScYL0tTeZfTCPwkDTsis6Q9H2+j4D
	 DrO/fjuNsaQwmJMZNLsCstIxGYSYPb/z6BhbbzIPZe17gPwL1trLIhSjo3PiceZnNpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=KLA9HlDc;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32D606A31D
	for <linux-watchdog@vger.kernel.org>; Mon, 26 Oct 2026 22:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A32D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=KLA9HlDc
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id LPpsxwPdSMylkLSsOx4rkn; Mon, 26 Oct 2026 22:09:08 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LSsNxhevjoYFCLSsOx8D1u; Mon, 26 Oct 2026 22:09:08 +0000
X-Authority-Analysis: v=2.4 cv=b4Cy4sGx c=1 sm=1 tr=0 ts=6adfcf84
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=iXiyidbvAAAA:8
 a=pGLkceISAAAA:8 a=jdP34snFAAAA:8 a=TlQaE0Xuup0GS2m4uVgA:9 a=CjuIK1q_8ugA:10
 a=RVmHIydaz68A:10 a=pkPhiurjdwHc21woUKjd:22 a=jlphF6vWLdwq7oh3TaWq:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FNwW0nyhMLg4KJlCauTn+tJuiWsniccUKxCVBBhuIX4=; b=KLA9HlDcosqcMx3+P89aMhhnBM
	FY30E8r272wXeEO4yuTNNFr4pl3WYbFChCqoSde1BCNETiWN4TC+15KTc8OfyiNZPzA4CJaIRPe09
	RlaVknXrF/qO9ZCkvussBA0IJSFhL0D7fXp+bZQutwKeWBe+9tr1zp3EkJBoKnXBPWzXCByXrfUBD
	i0zWl2dxHayiuEDMreuRigWjqh/0eUyFls1Pvo1BohOfxiQhgQAUzYACd3bJaLon1lgUkG63sDoxl
	VXmuIw/TxmXHfVju5G5gFZpWgf5VEFmiAau/u4CjSaaD6eJySjoC3nZDL2apsqs2ih+1pgzJqy9MQ
	hLeS9YVA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:53900 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLSsL-00000003sgJ-3QWo;
	Tue, 27 Oct 2026 03:39:05 +0530
Date: Mon, 26 Oct 2026 15:09:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, manuel.lauss@gmail.com
Subject: Re: [PATCH 5/5] watchdog: Remove the MTX-1 watchdog driver
Message-ID: <ab0512df-8f98-4a8c-b27d-bdace0e7f6d0@roeck-us.net>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <20261016221617.2223004-6-f.fainelli@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016221617.2223004-6-f.fainelli@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLSsL-00000003sgJ-3QWo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:53900
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 47
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD6Z6ndQKkiMYGTkK7+rVdM6oe13LpU2b19EzLMgeHfgMgj3NOfJdKPSEuwkyxQ4jxTZ1zhJ92CZ22qHnk8gRiFv1zGwXvDdrQ3FRvpc1nFuH4V0JXa8
 Ngw9+1440/rA1GZ8/huhTcGzG0FWffzYsbgZLiMji07oFPcdLfDIEhj0Wj8kBETaXz5tIxNxQla6PWj/FJbNgrncMrboww0RbVsYQm22xeG3dmmWOrHyo6jQ

On Fri, Oct 16, 2026 at 03:16:17PM -0700, Florian Fainelli wrote:
> MTX-1 now uses the generic GPIO watchdog driver with board properties
> describing its GPIO and heartbeat constraints. Remove the unused custom
> driver and its Kconfig and Makefile entries.
> 
> The watchdog core now supplies the character device, keepalive scheduling,
> timeout handling and close semantics previously implemented by this driver.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/watchdog/Kconfig     |   7 -
>  drivers/watchdog/Makefile    |   1 -
>  drivers/watchdog/mtx-1_wdt.c | 245 -----------------------------------
>  3 files changed, 253 deletions(-)
>  delete mode 100644 drivers/watchdog/mtx-1_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f50709c635e5..c884f86be4e3 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1865,13 +1865,6 @@ config JZ4740_WDT
>  	help
>  	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
>  
> -config WDT_MTX1
> -	tristate "MTX-1 Hardware Watchdog"
> -	depends on MIPS_MTX1 || (MIPS && COMPILE_TEST)
> -	help
> -	  Hardware driver for the MTX-1 boards. This is a watchdog timer that
> -	  will reboot the machine after a 100 seconds timer expired.
> -
>  config SIBYTE_WDOG
>  	tristate "Sibyte SoC hardware watchdog"
>  	depends on CPU_SB1
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9ac406677aba..19cb25f51624 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -172,7 +172,6 @@ obj-$(CONFIG_BCM47XX_WDT) += bcm47xx_wdt.o
>  obj-$(CONFIG_RC32434_WDT) += rc32434_wdt.o
>  obj-$(CONFIG_INDYDOG) += indydog.o
>  obj-$(CONFIG_JZ4740_WDT) += jz4740_wdt.o
> -obj-$(CONFIG_WDT_MTX1) += mtx-1_wdt.o
>  obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
>  obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
>  obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> deleted file mode 100644
> index f75426cfa425..000000000000
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ /dev/null
> @@ -1,245 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - *      Driver for the MTX-1 Watchdog.
> - *
> - *      (C) Copyright 2005 4G Systems <info@4g-systems.biz>,
> - *							All Rights Reserved.
> - *                              http://www.4g-systems.biz
> - *
> - *	(C) Copyright 2007 OpenWrt.org, Florian Fainelli <florian@openwrt.org>
> - *      (c) Copyright 2005    4G Systems <info@4g-systems.biz>
> - *
> - *      Release 0.01.
> - *      Author: Michael Stickel  michael.stickel@4g-systems.biz
> - *
> - *      Release 0.02.
> - *	Author: Florian Fainelli florian@openwrt.org
> - *		use the Linux watchdog/timer APIs
> - *
> - *      The Watchdog is configured to reset the MTX-1
> - *      if it is not triggered for 100 seconds.
> - *      It should not be triggered more often than 1.6 seconds.
> - *
> - *      A timer triggers the watchdog every 5 seconds, until
> - *      it is opened for the first time. After the first open
> - *      it MUST be triggered every 2..95 seconds.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/miscdevice.h>
> -#include <linux/fs.h>
> -#include <linux/ioport.h>
> -#include <linux/timer.h>
> -#include <linux/completion.h>
> -#include <linux/jiffies.h>
> -#include <linux/watchdog.h>
> -#include <linux/platform_device.h>
> -#include <linux/io.h>
> -#include <linux/uaccess.h>
> -#include <linux/gpio/consumer.h>
> -
> -#define MTX1_WDT_INTERVAL	(5 * HZ)
> -
> -static int ticks = 100 * HZ;
> -
> -static struct {
> -	struct completion stop;
> -	spinlock_t lock;
> -	int running;
> -	struct timer_list timer;
> -	int queue;
> -	int default_ticks;
> -	unsigned long inuse;
> -	struct gpio_desc *gpiod;
> -	unsigned int gstate;
> -} mtx1_wdt_device;
> -
> -static void mtx1_wdt_trigger(struct timer_list *unused)
> -{
> -	spin_lock(&mtx1_wdt_device.lock);
> -	if (mtx1_wdt_device.running)
> -		ticks--;
> -
> -	/* toggle wdt gpio */
> -	mtx1_wdt_device.gstate = !mtx1_wdt_device.gstate;
> -	gpiod_set_value(mtx1_wdt_device.gpiod, mtx1_wdt_device.gstate);
> -
> -	if (mtx1_wdt_device.queue && ticks)
> -		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
> -	else
> -		complete(&mtx1_wdt_device.stop);
> -	spin_unlock(&mtx1_wdt_device.lock);
> -}
> -
> -static void mtx1_wdt_reset(void)
> -{
> -	ticks = mtx1_wdt_device.default_ticks;
> -}
> -
> -
> -static void mtx1_wdt_start(void)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
> -	if (!mtx1_wdt_device.queue) {
> -		mtx1_wdt_device.queue = 1;
> -		mtx1_wdt_device.gstate = 1;
> -		gpiod_set_value(mtx1_wdt_device.gpiod, 1);
> -		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
> -	}
> -	mtx1_wdt_device.running++;
> -	spin_unlock_irqrestore(&mtx1_wdt_device.lock, flags);
> -}
> -
> -static int mtx1_wdt_stop(void)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
> -	if (mtx1_wdt_device.queue) {
> -		mtx1_wdt_device.queue = 0;
> -		mtx1_wdt_device.gstate = 0;
> -		gpiod_set_value(mtx1_wdt_device.gpiod, 0);
> -	}
> -	ticks = mtx1_wdt_device.default_ticks;
> -	spin_unlock_irqrestore(&mtx1_wdt_device.lock, flags);
> -	return 0;
> -}
> -
> -/* Filesystem functions */
> -
> -static int mtx1_wdt_open(struct inode *inode, struct file *file)
> -{
> -	if (test_and_set_bit(0, &mtx1_wdt_device.inuse))
> -		return -EBUSY;
> -	return stream_open(inode, file);
> -}
> -
> -
> -static int mtx1_wdt_release(struct inode *inode, struct file *file)
> -{
> -	clear_bit(0, &mtx1_wdt_device.inuse);
> -	return 0;
> -}
> -
> -static long mtx1_wdt_ioctl(struct file *file, unsigned int cmd,
> -							unsigned long arg)
> -{
> -	void __user *argp = (void __user *)arg;
> -	int __user *p = (int __user *)argp;
> -	unsigned int value;
> -	static const struct watchdog_info ident = {
> -		.options = WDIOF_CARDRESET,
> -		.identity = "MTX-1 WDT",
> -	};
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		if (copy_to_user(argp, &ident, sizeof(ident)))
> -			return -EFAULT;
> -		break;
> -	case WDIOC_GETSTATUS:
> -	case WDIOC_GETBOOTSTATUS:
> -		put_user(0, p);
> -		break;
> -	case WDIOC_SETOPTIONS:
> -		if (get_user(value, p))
> -			return -EFAULT;
> -		if (value & WDIOS_ENABLECARD)
> -			mtx1_wdt_start();
> -		else if (value & WDIOS_DISABLECARD)
> -			mtx1_wdt_stop();
> -		else
> -			return -EINVAL;
> -		return 0;
> -	case WDIOC_KEEPALIVE:
> -		mtx1_wdt_reset();
> -		break;
> -	default:
> -		return -ENOTTY;
> -	}
> -	return 0;
> -}
> -
> -
> -static ssize_t mtx1_wdt_write(struct file *file, const char *buf,
> -						size_t count, loff_t *ppos)
> -{
> -	if (!count)
> -		return -EIO;
> -	mtx1_wdt_reset();
> -	return count;
> -}
> -
> -static const struct file_operations mtx1_wdt_fops = {
> -	.owner		= THIS_MODULE,
> -	.unlocked_ioctl	= mtx1_wdt_ioctl,
> -	.compat_ioctl	= compat_ptr_ioctl,
> -	.open		= mtx1_wdt_open,
> -	.write		= mtx1_wdt_write,
> -	.release	= mtx1_wdt_release,
> -};
> -
> -
> -static struct miscdevice mtx1_wdt_misc = {
> -	.minor	= WATCHDOG_MINOR,
> -	.name	= "watchdog",
> -	.fops	= &mtx1_wdt_fops,
> -};
> -
> -
> -static int mtx1_wdt_probe(struct platform_device *pdev)
> -{
> -	int ret;
> -
> -	mtx1_wdt_device.gpiod = devm_gpiod_get(&pdev->dev,
> -					       NULL, GPIOD_OUT_HIGH);
> -	if (IS_ERR(mtx1_wdt_device.gpiod)) {
> -		dev_err(&pdev->dev, "failed to request gpio");
> -		return PTR_ERR(mtx1_wdt_device.gpiod);
> -	}
> -
> -	spin_lock_init(&mtx1_wdt_device.lock);
> -	init_completion(&mtx1_wdt_device.stop);
> -	mtx1_wdt_device.queue = 0;
> -	clear_bit(0, &mtx1_wdt_device.inuse);
> -	timer_setup(&mtx1_wdt_device.timer, mtx1_wdt_trigger, 0);
> -	mtx1_wdt_device.default_ticks = ticks;
> -
> -	ret = misc_register(&mtx1_wdt_misc);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to register\n");
> -		return ret;
> -	}
> -	mtx1_wdt_start();
> -	dev_info(&pdev->dev, "MTX-1 Watchdog driver\n");
> -	return 0;
> -}
> -
> -static void mtx1_wdt_remove(struct platform_device *pdev)
> -{
> -	/* FIXME: do we need to lock this test ? */
> -	if (mtx1_wdt_device.queue) {
> -		mtx1_wdt_device.queue = 0;
> -		wait_for_completion(&mtx1_wdt_device.stop);
> -	}
> -
> -	misc_deregister(&mtx1_wdt_misc);
> -}
> -
> -static struct platform_driver mtx1_wdt_driver = {
> -	.probe = mtx1_wdt_probe,
> -	.remove = mtx1_wdt_remove,
> -	.driver.name = "mtx1-wdt",
> -};
> -
> -module_platform_driver(mtx1_wdt_driver);
> -
> -MODULE_AUTHOR("Michael Stickel, Florian Fainelli");
> -MODULE_DESCRIPTION("Driver for the MTX-1 watchdog");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:mtx1-wdt");
