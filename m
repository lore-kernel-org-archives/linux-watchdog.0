Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D214BF97
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232218; cv=none; b=Yo56eNbzzXfhJFswxiY/56eWA1a/O4PAwInrDLMIrIBs46FRDnZO0gyLF4ooA0eRHTCbV2XnC7Rmo808IMOgOti42zVsBcLzQWb17RX5a0G0O0sMLXTQC3z/GgoS31rK8bSeRpQ2hNZNtQSiZkS/2fSjevlln4MoSUS1+1BAWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232218; c=relaxed/simple;
	bh=YruJhTuCQcA1pNWYpT0kZiicUeCFqkaIDWMdP3lkY74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNR6zJqOi39UffpO8Kj+ZRePS3GmGOoas01NXfUMiznmSqUiL22/KHhr1dyNziwqTsj/mbNQk8KYDAyc/ZWcxBqxevqmoYqnyJO2q5xgv3pcltW9YgP5XW5jht73LM4xUFJ/d1qow4K0fW7ikotx5d+zNNYi1Wys/s2R8kNw/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOHxEY7U; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOHxEY7U"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-133466cf955so14586973c88.0
        for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779232216; x=1779837016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pvg4B4i7RtBlyWLDY20uCxCQf7UHe9zuTqLIkzPr6NM=;
        b=sOHxEY7U32O3+JLdXnIw0Fo1Y6SQgxw+ogi3D54pQbOSUJXcLKBMWVHSu6a3fhp3cd
         Uc+SiYGsJyK9yRml0YAe/kluli3mupsvZJIw6jj9Kx69wphhPZIs5icBPa4Xzfs47CtJ
         y405xk3nJGhxlmVSJDXOhFbA9z28Z+A5QJ4YIUG4tahXjqi/cXwME9Px4rhY1omPF0Q+
         Al2mCbOFW+HWhKiaKWI9yQ1zbCt+ZJwutqnt4d9vMzw5YlzfaGq0GuHhnvaCkLPF8++x
         8Vxl5FhPynlIiZfY0cXtTroHNZSy3Ie65U6QJDMmpDsjeC3/DNZUNpt0vwKVXxMw49xT
         y9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779232216; x=1779837016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pvg4B4i7RtBlyWLDY20uCxCQf7UHe9zuTqLIkzPr6NM=;
        b=ds0vllWkf7mula7oPFEIgz+CEmECWKw8ZfNWxMcUO3ckoTcjS5qtBuAa8nykMKf5oJ
         uWTmmYBEV4TiAQe7gVVz+ZGwH7xtlFH5kXZkiwkuo9GCLff/LH4XYr7Iy7buhhx51eXX
         hBFaIgYEjt3ol8pH9aqXo57b0byQmRMEKs0PoYgajxf+0HH3sFIbcri8coeA0mF68qfk
         nVHkkjDqIe3SqzaqisBHl+xbvTfLr2XK6YD6CSIBRz8wyijAV2BICZ0ybn7d5ZYLxat9
         fQH7e6q1OxVl6FoQwy6OBBnGBb0PaeEplJYHdRO0O6wSdWtSLeU6SwnPdanKTxAiSiK8
         +wbg==
X-Gm-Message-State: AOJu0YyMQNQILMG2oZAk8Wvx4AYusPN9ZX2oAqr1xgmCqygrIFn+ORU8
	uS1jjq8Owe1odALRnqKIKN3QM3soY+xImGb2nnItXDbK1SDN+2fl6UvP4/WFQDbO
X-Gm-Gg: Acq92OEfQJoRkdf2aZnHVwPGE0eVKGJkiBU5mZNvbV8PkS//Fn6FwsoxQqfuDkVT0be
	CjtZ1pFml3av3liQ4Wz59w7a/jHruKx2Ae26m2NCCfa84hPy76GByVfHrvNq91sR6YnfJtTmIQd
	c8arxffkZzO2UsCkQeRE1LFOoDiSsf7MIy8CoX/vuwEeZ1dp3D/HHyo/Z1f9XeVUeOsAdNCwADH
	DlV2CNWvZcMMNg5uMLLR9avASpNqpC+c3U206MQ4y2vzFQxMAxctU6whmbWEJOaV7stwDmZjURY
	jd4m19v/ZjNKFezwP/OKnF6JdcWuEdwh3yb8zdbUSgaEN9GCHSWAAGJRrcM8YqL+xHxze9vfKXI
	mwMX/kEHxNAxPAbsxPskui57yuLm4jLRlLzI8wMz2dJj9dFoNh5KYf3d/KBR3sHJEfQEERa7UU0
	Gr/OaMhxUC5PXvJLxPXoVhPAtKq78zdrAQ39dU
X-Received: by 2002:a05:7022:6b9b:b0:130:9b78:b17b with SMTP id a92af1059eb24-13504a4fd4amr9391322c88.38.1779232215503;
        Tue, 19 May 2026 16:10:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cf44668asm20529774c88.6.2026.05.19.16.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:10:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 19 May 2026 16:10:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: ath79: convert to watchdog_device
Message-ID: <e20e7cba-a926-4796-b310-4aff3830ad69@roeck-us.net>
References: <20260519003326.625858-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519003326.625858-1-rosenp@gmail.com>

On Mon, May 18, 2026 at 05:33:26PM -0700, Rosen Penev wrote:
> Converts from the legacy miscdevice/file_operations interface to the

s/Converts/Convert/

> watchdog_device framework, simplifying the driver and properly handling
> EPROBE_DEFER.
> 
> Use wdd->timeout in all callbacks instead of a global, fix get_timeleft()
> to return seconds instead of raw clock ticks, store max_timeout in the
> watchdog_device struct, wire up nowayout via watchdog_set_nowayout(), pass
> the module parameter to watchdog_init_timeout(), add .owner to
> watchdog_ops, and remove the leftover file-ops state (wdt_flags and the
> busy/expect-close bits).
> 
> Tested on an Archer C7v2. sysupgrade watchdog handoff works fine.
> 
Sorry for having to ask, but is this real or an AI hallucination ?

> Assisted-by: Claude:Sonnet-4.6
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

$ scripts/checkpatch.pl --strict index.html.1
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#163: FILE: drivers/watchdog/ath79_wdt.c:62:
+static inline void ath79_wdt_wr(struct ath79_wdt *wdt, unsigned reg, u32 val)

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#170: FILE: drivers/watchdog/ath79_wdt.c:67:
+static inline u32 ath79_wdt_rr(struct ath79_wdt *wdt, unsigned reg)

Please run checkpatch --strict on your patches.

The patch does not apply to the tip of the watchdog-next branch.

$ git am -s -3 index.html
Applying: watchdog: ath79: convert to watchdog_device
error: sha1 information is lacking or useless (drivers/watchdog/ath79_wdt.c).
error: could not build fake ancestor

Please base it on a known reference so it can be applied.

Additional patches inline.

Thanks,
Guenter

> ---
>  drivers/watchdog/ath79_wdt.c | 244 +++++++++++------------------------
>  1 file changed, 73 insertions(+), 171 deletions(-)
> 
> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
> index 409a40b14901..d83957712c02 100644
> --- a/drivers/watchdog/ath79_wdt.c
> +++ b/drivers/watchdog/ath79_wdt.c
> @@ -15,13 +15,10 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

No longer needed.

>  
> -#include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> -#include <linux/fs.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> -#include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
> @@ -31,7 +28,6 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> -#include <linux/uaccess.h>
>  
>  #define DRIVER_NAME	"ath79-wdt"
>  
> @@ -57,37 +53,32 @@ module_param(timeout, int, 0);
>  MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
>  			  "(default=" __MODULE_STRING(WDT_TIMEOUT) "s)");
>  
> -static unsigned long wdt_flags;
> -
> -#define WDT_FLAGS_BUSY		0
> -#define WDT_FLAGS_EXPECT_CLOSE	1
> -
> -static struct clk *wdt_clk;
> -static unsigned long wdt_freq;
> -static int boot_status;
> -static int max_timeout;
> -static void __iomem *wdt_base;
> +struct ath79_wdt {
> +	void __iomem *base;
> +	unsigned long freq;
> +	struct watchdog_device wdd;
> +};
>  
> -static inline void ath79_wdt_wr(unsigned reg, u32 val)
> +static inline void ath79_wdt_wr(struct ath79_wdt *wdt, unsigned reg, u32 val)
>  {
> -	iowrite32(val, wdt_base + reg);
> +	iowrite32(val, wdt->base + reg);
>  }
>  
> -static inline u32 ath79_wdt_rr(unsigned reg)
> +static inline u32 ath79_wdt_rr(struct ath79_wdt *wdt, unsigned reg)
>  {
> -	return ioread32(wdt_base + reg);
> +	return ioread32(wdt->base + reg);
>  }
>  
> -static inline void ath79_wdt_keepalive(void)
> +static inline void ath79_wdt_keepalive(struct ath79_wdt *wdt)
>  {
> -	ath79_wdt_wr(WDOG_REG_TIMER, wdt_freq * timeout);
> +	ath79_wdt_wr(wdt, WDOG_REG_TIMER, wdt->freq * wdt->wdd.timeout);
>  	/* flush write */
> -	ath79_wdt_rr(WDOG_REG_TIMER);
> +	ath79_wdt_rr(wdt, WDOG_REG_TIMER);
>  }
>  
> -static inline void ath79_wdt_enable(void)
> +static inline void ath79_wdt_enable(struct ath79_wdt *wdt)
>  {
> -	ath79_wdt_keepalive();
> +	ath79_wdt_keepalive(wdt);
>  
>  	/*
>  	 * Updating the TIMER register requires a few microseconds
> @@ -97,202 +88,115 @@ static inline void ath79_wdt_enable(void)
>  	 */
>  	udelay(2);
>  
> -	ath79_wdt_wr(WDOG_REG_CTRL, WDOG_CTRL_ACTION_FCR);
> +	ath79_wdt_wr(wdt, WDOG_REG_CTRL, WDOG_CTRL_ACTION_FCR);
>  	/* flush write */
> -	ath79_wdt_rr(WDOG_REG_CTRL);
> +	ath79_wdt_rr(wdt, WDOG_REG_CTRL);
>  }
>  
> -static inline void ath79_wdt_disable(void)
> +static inline void ath79_wdt_disable(struct ath79_wdt *wdt)
>  {
> -	ath79_wdt_wr(WDOG_REG_CTRL, WDOG_CTRL_ACTION_NONE);
> +	ath79_wdt_wr(wdt, WDOG_REG_CTRL, WDOG_CTRL_ACTION_NONE);
>  	/* flush write */
> -	ath79_wdt_rr(WDOG_REG_CTRL);
> +	ath79_wdt_rr(wdt, WDOG_REG_CTRL);
>  }
>  
> -static int ath79_wdt_set_timeout(int val)
> +static int ath79_wdt_ping(struct watchdog_device *wdd)
>  {
> -	if (val < 1 || val > max_timeout)
> -		return -EINVAL;
> +	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);
>  
> -	timeout = val;
> -	ath79_wdt_keepalive();
> +	ath79_wdt_keepalive(wdt);
>  
>  	return 0;
>  }
>  
> -static int ath79_wdt_open(struct inode *inode, struct file *file)
> +static int ath79_wdt_set_timeout(struct watchdog_device *wdd, unsigned int val)
>  {
> -	if (test_and_set_bit(WDT_FLAGS_BUSY, &wdt_flags))
> -		return -EBUSY;
> +	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);
>  
> -	clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
> -	ath79_wdt_enable();
> +	wdd->timeout = val;
> +	ath79_wdt_keepalive(wdt);
>  
> -	return stream_open(inode, file);
> +	return 0;
>  }
>  
> -static int ath79_wdt_release(struct inode *inode, struct file *file)
> +static int ath79_wdt_start(struct watchdog_device *wdd)
>  {
> -	if (test_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags))
> -		ath79_wdt_disable();
> -	else {
> -		pr_crit("device closed unexpectedly, watchdog timer will not stop!\n");
> -		ath79_wdt_keepalive();
> -	}
> +	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);
>  
> -	clear_bit(WDT_FLAGS_BUSY, &wdt_flags);
> -	clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
> +	ath79_wdt_enable(wdt);
>  
>  	return 0;
>  }
>  
> -static ssize_t ath79_wdt_write(struct file *file, const char *data,
> -				size_t len, loff_t *ppos)
> +static unsigned int ath79_wdt_get_timeleft(struct watchdog_device *wdd)
>  {
> -	if (len) {
> -		if (!nowayout) {
> -			size_t i;
> -
> -			clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
> +	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);
>  
> -			for (i = 0; i != len; i++) {
> -				char c;
> -
> -				if (get_user(c, data + i))
> -					return -EFAULT;
> +	return ath79_wdt_rr(wdt, WDOG_REG_TIMER) / wdt->freq;
> +}
>  
> -				if (c == 'V')
> -					set_bit(WDT_FLAGS_EXPECT_CLOSE,
> -						&wdt_flags);
> -			}
> -		}
> +static int ath79_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct ath79_wdt *wdt = watchdog_get_drvdata(wdd);
>  
> -		ath79_wdt_keepalive();
> -	}
> +	ath79_wdt_disable(wdt);
>  
> -	return len;
> +	return 0;
>  }
>  
>  static const struct watchdog_info ath79_wdt_info = {
> -	.options		= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> -				  WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
> -	.firmware_version	= 0,
> -	.identity		= "ATH79 watchdog",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_CARDRESET,
> +	.firmware_version = 0,

Unnecessary; can be dropped.

> +	.identity = "ATH79 watchdog",
>  };
>  
> -static long ath79_wdt_ioctl(struct file *file, unsigned int cmd,
> -			    unsigned long arg)
> -{
> -	void __user *argp = (void __user *)arg;
> -	int __user *p = argp;
> -	int err;
> -	int t;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		err = copy_to_user(argp, &ath79_wdt_info,
> -				   sizeof(ath79_wdt_info)) ? -EFAULT : 0;
> -		break;
> -
> -	case WDIOC_GETSTATUS:
> -		err = put_user(0, p);
> -		break;
> -
> -	case WDIOC_GETBOOTSTATUS:
> -		err = put_user(boot_status, p);
> -		break;
> -
> -	case WDIOC_KEEPALIVE:
> -		ath79_wdt_keepalive();
> -		err = 0;
> -		break;
> -
> -	case WDIOC_SETTIMEOUT:
> -		err = get_user(t, p);
> -		if (err)
> -			break;
> -
> -		err = ath79_wdt_set_timeout(t);
> -		if (err)
> -			break;
> -		fallthrough;
> -
> -	case WDIOC_GETTIMEOUT:
> -		err = put_user(timeout, p);
> -		break;
> -
> -	default:
> -		err = -ENOTTY;
> -		break;
> -	}
> -
> -	return err;
> -}
> -
> -static const struct file_operations ath79_wdt_fops = {
> -	.owner		= THIS_MODULE,
> -	.write		= ath79_wdt_write,
> -	.unlocked_ioctl	= ath79_wdt_ioctl,
> -	.compat_ioctl	= compat_ptr_ioctl,
> -	.open		= ath79_wdt_open,
> -	.release	= ath79_wdt_release,
> -};
> -
> -static struct miscdevice ath79_wdt_miscdev = {
> -	.minor = WATCHDOG_MINOR,
> -	.name = "watchdog",
> -	.fops = &ath79_wdt_fops,
> +static const struct watchdog_ops ath79_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = ath79_wdt_start,
> +	.stop = ath79_wdt_stop,
> +	.ping = ath79_wdt_ping,
> +	.set_timeout = ath79_wdt_set_timeout,
> +	.get_timeleft = ath79_wdt_get_timeleft,
>  };
>  
>  static int ath79_wdt_probe(struct platform_device *pdev)
>  {
> +	struct ath79_wdt *wdt;
> +	struct clk *wdt_clk;
>  	u32 ctrl;
> -	int err;
>  
> -	if (wdt_base)
> -		return -EBUSY;
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
>  
> -	wdt_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(wdt_base))
> -		return PTR_ERR(wdt_base);
> +	wdt->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(wdt->base))
> +		return PTR_ERR(wdt->base);
>  
>  	wdt_clk = devm_clk_get_enabled(&pdev->dev, "wdt");
>  	if (IS_ERR(wdt_clk))
>  		return PTR_ERR(wdt_clk);
>  
> -	wdt_freq = clk_get_rate(wdt_clk);
> -	if (!wdt_freq)
> +	wdt->freq = clk_get_rate(wdt_clk);
> +	if (!wdt->freq)
>  		return -EINVAL;
>  
> -	max_timeout = (0xfffffffful / wdt_freq);
> -	if (timeout < 1 || timeout > max_timeout) {
> -		timeout = max_timeout;
> -		dev_info(&pdev->dev,
> -			"timeout value must be 0 < timeout < %d, using %d\n",
> -			max_timeout, timeout);
> -	}
> -
> -	ctrl = ath79_wdt_rr(WDOG_REG_CTRL);
> -	boot_status = (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;
> +	wdt->wdd.max_timeout = U32_MAX / wdt->freq;
>  
> -	err = misc_register(&ath79_wdt_miscdev);
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"unable to register misc device, err=%d\n", err);
> -		return err;
> -	}
> +	ctrl = ath79_wdt_rr(wdt, WDOG_REG_CTRL);
> +	wdt->wdd.bootstatus = (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;
>  
> -	return 0;
> -}
> +	wdt->wdd.info = &ath79_wdt_info;
> +	wdt->wdd.ops = &ath79_wdt_ops;
> +	wdt->wdd.min_timeout = 1;
> +	wdt->wdd.timeout = WDT_TIMEOUT;

Also:
	wdt->wdd.parent = &pdev->dev;

> +	watchdog_init_timeout(&wdt->wdd, timeout, &pdev->dev);
> +	watchdog_set_nowayout(&wdt->wdd, nowayout);
> +	watchdog_stop_on_reboot(&wdt->wdd);
>  
> -static void ath79_wdt_remove(struct platform_device *pdev)
> -{
> -	misc_deregister(&ath79_wdt_miscdev);
> -}
> +	watchdog_set_drvdata(&wdt->wdd, wdt);
>  
> -static void ath79_wdt_shutdown(struct platform_device *pdev)
> -{
> -	ath79_wdt_disable();
> +	return devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
>  }
>  
>  static const struct of_device_id ath79_wdt_match[] = {
> @@ -303,8 +207,6 @@ MODULE_DEVICE_TABLE(of, ath79_wdt_match);
>  
>  static struct platform_driver ath79_wdt_driver = {
>  	.probe		= ath79_wdt_probe,
> -	.remove		= ath79_wdt_remove,
> -	.shutdown	= ath79_wdt_shutdown,
>  	.driver		= {
>  		.name	= DRIVER_NAME,
>  		.of_match_table = ath79_wdt_match,
> @@ -314,7 +216,7 @@ static struct platform_driver ath79_wdt_driver = {
>  module_platform_driver(ath79_wdt_driver);
>  
>  MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X hardware watchdog driver");
> -MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
> -MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org");
> +MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
> +MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:" DRIVER_NAME);
