Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783085;
	b=x8Qs+nc9LDl2MSfele/smDJBG1g/aKTpoLJQOvmeZ6WmFiCMILa0W/glDg0s8b08zX//
	 Kr/7VrCyg7LtFpn3/fgD6Nf0x3Gv1ce3CffqqxbH7ogO5NXqE1btvvqX3dDd1Jtng7MVi
	 mF3Qgn/KbzwjFazzbAq1I6IfHeTDhzaxJq4jipOg9ll1dUiUKmhZfv2krV0i5cpwsaEJj
	 s9F0ZN0HTsJsJw/b/Dz2SrorK49tze/7SGEb9dJTrKQgd5NjWBKV1Ya7Dv//wLUnOTfB9
	 9mnFUw4/F9FXP5W3QWr1Im3O5qPON23tGq1W8AhMZjH9oC8i91EZoyYRARhXVxE8gnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783085;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=ZEo0RCkuB+G1P+dMTl+JdqE+nU+TtyxQ2YWAokX/k+E=;
	b=5B4e8HsvIGIgwHZl4VbvLK4oHPmdcCUMcUdkFKzt1fsrIzxmrdiJwxcyn1ZE5k4pmSzY
	 2fURIFGKgf1LiLMkBbaRjW2H0klD0sY77L9ipmifTZAW6UlYKx63B7Cn8I2dZvl/4ryNU
	 eY+Awz+N0F6MSiAAeFrLQ7E/66T5X1YVb3bQasCx5QoYT1vSTDsUHeRF88KJxeAg03KTZ
	 e4CiLoVZPeNUMZTkFKZo7qJ/qJQwMP/X/P/ImEqHHyOAb4GdPsQni7EHGNvQDeLKG1nTQ
	 Yf7s7fmhvvQwfXzPIGVW8ip3ly1GOD5KtpRoRal6FM4RMFjGDXxNM3kt6LghDozeQmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Jt9dwDYV;
	arc=none smtp.remote-ip=44.202.169.32
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935C606A31F
	for <linux-watchdog@vger.kernel.org>; Sun, 15 Nov 2026 22:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9935C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Jt9dwDYV
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id SebtxpnmWB830Sj4AxEc3X; Sun, 15 Nov 2026 22:51:18 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Sj49xhPwyxmi7Sj49xqGjR; Sun, 15 Nov 2026 22:51:18 +0000
X-Authority-Analysis: v=2.4 cv=KuFN2XWN c=1 sm=1 tr=0 ts=6afa3766
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=cm27Pg_UAAAA:8
 a=1XWaLZrsAAAA:8 a=f31WFe-OUQ4saVoOFyIA:9 a=CjuIK1q_8ugA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZEo0RCkuB+G1P+dMTl+JdqE+nU+TtyxQ2YWAokX/k+E=; b=Jt9dwDYVbP0LYcT/tMPfdaxAMJ
	cbyMMpEuR7PidUgFzfSsnYT28elVlvOzLSDEz89roSRYOPUEvAS+KDPjeqFcKGbnPLOnVjr9GGvrb
	7fb5iwL3VR9AWrSCfPuFjg1k9WCp+Im0P3I9C0h7FAFjTqqwizR1qRWXGP5ovM9vwade39NvD6fJn
	lJr3vymcGJCsWrHqWon2oLrs80c+1OJxDLEYl9+AWUPbqPhoCkC88WC5FewE4ZiXMoJFHIHr3pYjP
	4gRj0EApfIfyPE0th7+RXt92H0AOWCnjZ6iTr77cxDa8YFisgQbwcj83k1L30vomgzT2LKAB6yClG
	zlmL1JwA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55486 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSj49-00000000oYp-0Yzc;
	Mon, 16 Nov 2026 04:21:17 +0530
Date: Sun, 15 Nov 2026 14:51:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mayank Rungta <mrungta@google.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Marc Zyngier <maz@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	"Kirill A . Shutemov" <kas@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 5/7] watchdog: pretimeout: Protect governor access
 with RCU for NMI safety
Message-ID: <9da7693d-4cac-466e-a3c1-bbe491fcff0c@roeck-us.net>
References: <20261112031629.396819-1-mrungta@google.com>
 <20261112031629.396819-6-mrungta@google.com>
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
In-Reply-To: <20261112031629.396819-6-mrungta@google.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xSj49-00000000oYp-0Yzc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:55486
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 11
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGFV8cljN+H7MFJMYK6G8BDvDzgJQCTCvin20JO/GhhLhV3WCJEnpym9WtBGjRTX5NpjrB5qwJLSWr95NFWTeW6G0LbQuEcEuq5ruO+MBsc76KyYN4F8
 j+Srx4nyoRuHfBosr+RHI44M/bHqjn+tvNUpyIfEK8aNXBaz0im0t40r7mWXhKzBGnnwPnfU9zNDyBcIZ8qwd1HOzFPqzbPNlVW0bd54dF5OLMgHkHmfMAPW

On Wed, Nov 11, 2026 at 07:16:27PM -0800, Mayank Rungta wrote:
> When watchdog pretimeout interrupts are configured as NMIs (or
> pseudo-NMIs), pretimeout handlers execute in NMI context. Accessing
> the watchdog governor via spinlocks in watchdog_notify_pretimeout() is
> unsafe in NMI context and can cause deadlocks if an NMI arrives while a
> spinlock is held.
> 
> Protect governor assignment and dereference with RCU instead of
> spinlocks, allowing lockless, NMI-safe governor notifications while
> preserving safe runtime governor switching.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Mayank Rungta <mrungta@google.com>

This patch is independent of the rest of the series, so I applied it
to wachdog-next.

Thanks,
Guenter

> ---
>  drivers/watchdog/watchdog_pretimeout.c | 45 ++++++++++++++------------
>  include/linux/watchdog.h               |  2 +-
>  2 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
> index 02e09b9e396d..7fb586c77403 100644
> --- a/drivers/watchdog/watchdog_pretimeout.c
> +++ b/drivers/watchdog/watchdog_pretimeout.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/list.h>
> +#include <linux/rcupdate.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> @@ -67,12 +68,14 @@ int watchdog_pretimeout_available_governors_get(char *buf)
>  
>  int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf)
>  {
> +	const struct watchdog_governor *gov;
>  	int count = 0;
>  
> -	spin_lock_irq(&pretimeout_lock);
> -	if (wdd->gov)
> -		count = sysfs_emit(buf, "%s\n", wdd->gov->name);
> -	spin_unlock_irq(&pretimeout_lock);
> +	rcu_read_lock();
> +	gov = rcu_dereference(wdd->gov);
> +	if (gov)
> +		count = sysfs_emit(buf, "%s\n", gov->name);
> +	rcu_read_unlock();
>  
>  	return count;
>  }
> @@ -91,7 +94,7 @@ int watchdog_pretimeout_governor_set(struct watchdog_device *wdd,
>  	}
>  
>  	spin_lock_irq(&pretimeout_lock);
> -	wdd->gov = priv->gov;
> +	rcu_assign_pointer(wdd->gov, priv->gov);
>  	spin_unlock_irq(&pretimeout_lock);
>  
>  	mutex_unlock(&governor_lock);
> @@ -101,16 +104,13 @@ int watchdog_pretimeout_governor_set(struct watchdog_device *wdd,
>  
>  void watchdog_notify_pretimeout(struct watchdog_device *wdd)
>  {
> -	unsigned long flags;
> +	const struct watchdog_governor *gov;
>  
> -	spin_lock_irqsave(&pretimeout_lock, flags);
> -	if (!wdd->gov) {
> -		spin_unlock_irqrestore(&pretimeout_lock, flags);
> -		return;
> -	}
> -
> -	wdd->gov->pretimeout(wdd);
> -	spin_unlock_irqrestore(&pretimeout_lock, flags);
> +	rcu_read_lock();
> +	gov = rcu_dereference(wdd->gov);
> +	if (gov)
> +		gov->pretimeout(wdd);
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL_GPL(watchdog_notify_pretimeout);
>  
> @@ -140,8 +140,8 @@ int watchdog_register_governor(struct watchdog_governor *gov)
>  		default_gov = gov;
>  
>  		list_for_each_entry(p, &pretimeout_list, entry)
> -			if (!p->wdd->gov)
> -				p->wdd->gov = default_gov;
> +			if (!rcu_access_pointer(p->wdd->gov))
> +				rcu_assign_pointer(p->wdd->gov, default_gov);
>  		spin_unlock_irq(&pretimeout_lock);
>  	}
>  
> @@ -170,11 +170,14 @@ void watchdog_unregister_governor(struct watchdog_governor *gov)
>  	if (default_gov == gov)
>  		default_gov = NULL;
>  	list_for_each_entry(p, &pretimeout_list, entry)
> -		if (p->wdd->gov == gov)
> -			p->wdd->gov = default_gov;
> +		if (rcu_dereference_protected(p->wdd->gov,
> +					      lockdep_is_held(&pretimeout_lock)) == gov)
> +			rcu_assign_pointer(p->wdd->gov, default_gov);
>  	spin_unlock_irq(&pretimeout_lock);
>  
>  	mutex_unlock(&governor_lock);
> +
> +	synchronize_rcu();
>  }
>  EXPORT_SYMBOL(watchdog_unregister_governor);
>  
> @@ -192,7 +195,7 @@ int watchdog_register_pretimeout(struct watchdog_device *wdd)
>  	spin_lock_irq(&pretimeout_lock);
>  	list_add(&p->entry, &pretimeout_list);
>  	p->wdd = wdd;
> -	wdd->gov = default_gov;
> +	rcu_assign_pointer(wdd->gov, default_gov);
>  	spin_unlock_irq(&pretimeout_lock);
>  
>  	return 0;
> @@ -206,7 +209,7 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
>  		return;
>  
>  	spin_lock_irq(&pretimeout_lock);
> -	wdd->gov = NULL;
> +	rcu_assign_pointer(wdd->gov, NULL);
>  
>  	list_for_each_entry_safe(p, t, &pretimeout_list, entry) {
>  		if (p->wdd == wdd) {
> @@ -216,4 +219,6 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
>  		}
>  	}
>  	spin_unlock_irq(&pretimeout_lock);
> +
> +	synchronize_rcu();
>  }
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 29cd03686154..5a3c35968cc8 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -105,7 +105,7 @@ struct watchdog_device {
>  	const struct attribute_group **groups;
>  	const struct watchdog_info *info;
>  	const struct watchdog_ops *ops;
> -	const struct watchdog_governor *gov;
> +	const struct watchdog_governor __rcu *gov;
>  	unsigned int bootstatus;
>  	unsigned int timeout;
>  	unsigned int pretimeout;
