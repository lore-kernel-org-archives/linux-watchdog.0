Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792458123;
	b=SYJyq9AXr2yZIHqNQQFPXNQzPSL+90dDcRA5kumSamszfVeK8ddYhVfq0TDFCoJCmUOT
	 hNLmhwm1UrnG2t5HzE0gakbsPNNeziOh3r27RpNLc7m6VZ9VRLUwK8wlGf/TvCvFsYzRN
	 8PPPJRFlCMiqFqfLaIWBnNE6WeMuOvp+rtRjn32ZrOGlUlak9EBM2enEqGpmOgUagIebJ
	 K0+80Xi3DXDqkxLaXBnEdCtxmdzZLidBrUrDhs8moTMga5723vbB1De1zhfBXOP1I/o4O
	 9wb3Kn58+bOJG1pEtZQEZLbAaeb//IssXAYU+jvS5aUr8ROiGl2wdSqFVEx4A/qsMXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R9usnc16iKCjMPPstDHo9+z0rA3zLdsFdUBRIbc7t80=;
	b=BDQ6n/Fr3yTYcB+2PDAtkTMIQCe5imGgpeIp5MydWhHm4RRSUlZaGj4niLbR1MKB/Xq9
	 hgSzMs6sXcs+jxsi0Mk1o1YJd00RMBA7fKyrVptv8y33ViJ1VmYQBRuCkbqa/bq6fX9OT
	 WFlMo0TEHgvm4Wb8sjzphAWXGExRs9ve/vAVnnOiqJBYr9Z1L/tzhs/k/na6uwsEDs+tR
	 iD1atXiJpo+j0cdeMW1H0YYfIdwGRkH/CyduUAyyy1UZK+WAoVy1Zu3z2FCfiAPP8kFQg
	 Jm2w38Nr+vjI0NRcjkJrVcVa51voww1wtAqYbcqQtuEH14ITMDRyMtsQQ0Llu7tmV1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtC8pKFV;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5D606A31A
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A5D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtC8pKFV
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso503754b3a.2
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792458122; x=1793062922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9usnc16iKCjMPPstDHo9+z0rA3zLdsFdUBRIbc7t80=;
        b=mtC8pKFVRwN3NTZCc6oP1X/SvObouMMi2JU2Ac90AkCwiuGwaU8Xg3ARGB+SEPdjIz
         6UoLh7kz8rouEytAJo4ztrsfwDogWzhrKbuxMiIcaIlqEfCoLiZCMj+nTi5TX2mcGXw7
         IRga/UOuB/59stCfhNIhfy1IK2IIBmwlyBtTqOKfI+5GE4HYL1lxt2zO9e3uFoLFkwhY
         R3xp6FK9HdAg2q79mT/GVtEYYpy3ESEXnWTCk+0uF0NLU/aKCUPE/4p1j74Z3bibjxxr
         Bn4evLdmUgZef9tTMnT2nfkuatxU1Q0wLa6gt/37UCPTlMjdJAp82o6CnwMV+bumgs+f
         613Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792458122; x=1793062922;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R9usnc16iKCjMPPstDHo9+z0rA3zLdsFdUBRIbc7t80=;
        b=f4lqMroH8Zmi/bM3aeW5mSthuTY/W+CblL4Iou/8gVL7EOCo7TlAvEqNVCntpNRPGm
         Q1vsVR0e0TFYbC/H5/qSAEcwcVj/ajD4kST5N3yrIJ6HknvOjT84sc8FFYzarxK2VqAs
         AU1GEwl48Iu9FT2wcq/oQErZEJxb9eY1X6E3QpjGI2VOnAId5ySPSmz5TV//JJOi1Lg7
         0Nl6N3Jfo5I55wG1QNKYClMUGB2HXzkMy93dAWRmZqFQv/QB5jkpXXJkleccePlLBT7h
         jGKdiQxc+Vkf2kmMrJAmw/u4SowYw4ZQKxkx20+Dwwvw7zyw9Oln//1RjZlWk38TFwe1
         6upQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2VFKpQZlXfotSe5tOfbtX4PRzBJ1dTY+e1NCva82s/WUM0bEnsRpoP2YsuYVr94x9ejM0dvl+HEkKw/hwKA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ65YjSXn0rZaW5ASoRF0t7twHJVF5SJhWtJDIcwFxH/pJnOp7M
	BrkarcYJVELvhykw5Y719EQzurWsxyZSubj+JDROzlr5lePIr2OntxGu
X-Gm-Gg: AYBFou2yvCsm95zkTvWSOFRU5KGfJVCJn7Zh3Ex+yy2PLlJPEQT7RWacj6bhNC24ORU
	Urio1bTkHe9Qv5erfv6jnXbSlCCEhJzMAZEBC+YhvlJaunas23vWT/Iu564zgaszDGTeEX9DcI6
	9n8AMXArGObZIlAhN3VKIprQuxWhBO3suaTPqLZDjbPiW4rUk0SOlTopSKIekYS5jDJT4zCwWmq
	VN3lzgp+Y+28iSkJ0nf9NnZgf3ifg01nt8p+3Ebqnmj7uwYJqHpVEAHitsZ7gnrz5Tq/nx+zGfl
	XJjvIunbMGE/Fe83p0c6KaAwxON3u65FreGcy8Jf1rmiDBhlait6m/7Mur47obvd4RkaCbn3hux
	efgcLefHcmHH3nY8IKtE3udH2wo3Ya8H9uYB/sasWZLmjs/PDlgASgoXiwCQ0a3qUlMCWk3lqnc
	KszbO0m6ksrPl/mK7Ln34JynfeNeVKSKn1diSiCd+/ht+Qkv95nUBKMhELEM3JMwLvYewwEKTJp
	gs0Cuj7xEUqkt1wVi+/6sKxMa3dwTfcRS+1CwwkVuzFUbkC
X-Received: by 2002:a05:6a00:8018:b0:899:9267:3a9d with SMTP id d2e1a72fcca58-8a04d35554fmr7086947b3a.59.1792458122070;
        Mon, 19 Oct 2026 18:02:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f579464besm4556361b3a.34.2026.10.19.18.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 18:02:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <41ba756d-de43-483e-9cf5-f7640a802c8f@roeck-us.net>
Date: Mon, 19 Oct 2026 18:01:58 -0700
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] watchdog: Remove the MTX-1 watchdog driver
To: Florian Fainelli <f.fainelli@gmail.com>, linux-mips@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Robert Marko <robert.marko@sartura.hr>,
 "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 manuel.lauss@gmail.com
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <20261016221617.2223004-6-f.fainelli@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261016221617.2223004-6-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 15:16, Florian Fainelli wrote:
> MTX-1 now uses the generic GPIO watchdog driver with board properties
> describing its GPIO and heartbeat constraints. Remove the unused custom
> driver and its Kconfig and Makefile entries.
> 
> The watchdog core now supplies the character device, keepalive scheduling,
> timeout handling and close semantics previously implemented by this driver.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig     |   7 -
>   drivers/watchdog/Makefile    |   1 -
>   drivers/watchdog/mtx-1_wdt.c | 245 -----------------------------------
>   3 files changed, 253 deletions(-)
>   delete mode 100644 drivers/watchdog/mtx-1_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f50709c635e5..c884f86be4e3 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1865,13 +1865,6 @@ config JZ4740_WDT
>   	help
>   	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
>   
> -config WDT_MTX1
> -	tristate "MTX-1 Hardware Watchdog"
> -	depends on MIPS_MTX1 || (MIPS && COMPILE_TEST)
> -	help
> -	  Hardware driver for the MTX-1 boards. This is a watchdog timer that
> -	  will reboot the machine after a 100 seconds timer expired.
> -
>   config SIBYTE_WDOG
>   	tristate "Sibyte SoC hardware watchdog"
>   	depends on CPU_SB1
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9ac406677aba..19cb25f51624 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -172,7 +172,6 @@ obj-$(CONFIG_BCM47XX_WDT) += bcm47xx_wdt.o
>   obj-$(CONFIG_RC32434_WDT) += rc32434_wdt.o
>   obj-$(CONFIG_INDYDOG) += indydog.o
>   obj-$(CONFIG_JZ4740_WDT) += jz4740_wdt.o
> -obj-$(CONFIG_WDT_MTX1) += mtx-1_wdt.o
>   obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
>   obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
>   obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
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

