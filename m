Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129750;
	b=XKvphmyy5rcsTppm8RaLSH+GvJZoT60ybXFow3wsb2NR8d/8TCi8QfN8lc7wKG1dDUtU
	 6VgDN2oxxtlbiCFGXgmnq75RGsraAXzvUZOGT97oAhmYxBvnANd2VXKH+tMQN1qk11VxF
	 9Vw31nJxpBLUpx1o/H/CAiPwH6m4o3AuH6XBno1pwMjyrMJOgTNgdfcE2eRKouWbJXVnh
	 KwoHJEVJ7FGNWy8KTyoR1tS3Hc7AJsqkl+fWyBuscfAJh7LqLUqLwWeUJQKQ4Xuht5+/x
	 /R2VKrWb8GW/RQTL8TESNIJnANOA98R3BHtEEIeW387DpPlJaOil/gPF7OVL0DUhGZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129750;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=qhifMe5NrdJSN43xLGwAD+PaYWNRHWl8G+fKLSm9XzA=;
	b=FsvpQHsjcLpyxbv1kgYxeB1njjmvF+VykB3zT6phaP25uB3EwxVg2IaOo/dlmBNUqeqJ
	 LIB8z2zhoXmcJ/bS5itcIyBb9bv0IV4T70NN11llMQ1kq33bCF7QyJkYGHISjlkvtqzox
	 QT871mm3Mv3KyS1HzIpPkbx7p4WQlAfUhigYQO4g0xhBCp80B29TQIOLhdwiAbw+kwIT7
	 5nrzP95Ob997eyViRArjQz6DYq3K7MJQfq/ALzwNokioGG1r9FLEpl21QodH6W8RL6lKk
	 tBkqh55JSZmND7Ankr+CWDImKV1su5xB+4qISBl/QTor1Nul6IHp51MbbtyOhfuMLqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="MtjO/rMz";
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB0606A31A
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 19:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CFB0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=MtjO/rMz
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id Lkn0x9aqmLvgbLmxYxxnr4; Tue, 27 Oct 2026 19:35:48 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LmxXxyirpnR4vLmxXxxyKR; Tue, 27 Oct 2026 19:35:48 +0000
X-Authority-Analysis: v=2.4 cv=dfaA3WXe c=1 sm=1 tr=0 ts=6ae0fd14
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=P-IC7800AAAA:8
 a=6E73B9sLp_2llvq6DD8A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=qhifMe5NrdJSN43xLGwAD+PaYWNRHWl8G+fKLSm9XzA=; b=MtjO/rMz1XpM
	meCGcP8d2eVBdddohQhETLJ93I2YXb/fn/1mvyyENvsiVdMfHAUZQhjdhhxK7ZuDZ8DAwEXXVJwqz
	HzylN+hUsPNHOaDzKlQk92bypKD/ELJliCl9fwOBQ4v3j2k0kC8iEUNGgjuXbEkB+vsyf0GWz8lce
	YwGUcyun2hn0ctmaqS7OX4OnMoxFp8vQ4iWqWKCiDilFT9q0SUbnl1/W4ZUHVPyDgchgCoH6tQW2X
	2t4ajuuh5n17tdK4caGVfCYNWMziOVOVv3uIX7UaunyqG9CiraB0KM5YLShftaKYfPaT6e9WURJ2N
	yEQ+XXeqNNxnLlnMnKmSMw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58280)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLmxX-00000002TLI-0ZxZ;
	Wed, 28 Oct 2026 01:05:47 +0530
Message-ID: <865349b3-77a5-406e-96e6-f8187ae112ad@roeck-us.net>
Date: Tue, 27 Oct 2026 12:35:45 -0700
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
Subject: Re: [PATCH v5 5/5] watchdog: w83627hf_wdt: Add minute mode counting
To: Paul Louvel <paul.louvel@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
 <20261020-w83627hf_wdt-improvements-v5-5-90b226684fc7@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-5-90b226684fc7@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLmxX-00000002TLI-0ZxZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:58280
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBKUcVKVI2nluEKtPo8+5s1QL8EHonAJoCv6J5WoT0as30mUFs5feQqS3w4MEK7R7Np6dnnLCRn3VWeBTlKJPbUx8bh3h1t2cPsRdI7l7yGbWJZuXTIl
 vxlbiN/mlc4+xvx4zIpQC4KA5zujIjaNngh7nakjgWkOss0Us7jjGbm9wqFSplp3/4/RNPG3L3oi/2i+8rAZoIaecI4KmG9FhUoQ0jReLGp4gGw/4EeQ0HBI

On 10/20/26 01:11, Paul Louvel wrote:
> All of the chips supported by the driver can be set to minute mode,
> allowing timeout value up to 255 minutes.
> Add it to the driver.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>   drivers/watchdog/w83627hf_wdt.c | 68 +++++++++++++++++++++++++++++++----------
>   1 file changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index 3d6f35e79631..c45d5b9b97b7 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -40,6 +40,7 @@
>   
>   #define WATCHDOG_NAME "w83627hf/thf/hg/dhg WDT"
>   #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
> +#define WATCHDOG_MAX_TIMEOUT (255 * 60)
>   
>   enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>   	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
> @@ -49,7 +50,8 @@ enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>   static int timeout;			/* in seconds */
>   module_param(timeout, int, 0);
>   MODULE_PARM_DESC(timeout,
> -		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
> +		"Watchdog timeout in seconds. 1 <= timeout <= "
> +				__MODULE_STRING(WATCHDOG_MAX_TIMEOUT) ", default="
>   				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -139,6 +141,9 @@ struct w83627hf_data {
>   	struct watchdog_info info;
>   	const struct w83627hf_reg *reg;
>   	const struct w83627hf_sio_pdata *sio;
> +	bool minute_mode;
> +	u8 early_timer_val;
> +	u8 timer_val;
>   };
>   
>   static void superio_outb(int base, int reg, int val)
> @@ -258,21 +263,10 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>   		break;
>   	}
>   
> -	t = superio_inb(data->sio->addr, data->reg->timeout);
> -	if (t != 0) {
> -		if (early_disable) {
> -			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
> -			superio_outb(data->sio->addr, data->reg->timeout, 0);
> -		} else {
> -			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
> -				wdog->timeout);
> -			superio_outb(data->sio->addr, data->reg->timeout, wdog->timeout);
> -			set_bit(WDOG_HW_RUNNING, &wdog->status);
> -		}
> -	}
> +	data->early_timer_val = superio_inb(data->sio->addr, data->reg->timeout);
>   
>   	t = superio_inb(data->sio->addr, data->reg->control) &
> -	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
> +	    ~WDT_CTRL_RISING_EDGE_KBD_RESET;
>   	superio_outb(data->sio->addr, data->reg->control, t);
>   
>   	t = superio_inb(data->sio->addr, data->reg->csr);
> @@ -290,6 +284,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>   static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
>   {
>   	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
> +	unsigned char ctrl;
>   	int ret;
>   
>   	ret = superio_enter(data->sio->addr, data->sio->cfg_enter);
> @@ -297,6 +292,15 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
>   		return ret;
>   
>   	superio_select(data->sio->addr, W83627HF_LD_WDT);
> +
> +	ctrl = superio_inb(data->sio->addr, data->reg->control);
> +
> +	if (data->minute_mode)
> +		ctrl |= WDT_CTRL_MINUTE_MODE;
> +	else
> +		ctrl &= ~WDT_CTRL_MINUTE_MODE;
> +
> +	superio_outb(data->sio->addr, data->reg->control, ctrl);
>   	superio_outb(data->sio->addr, data->reg->timeout, timeout);
>   	superio_exit(data->sio->addr, data->sio->cfg_leave);
>   
> @@ -305,7 +309,9 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
>   
>   static int wdt_start(struct watchdog_device *wdog)
>   {
> -	return wdt_set_time(wdog, wdog->timeout);
> +	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
> +
> +	return wdt_set_time(wdog, data->timer_val);
>   }
>   
>   static int wdt_stop(struct watchdog_device *wdog)
> @@ -315,6 +321,17 @@ static int wdt_stop(struct watchdog_device *wdog)
>   
>   static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
>   {
> +	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
> +
> +	if (timeout > 255) {
> +		data->minute_mode = true;
> +		data->timer_val = DIV_ROUND_UP(timeout, 60);
> +		timeout = data->timer_val * 60;
> +	} else {
> +		data->minute_mode = false;
> +		data->timer_val = timeout;
> +	}
> +
>   	wdog->timeout = timeout;
>   
>   	return 0;
> @@ -332,6 +349,8 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
>   
>   	superio_select(data->sio->addr, W83627HF_LD_WDT);
>   	timeleft = superio_inb(data->sio->addr, data->reg->timeout);
> +	if (data->minute_mode)
> +		timeleft *= 60;
>   	superio_exit(data->sio->addr, data->sio->cfg_leave);
>   
>   	return timeleft;
> @@ -504,7 +523,7 @@ static int wdt_probe(struct platform_device *pdev)
>   	wdd->ops = &wdt_ops;
>   	wdd->timeout = WATCHDOG_TIMEOUT;
>   	wdd->min_timeout = 1;
> -	wdd->max_timeout = 255;
> +	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
>   
>   	switch (chip) {
>   	case nct6102:
> @@ -526,10 +545,27 @@ static int wdt_probe(struct platform_device *pdev)
>   	watchdog_set_nowayout(wdd, nowayout);
>   	watchdog_stop_on_reboot(wdd);
>   
> +	wdt_set_timeout(wdd, wdd->timeout);
> +
>   	ret = w83627hf_init(wdd, chip);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "failed to initialize watchdog\n");
>   
> +	if (data->early_timer_val) {
> +		if (early_disable) {

The purpose of this flag is specifically to disable the watchdog
"at module load time or kernel boot time". Moving it into the probe
function would delay that and is therefore undesirable.

On top of that, the flag is pointless in the probe function since
the watchdog core takes care of pinging the watchdog until
userspace kicks in if WDOG_HW_RUNNING is set.

Also, any change made in that regard should be independent of
introducing minute mode support.

Thanks,
Guenter

> +			dev_warn(dev, "Stopping previously enabled watchdog until userland kicks in\n");
> +			ret = wdt_stop(wdd);
> +		} else {
> +			dev_info(dev, "Watchdog already running. Resetting timeout to %d sec\n",
> +				 wdd->timeout);
> +			ret = wdt_start(wdd);
> +			set_bit(WDOG_HW_RUNNING, &wdd->status);
> +		}
> +
> +		if (ret)
> +			return ret;
> +	}
> +
>   	ret = devm_watchdog_register_device(dev, wdd);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "failed to register watchdog\n");
> 

